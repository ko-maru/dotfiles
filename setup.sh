#!/usr/bin/env bash

DOTFILES_DIRECTORY_PATH="${HOME}/dotfiles"
REPOSITORY_URL="https://github.com/ko-maru/dotfiles"

has() {
  command -v $1 &>/dev/null
}

die() {
  echo $@ >&2
  exit 1
}

download() {
  if ! has "curl"; then die "curl is required"; fi 

  curl -fLo "${HOME}/git-completion.bash" \
    "https://raw.github.com/git/git/master/contrib/completion/git-completion.bash"
  curl -fLo "${HOME}/git-prompt.sh" \
    "https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh"

  if has "git"; then
    git clone "${REPOSITORY_URL}.git"
  else
    curl -fL "${REPOSITORY_URL}/archive/main.tar.gz" \
      | tar zxv
    mv -f dotfiles-main "${DOTFILES_DIRECTORY_PATH}"
  fi
}

create_symlinks() {
  cd "${DOTFILES_DIRECTORY_PATH}"

  for f in .??*; do
    [ "${f}" = ".git" ] && continue
    [ "${f}" = ".gitignore" ] && continue
    [ -d "${f}" ] && continue

    ln -snfv "${DOTFILES_DIRECTORY_PATH}/${f}" "${HOME}/${f}"
  done

  for f in .config/*; do
    ln -snfv "${DOTFILES_DIRECTORY_PATH}/${f}" "${HOME}/${f}"
  done
}

main() {
  set -euo pipefail

  download
  create_symlinks
}

if ! (return 0 2>/dev/null) then;
  main
fi
