source ~/.dotfiles/.bashrc

UAPPDATA="/c/Users/Jason/AppData/Roaming"
PATH="$PATH:/c/Program Files/Sublime Text 3"
PATH="$PATH:~/bin/bind"
PATH="$PATH:/c/Program Files/Oracle/VirtualBox"
PATH="$PATH:/c/Program Files/MongoDB 2.6 Standard/bin"
PATH="$PATH:/c/Python27"
PATH="$PATH:/c/Ruby21-x64/bin"
PATH="$PATH:/c/Program Files (x86)/Heroku/bin"

source ~/.dotfiles/windows/hub.bash_completion.sh

# better prompt, based on git bash default

[ -r /etc/git-prompt.sh ] && . /etc/git-prompt.sh

PS1='\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]' # set window title
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'\[\033[32m\]'       # change color
PS1="$PS1"'jden '
PS1="$PS1"'\[\033[33m\]'       # change color
PS1="$PS1"'\w'                 # current working directory
if test -z "$WINELOADERNOEXEC"
then
    PS1="$PS1"'$(__git_ps1)'   # bash function
fi
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'> '                 # prompt
