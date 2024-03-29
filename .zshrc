#########################################################
## SHELL CONFIGURATION
#
# Turn off screen freezing [6]
stty ixoff -ixon

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.local/bin
for d in $( ls -d $HOME/.local/bin/* ); do
	    PATH+=":$d"
done
export XDG_CONFIG_HOME=$HOME/.config

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
plugins=(history pass sudo zsh-navigation-tools extract)

source $ZSH/oh-my-zsh.sh

# User configuration
# Do not share history between opened zsh instances
setopt nosharehistory

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#	export EDITOR='vim'
#else
	export EDITOR='nvim'
#fi

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
alias zshconfig="$EDITOR ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias e=$EDITOR
alias v=view
alias fm='ranger'
alias mv='mv -b' # create a backup if file exists
zle -N open-file-widget
bindkey '^ ' open-file-widget

# copy Template Here
alias th='cp $( find ~/Templates/ -not -path "*/.git/*"| fzf --multi --preview="bat {}" ) .'

#########################################################
## ZSH CONFIGURATION
#
# Enable n-cd and n-kill [5]
zle -N znt-cd-widget
bindkey "^G" znt-cd-widget
#zle -N znt-kill-widget
#bindkey "^Y" znt-kill-widget
# Use ALT+L to lower-case a word and not to execute ls
bindkey '^[l' down-case-word

#########################################################
## FZF CONFIGURATION
#
export FZF_DEFAULT_OPTS="--preview='bat --color=always {}' --preview-window=down"

#########################################################
## TODO.TXT-CLI CONFIGURATION
#
export TODOTXT_DEFAULT_ACTION=lsp
export TODOTXT_PRESERVE_LINE_NUMBERS=1
export TODOTXT_DATE_ON_ADD=1

alias t='todo.sh -a'

tdate () {
	date --iso-8601 --date=$1
}

alias t_ls_backlog="ls $HOME/Documents/organizacion/todo/todo.txt | entr sh -c 'clear; todo.sh ls -@ -+'"

#########################################################
## DIARIO CONFIGURATION
#
export DIARIO_DIR=$HOME/Documents/organizacion/diario
alias fd="fm $DIARIO_DIR"

#########################################################
## VARIOUS CONFIGURATIONS
#
# Tmux
alias m="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias mn="m new -s"
alias ma="m attach -t"

# sshrc
# Make sshrc autocomplete hosts like ssh does [2]
compdef sshrc=ssh

# YADM
alias yadm='yadm --yadm-repo $XDG_CONFIG_HOME/yadm/repo.git'
# Make yadm autocomplete like git does
compdef yadm=git

# irssi
alias irssi='irssi --config="$XDG_CONFIG_HOME/irssi/config"'

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

# Change default permissions for new directories and files [9]
umask 002

# fasd
# This will setup a command hook that executes on every command and advanced tab completion for zsh and bash.
eval "$(fasd --init auto)"
# Open file in editor
alias fe="fasd -e $EDITOR -if"
# yank file or directory path
fy() {
	fasd -ia $1 | xclip
}

#########################################################
## USEFUL FUNCTIONS
#
# When you however forget that you already are in a ranger shell and start 
# ranger again you end up with ranger running a shell running ranger [8]. To 
# prevent this:
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

# Search a file with fzf and then open it in an editor
#alias sc='fzf | xargs $EDITOR'
open-file-widget() {
	BUFFER="mimeopen $BUFFER"
	zle accept-line
}

# You can see the list of colors with [7]:
show_colors() {
     for i in {0..255}; do
         printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
     done
}

# Start tmux with 'default' as session name or attach to it if exists
tmuxstart() {
	if [ ! "$TMUX" ]; then
		if tmux ls | grep "default" &> /dev/null ;
		then
			echo "default session found, attaching..."
			ma default
			return 0;
		#rest of tmux script to create session named "sess"
		else
			echo "default session not found, opening one..."
			mn default
		fi
	fi
}

# Convert Markdown to HTML
m2h() {
	pandoc -t html $1
}
# (C)opy (m)ail written in Markdown to clipboard as HTML
m2hc() {
	m2h $1 | xclip
}

#########################################################
## TASK MANAGEMENT
#
# TODO: Create one function only that starts task or resumes it
#       depending on wether it finds a directory with that name
export_task_variable_if_need_be() {
	if [ -z $TASK ]; then
		export TASK=$(task_get_name_from_path)
	fi
}

task_get_name_from_path(){
	# Extract current directory name
	basename $(cut -d' ' -f1 <(pwd))
}
task_info(){
	task=${1:-$TASK}

	if [ -z $task ]; then
		export_task_variable_if_need_be
		task=$TASK
	fi

	echo "~~~~~~~~~~~~~~~~~ $task info ~~~~~~~~~~~~~~~~~"
	echo 'Tasks'
	echo '-----'
	t ls +$task
	echo ''
	echo 'Notes'
	echo '-----'
	diario.sh show +$task
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}
task_start(){
	if [ -z $1 ];
	then
		echo "Usage: task_start task_name"
		return 1;
	fi
	export TASK=$1
	take $TASK
	TASK_DIR=$(pwd)
	tmux rename-session $TASK
	# next line does not work, but it tries to set the working directory for new panes
	#tmux attach-session -c "#{pane_current_path}"
	#tmux attach-session -c "$pwd"
	task_start_specifics
	diario.sh log "Comenzando con +$TASK. $(cat .title)"
	echo ''
	task_info $TASK
}
alias ts='task_start'
task_start_specifics(){
	# Nothing to do by default.
	# To be overriden by environment specific configurations
}
task_resume(){
	export TASK=$(task_get_name_from_path)
	task_resume_specifics
	diario.sh log "Continuando con +$TASK - $(cat .title). $1"
	if tmux ls | grep "$TASK" &> /dev/null ;
	then
		echo "task session found, attaching..."
		tmux switch-client -t $TASK
	else
		echo "task session not found, opening one..."
		tmux rename-session $TASK
	fi
	# next line does not work
	#tmux attach-session -c "#{pane_current_path}"
	echo ''
	TASK_DIR=$(pwd)
	task_info $TASK
}
task_resume_specifics(){
	# Nothing to do by default.
	# To be overriden by environment specific configurations
}
task_close(){
	export_task_variable_if_need_be
	diario.sh log "+$TASK cerrado - $(sed 's/:/,/g' .title).\n$1"
	task_info $TASK
}

diario_task() {
	export_task_variable_if_need_be
	file=$(diario.sh log "+$TASK - $(cat .title)\n$1")
	$EDITOR $file

	# If file is left empty, user probably regreted
	# logging anything so let's just delete the file
	# and pretend nothing happend
	if [[ ! -s $file ]]; then
		rm $file
	else
		echo $file
	fi
}
alias dt='diario_task'
alias ds='diario.sh show'
alias de='diario.sh edit'
alias dl='diario.sh log'

#########################################################
## SOURCE
#
HOSTNAME=$(hostname)
if [[ -f "$HOME/.zshrc-$HOSTNAME" ]]; then
	echo "Sourcing ~/.zshrc-$HOSTNAME..."
	source "$HOME/.zshrc-$HOSTNAME" 
fi

CLASS=$(cat $HOME/.config/class)
if [[ -f "$HOME/.zshrc-$CLASS" ]]; then
	echo "Sourcing ~/zshrc-$CLASS..."
	source "$HOME/.zshrc-$CLASS" 
fi

#########################################################
## FINALLY
#
# Activate fzf shortcuts
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Activate syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Always start or attach to default Tmux session if connected through SSH
if [[ -n $SSH_CONNECTION ]]; then
	tmuxstart
fi

#########################################################
# SOURCES
# [1]: https://opensource.com/article/18/5/advanced-use-less-text-file-viewer
# [2]: https://unix.stackexchange.com/questions/410456/zsh-completion-make-sshrc-behave-like-ssh
# [3]: https://github.com/tobixen/calendar-cli
# [4]: http://grml.org/zsh/zsh-lovers.html
# [5]: https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/zsh-navigation-tools
# [6]: http://xahlee.info/linux/linux_Ctrl-s_freeze_vi.html
# [7]: https://superuser.com/questions/285381/how-does-the-tmux-color-palette-work
# [8]: https://wiki.archlinux.org/index.php/Ranger
# [9]: https://geek-university.com/linux/set-the-default-permissions-for-newly-created-files/
