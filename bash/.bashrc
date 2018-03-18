# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias sc='systemctl'
alias psc='ps xawf -eo pid,user,cgroup:80,args'

# enable ** for recursive matching
shopt -s globstar

# Abbreviated tree output
function t(){
    FILELIMIT=20

    cmd='tree -L 2 --dirsfirst --du -h'
    if [[ $(ls | wc -l) -lt $LIMIT ]]; then
        $cmd --filelimit $LIMIT $*
    else
        $cmd -C $* | less -REX
    fi
}

bind 'set match-hidden-files off'

# Refactor app-specific bash includes
for file in $HOME/.bash_funcs.d/*.{ba,}sh; do
    source $file
done

# Setup awscli (move to inc file)
complete -C '/usr/bin/aws_completer' aws

# Let's do the same for completions (vs using system /etc/bash_completion.d)
files=$(find ~/.bash_completion.d/ -mindepth 1 -maxdepth 1 -type f 2>/dev/null)
for file in $files; do
    source $file
done

# Setup PS1
if [ ! -z "${PS1##*$__git_ps1*}" ] ; then
    PS1='$(__git_ps1) '"$PS1"
fi


# Date formatting in history
export HISTTIMEFORMAT='[%b %d %R]  '
