# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.scripts:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="bira"
ZSH_THEME="blinks"
#ZSH_THEME="candy"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(history pass sudo systemd zsh-navigation-tools extract svn-fast-info jira)

source $ZSH/oh-my-zsh.sh

# User configuration
# Do not share history between opened zsh instances
setopt nosharehistory

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#########################################################
# TODO.TXT-CLI CONFIGURATION
#
export TODO_TXT_CFG=$HOME/.config/todo-txt
export TODOTXT_DEFAULT_ACTION=lsp
export TODOTXT_PRESERVE_LINE_NUMBERS=1
export TODOTXT_DATE_ON_ADD=1
export TODO_ACTIONS_DIR=$HOME/.todo.actions.d

alias t="todo -a -d $TODO_TXT_CFG/personal-todo.cfg"
alias th="t listpri h"
alias tt="todo -a -d $TODO_TXT_CFG/trabajo-todo.cfg"
alias tth="tt listpri h"

alias tr="vim $HOME/.todo-txt/recur.txt"

#########################################################
# VARIOUS CONFIGURATIONS
#
# JRNL
alias j="jrnl trabajo"
alias jjt="vim ~/.todo-txt/trabajo-journal.txt"
alias jp="jrnl personal"
alias jjp="vim ~/.todo-txt/personal-journal.txt"

# Tmux
alias m="tmux"
alias mn="tmux new -s"
alias ma="tmux attach -t"

# sshrc
# Make sshrc autocomplete hosts like ssh does [2]
compdef sshrc=ssh
# Make yadm autocomplete like git does
compdef yadm=git

# less [1]
export LESS='-R -C -M -I -j 10 -# 4'
#export PAGER=less

# diff
alias diff='diff --color=auto'

# Get the weather report
alias weather='curl wttr.in'

# Get ip address
alias ipexternal='curl ipinfo.io/ip'
alias ipinternal='ipconfig getifaddr en0'

# Vim with system clipboard support
#alias vim="gvim -v"

#########################################################
# USEFUL FUNCTIONS
#
# When you however forget that you already are in a ranger shell and start ranger again you end up 
# with ranger running a shell running ranger. To prevent this:
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

# Search in Duckduckgo.com
ddg() {
	w3m http://duckduckgo.com/html\?q\="$1"
}

# Get the PID of a process [4]
pid2() {
	local i
	for i in /proc/<->/stat
	do
		[[ "$(< $i)" = *\((${(j:|:)~@})\)* ]] && echo $i:h:t
	done
}

#########################################################
# Source specific files depending on host
source_assiarc() {
	echo "+ sourcing .assiarc"
	source $HOME/.assiarc
}
source_pganuza-e7470rc() {
	echo "+ sourcing .pganuza-e7470rc"
	source $HOME/.pganuza-e7470rc
}

hostname=$(hostname)
if [ "$hostname" = "PGANUZA-E7470" ]; then
	echo "sourcing files for PGANUZA-E7470"
	source_assiarc
	source_pganuza-e7470rc
elif [ "$hostname" = "pganuza-dev.assia-inc.com" ]; then 
	echo "sourcing files for pganuza-dev"
	source_assiarc
elif [ "$hostname" = "maFalda" ]; then 
	echo "sourcing files for maFalda"
elif [ "$hostname" = "bagHeera" ]; then 
	echo "sourcing files for bagHeera"
elif [ "$hostname" = "baloO" ]; then 
	echo "sourcing files for baloO"
fi

#########################################################
# SOURCES
# 1. https://opensource.com/article/18/5/advanced-use-less-text-file-viewer
# 2. https://unix.stackexchange.com/questions/410456/zsh-completion-make-sshrc-behave-like-ssh
# 3. https://github.com/tobixen/calendar-cli
# 4. http://grml.org/zsh/zsh-lovers.html
