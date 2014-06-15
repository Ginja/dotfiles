# Bail if we're not running interactively
[[ -z $PS1 ]] && return

alias tma='tmux attach || tmux'
if [[ `uname` == 'Darwin' ]]; then
  alias ls="ls -G"
  alias l="ls -aGhl"
  export EDITOR="atom -w"
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
  export rvmsudo_secure_path=1
else
  alias ls="ls --color"
  alias l="ls -alh --color"
  export EDITOR="vim"
fi
if [[ `which vim &> /dev/null` ]]; then
  alias vi="vim"
fi

PS1="\h:\W \u\$ "

function settmuxwindow() {
  if [[ -z $1 ]]; then
    host=$(hostname)
  else
    host=$1
  fi
  [[ -n $TMUX ]] && tmux rename-window -t ${TMUX_PANE} $host
}

function ssh() {
  if [[ "$@" == *@* ]]; then
    remotehost=$(echo "$@" | awk '{split($0, a, "@")}{print a[2]}'
  else
    # To catch if -l was used
    array=($@)
    remotehost=${!#}
  fi
  settmuxwindow $remotehost 
  command ssh "$@"
  settmuxwindow
}
