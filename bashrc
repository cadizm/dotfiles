# .bashrc

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT="%d/%m/%y %T "

# append to the history file, don't overwrite it
shopt -s histappend

# share command history
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

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

BASHRC_LOCAL=$HOME/.bashrc.local
if [[ -f "${BASHRC_LOCAL}" ]]; then
    echo "Sourcing ${BASHRC_LOCAL}"
    . ${BASHRC_LOCAL}
else
    echo "No .bashrc.local?"
fi
