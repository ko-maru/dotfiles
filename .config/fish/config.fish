# load asdf
source ~/.asdf/asdf.fish

# load starfish
starship init fish | source

# launch ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]
  eval (ssh-agent -c)
end

if status is-interactive
  # enable vi-like key bindings
  fish_vi_key_bindings
  set fish_cursor_default block 
  set fish_cursor_insert line
  set fish_cursor_replace_one underscore 
  set fish_cursor_visual block 

  # disable greeting
  set fish_greeting
end

