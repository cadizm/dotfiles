# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT="%d/%m/%y %T "

# Don't want gpg "Inappropriate ioctl for device" error
# https://github.com/keybase/keybase-issues/issues/1712
export GPG_TTY=$(tty)

# https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

export EDITOR='vim'
export PS1='\h:\w$(parse_git_branch)$ '
export IGNOREEOF=2
export PAGER=less
export LESS=-XRi
export LANG='en_US.UTF-8'

# share command history
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

export PATH=\
$HOME/bin:\
$HOME/usr/local/bin:\
$HOME/usr/local/sbin:\
$HOME/.krew/bin:\
$HOME/.cargo/bin:\
/usr/local/bin:\
/usr/local/sbin:\
/bin:\
/sbin:\
/usr/bin:\
/usr/sbin

export MANPATH=$MANPATH:\
$HOME/usr/local/share/man

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

set -o emacs

. ~/.aliases
. ~/bin/setws
. ~/bin/bash-functions.sh

# Add K8s info to PS1 via https://github.com/jonmosco/kube-ps1
# Turn on/off using kubeon/kubeoff
KUBE_PS1=/usr/local/opt/kube-ps1/share/kube-ps1.sh
if [[ -f "${KUBE_PS1}" ]]; then
    echo "Sourcing ${KUBE_PS1}"
    . ${KUBE_PS1}

    export KUBE_PS1_NS_ENABLE=false
    export KUBE_PS1_SYMBOL_ENABLE=false
    export KUBE_PS1_PREFIX=''
    export KUBE_PS1_SUFFIX='|'
    export PS1='$(kube_ps1)'$PS1
    kubeoff -g
fi

BASHRC_DARWIN=$HOME/.bashrc.darwin
if [[ `uname` = "Darwin" ]]; then
    echo "Sourcing ${BASHRC_DARWIN}"
    . ${BASHRC_DARWIN}
fi

BASHRC_LOCAL=$HOME/.bashrc.local
if [[ -f "${BASHRC_LOCAL}" ]]; then
    echo "Sourcing ${BASHRC_LOCAL}"
    . ${BASHRC_LOCAL}
fi

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1) /'
}
