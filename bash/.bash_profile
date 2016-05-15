# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin:/home/sstar/Android/Sdk/platform-tools

export PATH

# If command-line starts with space, don't save in history
export HISTCONTROL=ignorespace

# Date formatting in history
export HISTTIMEFORMAT='[%b %d %R]  '

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Shorthand: for x in *; do cmd $x; done
# Becomes:   , * cmd
# Similar:   echo * | xargs cmd
function ,(){
    target=""
    while [[ $# -gt 1 ]]; do
        target="$target $1"
        shift
        [[ "$1" == "--" ]] && { shift; break; }
    done
    for n in $target; do $* $n; done
}
