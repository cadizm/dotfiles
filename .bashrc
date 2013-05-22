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
export USE_HOME_LOG_DIR=1

set -o emacs

# aliases
. ~/.aliases
. ~/.git-completion.bash

### Configure PATH environment variable
export PATH=\
$HOME/bin:\
$HOME/usr/local/bin:\
/bin:\
/sbin:\
/usr/bin:\
/usr/sbin:\
/usr/local/bin:\
/usr/kerberos/bin:\
/usr/X11R6/bin:\
/usr/lib64/qt-3.3/bin:

export MANPATH=$MANPATH:\
$HOME/usr/local/share/man

#umask 0002
