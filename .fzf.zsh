# Setup fzf
# ---------
if [[ ! "$PATH" == */home/pganuza/Repositorios/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/pganuza/Repositorios/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/pganuza/Repositorios/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/pganuza/Repositorios/fzf/shell/key-bindings.zsh"
