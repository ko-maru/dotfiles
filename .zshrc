setopt autocd

# Autocompletion
autoload _Uz compinit
compinit

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history

# Prompt
eval "$(starship init zsh)"

# Key bindings
bindkey -v # Vi-like

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# Aliases
## ls
alias la='ls -a'
alias ll='ls -hl'
alias lla='ls -ahl'
## tmux
alias t='tmux'
## docker
alias d='docker'
## git
alias g='git'
