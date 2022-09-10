#!/bin/zsh
zmodload zsh/datetime

TOKEN=$TMPDIR.aqitoken
CACHE=$TMPDIR.aqidata
MAXAGE=86400 # 1 day in seconds
MAXRETRY=2
DOMAIN=map.purpleair.com
source $DOTFILES/modules/aqi/loc.env

# TODO get fancy and abstract

C_OK=0
C_NONE=101
C_EXPIRED=102
C_AUTH=401
C_RETRY_LIMIT=111

function log() {
  # echo "$@" >&2
}

function getCacheState() {
  local file=$1;
  local maxage=${2:-$MAXAGE}

  if ! [[ -s $file ]]; then
    # not file exists or is empty
    return $C_NONE
  fi

  local age;
  local mtime;
  mtime=$(stat -f'%m' $file)
  (( age = $EPOCHSECONDS - mtime ))
  log cache hit $file age $age max $maxage
  if [[ $age -gt $maxage ]]; then
    log EXPIRED age: $age max: $maxage
    return $C_EXPIRED
  fi
}

function cacheFile() {
  local key=$1;
  print "${TMPDIR}.aqi$key"
}

# usage: readThruCache "key" "refreshFn" "maxage"
#  refreshFn is a function that prints the new value, called if needed
#  maxage (optional) is seconds ttl to cache
#  prints the value or returns non-zero
function readThruCache() {
  local key=$1;
  local refreshFn=$2
  local maxage=$3
  local file="${TMPDIR}.aqi$key"

  getCacheState $file $maxage
  local state=$?
  log
  log "read $key ($file) -> $state"

  case $state in
    $C_OK)
      cat $file
      return $?
      ;;
    $C_EXPIRED)
      ;&
    $C_NONE)
      if [[ $MAXRETRY -gt 0 ]]; then
        (( MAXRETRY = $MAXRETRY - 1 ))
        log "  trying $refreshFn ($MAXRETRY)"
        local out
        out=$($refreshFn)
        local ret=$?
        # TODO need to be able to handle a new state here eg for auth
        print $out > $file
        readThruCache $key $refreshFn
        return $?
      else
        log out of retries
        return $C_RETRY_LIMIT
      fi
      ;;
    esac
    return 1
}

function getToken() {
  readThruCache "token" "refreshToken" 86400 # 1 day in seconds
}

function refreshToken() {
  log refreshToken
  local newToken;
  newToken=$(curl "https://$DOMAIN/token?version=2.0.11" \
    -H "authority: $DOMAIN" \
    -H 'accept: text/plain' \
    -H "referer: https://$DOMAIN/1/mAQI/a10/p604800/cC0" \
    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36' \
    --compressed)
  # newToken=foo
    print $newToken
}

function getRawData() {
  log "  getRawData"
  # readThruCache "rawdata" "refreshRawData" 86400 # 1 day in seconds
  refreshRawData
  return $?
}
function refreshRawData() {
  log refreshing raw data
  local token;
  local ret=$?
  log "ret $ret"
  token=$(getToken) || return $ret
  log n3 $token

# location_type=0 : outdoors
# channel_flag=0 : normal

  local res;
  res=$(curl --get  https://${DOMAIN:-0.0.0.0:8080}/v1/sensors \
  --data-urlencode "token=${token}" \
  -d "fields=latitude,longitude,confidence,pm2.5_10minute,pm2.5_60minute,humidity" \
  -d "max_age=3600" \
  -d "nwlat=$nwlat" \
  -d "selat=$selat" \
  -d "nwlng=$nwlng" \
  -d "selng=$selng" \
  -d "location_type=0" \
  -d "channel_flag=0")

  # res=$(cat /private/var/folders/gj/l3m_zv7s20bbdh4ctt3m0m2c0000gn/T/.aqirawdata3)

  log res: $res

  local err;
  err=$(print $res | jq .error)
  if [[ $? -gt 0 ]]; then
    log invalid json response from raw data: $res
    return $?
  fi
  if [[ err == "InvalidTokenError" ]]; then
    log err $err
    # invalidate token
    rm -f $(cacheFile "token")
    return $C_AUTH
  fi

  log read raw data ok
  print $res
  return $C_OK
}

function getData(){
  readThruCache "data" "refreshData" "300" # 5 minutes in seconds
}
function refreshData() {
  local raw;
  raw=$(getRawData)
  local ret=$?
  if [[ $ret != 0 ]]; then
    log bailing on refreshData
    return $ret
  fi
  print $raw | jq '. as $root
  | (.fields | index("confidence")) as $confidence
  | (.fields | index("pm2.5_10minute")) as $m10
  | (.fields | index("pm2.5_60minute")) as $m60
  | (.fields | index("humidity")) as $humidity

  # filter to sensors with confidence=100
  | .data | map(select(.[$confidence] == 100)) as $data | 1

  # TODO: calculate from radius, rather than bounding rect
  | reduce $data[] as $d (
      {sum_pm25_m10: 0, sum_pm25_m60: 0, sum_humidity: 0, n: 0};
      {
        sum_pm25_m10: (.sum_pm25_m10 + $d[$m10]),
        sum_pm25_m60: (.sum_pm25_m60 + $d[$m60]),
        sum_humidity: (.sum_humidity + $d[$humidity]),
        n: (.n + 1)
      }
    )
  | {pm25_m10: (.sum_pm25_m10 / .n), pm25_m60: (.sum_pm25_m60 / .n), humidity: (.sum_humidity / .n)}
  | .pm25_trend = (.pm25_m10 - .pm25_m60)
  '
}


echo $(getData)
