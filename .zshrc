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

# Aliases & Functions
## ls
alias la='ls -a'
alias ll='ls -hl'
alias lla='ls -ahl'

export PATH="$brew --prefix python)/libexec/bin:$PATH"

# ssh agent
eval $(keychain --eval --quiet ~/.ssh/id_ed25519)

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_DEFAULT_OPTS='--border --margin=0,1'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}' --preview-window '~3'"
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude .git"
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80%"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

f() {
  if [ -n "$TMUX" ]; then
    fzf-tmux -p80% $@
  else
    fzf
  fi
}

# zoxide
eval "$(zoxide init zsh)"

# bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# mise
eval "$($(brew --prefix)/bin/mise activate zsh)"

## tmux
alias t='tmux'

## docker
alias d='docker'

cl() {
  # open lazygit
  if [ -n "$TMUX" ]; then
    tmux popup -w90% -h90% -E lazydocker
  else
    lazydocker
  fi
}

## git
alias g='git'

gl() {
  # open lazygit
  if [ -n "$TMUX" ]; then
    tmux popup -w90% -h90% -d "$(pwd)" -E lazygit
  else
    lazygit
  fi
}

gfr() {
  local repo=$(ghq list -p | f)
  cd "${repo:-.}"
}


