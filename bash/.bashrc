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

export CDPATH=".:~/projects:~/projects/customers"

# Setup awscli
complete -C '/usr/bin/aws_completer' aws

# Date formatting in history
export HISTTIMEFORMAT='[%b %d %R]  '
