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

# Complain if we don't have bash_completion
. $(brew --prefix)/etc/bash_completion

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
export USE_ZULU_JAVA8=1


if [ -n "${USE_JAVA11}" ]; then
    # brew cask install java11
    export JAVA_HOME=$(/usr/libexec/java_home -v11)
elif [ -n "${USE_ZULU_JAVA8}" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v1.8.0_252)
else
    # brew cask install adoptopenjdk/openjdk/adoptopenjdk8
    export JAVA_HOME=$(/usr/libexec/java_home -v1.8.0_242)
fi

export PATH=\
$HOME/bin:\
$HOME/usr/local/bin:\
$HOME/usr/local/sbin:\
$JAVA_HOME/bin:\
/usr/local/opt/tomcat@8/bin:\
/usr/local/opt/thrift@0.9/bin:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/local/opt/curl/bin:\
/usr/local/opt/mysql-client/bin:\
/bin:\
/sbin:\
/usr/bin:\
/usr/sbin:\
/usr/texbin:\
$HOME/.krew/bin:\
$HOME/.cargo/bin:\
$GOROOT/bin:\
$GOPATH/bin:\
/Applications/MacVim.app/Contents/bin:\
/Users/michael.cadiz/Library/Python/2.7/bin

export MANPATH=$MANPATH:\
$HOME/usr/local/share/man

. ~/.aliases
. "${HOME}/bin/setws"
. ~/bin/bash-functions.sh

set -o emacs

if [[ `uname` = "Darwin" ]]; then
    export WORKON_HOME=${HOME}/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    mkdir -p $WORKON_HOME
    . /usr/local/bin/virtualenvwrapper.sh

    # don't use apple's openssl
    export LDFLAGS=-L/usr/local/opt/openssl/lib
    export CPPFLAGS=-I/usr/local/opt/openssl/include
    export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

    export LDFLAGS="${LDFLAGS} -L/usr/local/opt/libxml2/lib"
    export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/libxml2/include"
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

if [ -d "${HOME}/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
. /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash

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
