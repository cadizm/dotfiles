# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

BASE_DIR=$HOME'/ws'
WS_NAME=$BASE_DIR/`date '+%Y%m%d'`

export WS=$WS_NAME
export EDITOR='vim'
export SVN_EDITOR='vim'
export PS1='\h:\w[$WINDOW]$ '
export IGNOREEOF=2

set -o emacs

. $HOME/.aliases
. $HOME/.git-completion.bash

export PATH=\
$HOME/bin:\
$HOME/usr/local/bin:\
/bin:\
/sbin:\
/usr/bin:\
/usr/sbin:\
/usr/local/bin:\
$PATH
