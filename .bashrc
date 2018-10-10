# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# .bashrc
PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#########################################################
# TODO.TXT CONFIGURATION
#
export TODO_TXT=$HOME/.todo-txt
export PATH=$PATH:$TODO_TXT
export TODOTXT_DEFAULT_ACTION=lsp
export TODOTXT_PRESERVE_LINE_NUMBERS=1
export TODOTXT_DATE_ON_ADD=1
source $TODO_TXT/todo_completion

alias t="todo.sh -a -d $TODO_TXT/personal-todo.cfg"
#  If you use aliases to use different configuration(s), you need to add and use
# a wrapper completion function for each configuration if you want to complete
# from the actual configured task locations:
_t()
{
    local _todo_sh='todo.sh -d "$TODO_TXT/personal-todo.cfg"'
#    local _todo_sh='todo.sh -d "/home/pganuza/.todo-txt/personal-todo.cfg"'
    _todo "$@"
}
complete -F _t t


alias tt="todo.sh -a -d $TODO_TXT/trabajo-todo.cfg"
#  If you use aliases to use different configuration(s), you need to add and use
# a wrapper completion function for each configuration if you want to complete
# from the actual configured task locations:
_tt()
{
    local _todo_sh='todo.sh -d "$TODO_TXT/trabajo-todo.cfg"'
    _todo "$@"
}
complete -F _tt tt

#########################################################
# VARIOUS CONFIGURATIONS
# 
# Common aliases
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -lah'
alias ..='cd ..'
alias grep='grep --color=always'

# Add paths where I store scripts
export PATH=$PATH:$HOME/.sqlcl/bin

# CVS configuration
export CVSROOT=:ext:pganuza@rc-cvs-01.assia-inc.com:/cvs
alias cvs-update='cvs update -PAd'
alias cvs-discard_changes='cvs_update -C'
alias cvs-checkout='cvs co -r'

# VIM config
alias vim='vim -u $HOME/.sshrc.d/.vimrc'

# readline config
bind -f $HOME/.sshrc.d/.inputrc

# less [1]
export LESS='-R -C -M -I -j 10 -# 4'
export PAGER=less

# tmux
export SHELL=$HOME/bashsshrc
alias m="tmux -S /tmp/pablomuxserver"

# Others
#alias diff='diff --color=auto'

#########################################################
# USEFUL FUNCTIONS
#
# Create a directory and cd into it. Name is taken from ZSH analogue function.
take () {
  mkdir -p "$1"
  cd "$1"
}

# Connect to a database
function connect_to_db {
	sqlcl $1/assia@db-ref.assia-inc.com:1521:dslo2 @$2
}

# Toggle showing history timestamps
function toggle_history_timestamps () {
	if [ -z "$HISTTIMEFORMAT" ];
	then
		export HISTTIMEFORMAT="%d/%m/%y %T "
	else
		unset HISTTIMEFORMAT
	fi
}
alias th='toggle_history_timestamps'

#########################################################
# SOURCES
# 1. https://opensource.com/article/18/5/advanced-use-less-text-file-viewer
