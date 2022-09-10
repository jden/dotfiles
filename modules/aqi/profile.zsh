add-zsh-hook precmd set_aqi
function set_aqi() {
  # load json to local vars
  eval $($DOTFILES/modules/aqi/aqi.zsh | jq -r '. as $root | keys | map("local aqi_" + . + "=" + ($root[.] | tostring)) | join("; ")')

  # typeset -m 'aqi*'

  local trend="";
  if [[ $aqi_pm25_trend -gt 2 ]]; then
    trend="+"
  elif [[ $aqi_pm25_trend -lt -2 ]]; then
    trend="-"
  fi

  local aqi=$(__to_aqi $(__correct_pm25 $aqi_pm25_m10 $aqi_humidity))


  if [[ $aqi -gt 50 ]]; then
    export AQI_TREND=$trend
    export AQI=$aqi
    local formatted=$(__colorize_aqi $aqi "$aqi$trend")
    export AQI_STR=$formatted
  else
    unset AQI_TREND
    unset AQI
    unset AQI_STR
  fi;

}

function __colorize_aqi() {
  local aqi=$1
  local text=$2
  local color;
  if [[ $aqi -gt 300 ]]; then
    color="126;0;35"
  elif [[ $aqi -gt 200 ]]; then
    color="43;63;151"
  elif [[ $aqi -gt 150 ]]; then
    color="255;0;0"
  elif [[ $aqi -gt 100 ]]; then
    color="255;126;0"
  elif [[ $aqi -gt 50 ]]; then
    color="255;255;0"
  elif [[ $aqi -gt 0 ]]; then
    color="104;225;67"
  else;
  fi;

  print "\033[38;2;${color}m${text}\033[0m"
}

function __correct_pm25() {
  local corrected_pm25; # corrected PM2.5 µg/m3
  local p=$1 # aqi_pm25_m10, PM2.5 cf_atm (lower)
  local h=${2:-25} # aqi_humidity,  relative humidity
  # complicated piece-wise formula: https://cfpub.epa.gov/si/si_public_record_report.cfm?dirEntryId=353088&Lab=CEMM (slide 26)

  if [[ $p -lt 0 ]]; then
    corrected_pm25=-1
  elif [[ $p -lt 30 ]]; then
    (( corrected_pm25 =  .524 * p - .0862 * h + 5.75))
  elif [[ $p -lt 50 ]]; then
    (( corrected_pm25 = (.786 * (p / 20 - 1.5) + .524 * (1 - (p / 20 - 1.5))) * p - .0862
    * h + 5.75 ))
  elif [[ $p -lt 210 ]]; then
  echo c
    (( corrected_pm25 = .786 * p - .0862 * h + 5.75 ))
  elif [[ $p -lt 260 ]]; then
    (( corrected_pm25 = (.69 * (p / 50 - 4.2) + .786 * (1 - (p / 50 - 4.2))) * p - .0862 * h * (1 - (p / 50 - 4.2)) + 2.966 * (p / 50 - 4.2) + 5.75 * (1 - (p / 50 - 4.2)) + 8.84 * (10 ** -4) * (t ** 2) * (p / 50 - 4.2)
    ))
  else
    (( corrected_pm25 = 2.966 + .69 * p + 8.84 * (10 ** -4) * (p ** 2)  ))
  fi

# simple formula (slide 5)
  # (( corrected_pm25 = 0.52*p - 0.086*h + 5.75 ))

  # echo AQI $corrected_pm25 $p
  print $corrected_pm25
}

function __to_aqi() {
  local t=$1
  local e;
  local i;
  local r;
  local n;
  local o;
  local a;
  local s;

  # adjust piecewise parameters
  if [[ $t -gt 350.5 ]]; then
    e=500
    i=401
    r=500
    n=350.5
  elif [[ $t -gt 250.5 ]]; then
    e=400
    i=301
    r=350.4
    n=250.5
  elif [[ $t -gt 150.5 ]]; then
    e=300
    i=201
    r=250.4
    n=150.5
  elif [[ $t -gt 55.5 ]]; then
    e=200
    i=151
    r=150.4
    n=55.5
  elif [[ $t -gt 35.5 ]]; then
    e=150
    i=101
    r=55.4
    n=55.5
  elif [[ $t -gt 12.1 ]]; then
    e=100
    i=51
    r=35.4
    n=12.1
  elif [[ $t -gt 12.1 ]]; then
    e=100
    i=51
    r=35.4
    n=12.1
  else
    return 1
  fi

  (( o = $e - $i ))
  (( a = $r - $n ))
  (( s = $t - $n ))

  local result;
  (( result = $o / $a * $s + $i ))

  printf "%d" $result
}
