# Bail if we're not running interactively
[[ -z $PS1 ]] && return

# Check that we haven't already been sourced
if [[ -z ${USER_BASHRC} ]]; then
  USER_BASHRC="1"

  distro=$(uname)
  alias tma='tmux attach || tmux'

  if [[ $distro == 'Darwin' ]]; then
    alias ls="ls -G"
    alias l="ls -aGhl"
    export EDITOR="subl -w"
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
    export rvmsudo_secure_path=1
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
  elif [[ $distro =~ 'CYGWIN' ]]; then
    alias ls="ls --color"
    alias l="ls -alh --color"
    export EDITOR="subl -w"
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
    export rvmsudo_secure_path=1
    #export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
  else
    alias ls="ls --color"
    alias l="ls -alh --color"
    export EDITOR="vim"
  fi

  if [[ `which vim &> /dev/null` ]]; then
    alias vi="vim"
  fi
fi

PS1="\h:\W \u\$ "

function settmuxwindow() {
  if [[ -z $1 ]]; then
    host=$(hostname)
  else
    host=$1
  fi
  [[ -n $TMUX ]] && tmux rename-window -t ${TMUX_PANE} $host || printf "\033k$host\033\\"
}

function ssh() {
  if [[ "$@" == *@* ]]; then
    remotehost=$(echo "$@" | awk '{split($0, a, "@")}{print a[2]}')
  else
    # To catch if -l was used
    array=($@)
    remotehost=${!#}
  fi
  settmuxwindow $remotehost 
  command ssh "$@"
  settmuxwindow
}