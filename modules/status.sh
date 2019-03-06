
function __vpn_status () {
  netstat -rn | grep 192.161.159. > /dev/null && (echo 🍃) || (echo 🚫)
}

spotify="$(osascript ~/.dotfiles/scripts/spotify.apl)"
time="$(date +%l:%M)"
echo "$(__vpn_status)  $time  $spotify"