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

stty erase ^h

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

function parse_git_branch
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1) /'
}

export EDITOR='vim'
export GEM_EDITOR='gvim'
export PS1='\h:\w$(parse_git_branch)$ '
export IGNOREEOF=2
export PAGER=less
export LESS=-XRi
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/workspace/go
export LANG='en_US.UTF-8'

export PATH=\
$HOME/bin:\
$HOME/usr/local/bin:\
$HOME/usr/local/sbin:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/local/opt/curl/bin:\
/bin:\
/sbin:\
/usr/bin:\
/usr/sbin:\
/usr/texbin:\
$GOROOT/bin:\
$GOPATH/bin

export MANPATH=$MANPATH:\
$HOME/usr/local/share/man

. ~/.aliases
. "${HOME}/bin/setws"

set -o emacs

if [[ `uname` = "Darwin" ]]; then
    export WORKON_HOME=${HOME}/.virtualenvs
    mkdir -p $WORKON_HOME
    . /usr/local/bin/virtualenvwrapper.sh

    # don't use apple's openssl
    export LDFLAGS=-L/usr/local/opt/openssl/lib
    export CPPFLAGS=-I/usr/local/opt/openssl/include
    export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

    export LDFLAGS="${LDFLAGS} -L/usr/local/opt/libxml2/lib"
    export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/libxml2/include"
fi

if [[ -n `which brew` ]]; then
    export NVM_DIR=$HOME/.nvm
    . $(brew --prefix nvm)/nvm.sh
    if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
      . $(brew --prefix)/etc/bash_completion
    fi
fi

if [[ -n `which aws_completer` ]]; then
    complete -C `which aws_completer` aws
fi

BASHRC_LOCAL=$HOME/.bashrc.local
if [[ -f "${BASHRC_LOCAL}" ]]; then
    echo "Sourcing ${BASHRC_LOCAL}"
    . ${BASHRC_LOCAL}
fi

if [ -d "/Library/TeX/Root/bin/x86_64-darwin" ]; then
    export PATH=$PATH:/Library/TeX/Root/bin/x86_64-darwin
fi

# https://github.com/fnando/gem-open#bash-completion
_gemopencomplete() {
    local cmd=${COMP_WORDS[0]}
    local subcmd=${COMP_WORDS[1]}
    local cur=${COMP_WORDS[COMP_CWORD]}

    case "$subcmd" in
        open)
            words=`ruby -rubygems -e 'puts Dir["{#{Gem::Specification.dirs.join(",")}}/*.gemspec"].collect {|s| File.basename(s).gsub(/\.gemspec$/, "")}'`
            ;;
        *)
            return
            ;;
    esac

    COMPREPLY=($(compgen -W "$words" -- $cur))
    return 0
}
complete -o default -F _gemopencomplete gem

# Don't want gpg "Inappropriate ioctl for device" error
# https://github.com/keybase/keybase-issues/issues/1712
export GPG_TTY=$(tty)

# https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1
