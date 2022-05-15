alias diff='diff --color=auto'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ip='ip -color=auto'

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'

if command -v nvim &> /dev/null; then
  alias vi='nvim'
  alias vim='nvim'
fi
