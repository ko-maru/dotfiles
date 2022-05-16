# if not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# attach tmux session if exists, otherwise create new session
if command -v tmux &> /dev/null; then
	[[ -z "${TMUX}" ]] && (tmux attach || tmux new-session)
fi

# shell
shopt -s autocd
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkwinsize
shopt -s dirspell
shopt -s dotglob
shopt -s extglob
shopt -s globstar
shopt -s histappend

# history
HISTSIZE=10000
HISTFILESIZE=120000
HISTCONTROL=ignoredups
HISTTIMEFORMAT="%F %T "

# aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

[ -f ~/git-completion.bash ] && . ~/git-completion.bash
[ -f ~/git-prompt.sh ] && . ~/git-prompt.sh
[ -f ~/.bash_prompt ] && . ~/.bash_prompt

# fzf
[ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] &&  . /usr/share/fzf/completion.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
