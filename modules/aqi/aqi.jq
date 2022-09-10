. as $root
  | (.fields | index("confidence")) as $confidence
  | (.fields | index("pm2.5_10minute")) as $m10
  | (.fields | index("pm2.5_60minute")) as $m60
  | (.fields | index("humidity")) as $humidity

  # filter to sensors with confidence=100
  | .data | map(select(.[$confidence] == 100 and .[$humidity] != null)) as $data

| $data
  # # # TODO: calculate from radius, rather than bounding rect
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
