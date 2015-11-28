# .bashrc

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export EDITOR='vim'
export PS1='\h:\w$(parse_git_branch)$ '
export IGNOREEOF=2
export USE_HOME_LOG_DIR=1
export PAGER=less
export LESS=-XRi
export MAVEN_OPTS='-Xms256m -Xmx512m'
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/workspace/go
export LANG='en_US.UTF-8'
export NVM_DIR=$HOME/.nvm

export PATH=\
$HOME/bin:\
$HOME/usr/local/bin:\
$HOME/usr/local/sbin:\
/bin:\
/sbin:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/bin:\
/usr/sbin:\
/Developer/usr/bin:\
$GOROOT/bin:\
$GOPATH/bin:\
$PATH

export MANPATH=$MANPATH:\
$HOME/usr/local/share/man

. ~/.aliases
. ~/.git-completion.bash
. "${HOME}/bin/setws"
. $(brew --prefix nvm)/nvm.sh

set -o emacs

if [[ `uname` = "Darwin" ]]; then
    export WORKON_HOME=${HOME}/.virtualenvs
    mkdir -p $WORKON_HOME
    . /usr/local/bin/virtualenvwrapper.sh
fi

function parse_git_branch
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1) /'
}

if [[ -n `which brew` ]]; then
    if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
      . $(brew --prefix)/etc/bash_completion
    fi
else
    echo "No brew?"
fi

DOCKER_COMPLETION=~/workspace/src/docker/contrib/completion/bash/docker
if [[ -f $DOCKER_COMPLETION ]]; then
    . $DOCKER_COMPLETION
else
    echo "No docker?"
fi

DOCKER_MACHINE_COMPLETION=~/workspace/src/machine/contrib/completion/bash/docker-machine.bash
if [[ -f $DOCKER_MACHINE_COMPLETION ]]; then
    . $DOCKER_MACHINE_COMPLETION
else
    echo "No docker-machine?"
fi

DOCKER_COMPOSE_COMPLETION=~/workspace/src/compose/contrib/completion/bash/docker-compose
if [[ -f $DOCKER_COMPOSE_COMPLETION ]]; then
    . $DOCKER_COMPOSE_COMPLETION
else
    echo "No docker-compose?"
fi

BASHRC_LOCAL=$HOME/.bashrc.local
if [[ -f "${BASHRC_LOCAL}" ]]; then
    echo "Sourcing ${BASHRC_LOCAL}"
    . ${BASHRC_LOCAL}
else
    echo "No .bashrc.local?"
fi
