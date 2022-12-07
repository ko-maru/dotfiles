#!/bin/bash
#
# Setup
set -euo pipefail
cd $(dirname $0)

function error() {
  echo "[$(date +'%Y-%m-%dT%H%M%S%z')]: $*" >&2
}

function install_packages() {
  local base_packages="
build-essential
ca-certificates
curl
dirmngr
fd-find
g++
gawk
gcc
git
gnupg
gpg
libbz2-dev
libffi-dev
libfuse2
liblzma-dev
libncursesw5-dev
libreadline-dev
libsqlite3-dev
libssl-dev
libxml2-dev
libxmlsec1-dev
llvm
lsb-release
make
ripgrep
tk-dev
unzip
wget
xz-utils
zlib1g-dev
  "
  sudo apt update
  echo "${base_packages}" | xargs sudo apt install -y
}

function install_asdf() {
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
  # Install node.js
	asdf plugin add nodejs
	asdf install nodejs lts
	asdf global nodejs lts
  # Install python
	asdf plugin add python 
	asdf install python latest
	asdf global python latest
}

function install_docker() {
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
		| sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo \
  "deb [arch=$$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update
	sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
}

function install_fish() {
	sudo apt-add-repository -y ppa:fish-shell/release-3
	sudo apt update
	sudo apt install -y fish
}

function install_fisher() {
  fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'
}

function install_neovim() {
  mkdir -p "${HOME}/.local/bin"
  curl \
    -o "${HOME}/.local/bin/nvim" \
    -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x "${HOME}/.local/bin/nvim"
  ln -snvf ${PWD}/.config/nvim ${HOME}/.config/nvim

  # for using Windows clipboard from WSL
  curl -sL \
    -o /tmp/win32yank.zip \
    https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
  unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
  chmod +x /tmp/win32yank.exe
  sudo mv /tmp/win32yank.exe /usr/local/bin/
}

function install_starship() {
  curl -sS https://starship.rs/install.sh | sh
}

function install_tmux() {
  sudo apt install -y tmux
	ln -snvf ${PWD}/.tmux.conf ${HOME}/.tmux.conf
}

function install() {
  install_packages
  install_tmux
  install_fish
  install_fisher
  install_starship
  install_asdf
  install_neovim
  install_docker
}

PATH="${PATH}:${PWD}/scripts"
hello.sh
