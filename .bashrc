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

export FON_DIR=/Users/mcadiz/workspace/src/trunk
export CONF_TARGET=$FON_DIR/res/conf

#export M2_HOME=/home/mcadiz/usr/local/maven/apache-maven-3.0.5
#export M2=$M2_HOME/bin
export MAVEN_OPTS='-Xms256m -Xmx512m'

set -o emacs

# aliases
. ~/.aliases
. /usr/share/git-core/git-completion.bash

### Configure PATH environment variable
export PATH=\
$HOME/bin:\
$HOME/usr/local/bin:\
/bin:\
/sbin:\
/usr/bin:\
/usr/sbin:\
/usr/local/bin:\
~cadizm/bin:\
~cadizm/usr/local/bin:\
~cadizm/usr/local/sbin:\
/usr/local/mysql/bin:\
/Developer/usr/bin:$PATH

export MANPATH=$MANPATH:\
$HOME/usr/local/share/man

#umask 0002
