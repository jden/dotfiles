function fmt(str, style) {
  esc="\x1b["
  color="39m" # default
  reset="0m"
  mode=""

  if (style ~ /bold/) {
    mode="1;"
  } else if (style ~ /dim/) {
    mode="2;"
  }

  if (style ~ /black/) {
    color="30m"
  } else if (style ~ /red/) {
    color="31m"
  } else if (style ~ /green/) {
    color="32m"
  } else if (style ~ /yellow/) {
    color="33m"
  } else if (style ~ /blue/) {
    color="34m"
  } else if (style ~ /magenta/) {
    color="35m"
  } else if (style ~ /cyan/) {
    color="36m"
  } else if (style ~ /white/) {
    color="37m"
  }

  return esc mode color str esc reset
}

function col(str, len, style) {
  return fmt(sprintf("%-*.*s", len, len, str), style)
}
function fcol(str, minlen, len, style) {
  return fmt(sprintf("%-*.*s", minlen, len, str), style)
}

BEGIN {
  RS = ""
  FS = "\n"
  system("date")
}

{
  # use with git format string: "%h%n%aE%n%s%n"
  hash = $1
  split($2,user,"@")
    name=user[1]
  split($3,summary,/\(|\): /)
    type=summary[1]
      stype=type
      gsub(/[aeiou]/,"",stype)
    scopes=summary[2]
      sub("javascript-server", "jss", scopes)
    rest=summary[3]

  print col(hash, 6, "dim"),
        col(name, 8, "cyan"),
        col(stype, 2, "bold"),
        fcol(scopes, 4, 16, "dim")," ",
        rest
}

# TODO
# group by date
# show phab number