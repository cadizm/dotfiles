# .bashrc

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

function parse_git_branch
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1) /'
}

export EDITOR='vim'
export IGNOREEOF=2
export NODE_PATH=/usr/local/lib/node_modules
export PAGER=less
export PS1='\h:\w$(parse_git_branch)$ '

export PATH=\
$HOME/bin:\
$HOME/usr/local/bin:\
$HOME/usr/local/sbin:\
/bin:\
/sbin:\
/usr/local/bin:\
/usr/bin:\
/usr/sbin:\
/Developer/usr/bin:\
$PATH

export MANPATH=\
$HOME/usr/local/share/man:\
$MANPATH

. "${HOME}/bin/setws"
. ~/.aliases
. ~/.git-completion.bash

set -o emacs
