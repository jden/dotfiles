# terminal
alias icat="kitty icat --align=left"
alias isvg="rsvg-convert --dpi-x=120 --dpi-y=120 | icat"
alias isvg2="rsvg-convert --zoom=2 | icat"
## require npm i -g vega-cli, draws vega lite charts
alias ivl="vl2svg | isvg2"
## dot with default styles, reference https://graphviz.org/doc/info/attrs.html
function idot() {
  cleanpath
  dot -Gbgcolor=transparent -Ncolor=white -Nfontcolor=white -Nfontsize=16 -Nfontname=monospace -Ecolor=white -Tsvg | isvg
}
function itex() {
  tex2svg "$1" | sed 's|</svg>|<style>*{fill:white;}</style></svg>|' | rsvg-convert --zoom 3 | icat
}

# fix TERM env for ssh
alias ssh="env TERM=xterm-256color ssh"

function cleanpath() {
  local split=(${(s|:|)PATH})
  local clean=${(j|:|)${split:#*mde*}}
  PATH=$clean
}

alias launch-tab="kitty @ launch --type=tab --cwd=current"
# see https://sw.kovidgoyal.net/kitty/launch/
