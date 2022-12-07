SHELL=/bin/bash
PACKAGES := build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev git gcc g++ make tmux fd-find ripgrep dirmngr gpg gawk unzip libfuse2 ca-certificates curl gnupg lsb-release 

.PHONY: all 

all: install init asdf asdf-nodejs asdf-python nodejs python fish fisher tmux neovim

init:
	mkdir -p "${HOME}/.local/bin"

install:
	sudo apt update
	sudo apt install -y $(PACKAGES)

docker:
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
		| sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo \
  "deb [arch=$$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update
	sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

asdf:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2

asdf-nodejs:
	asdf plugin add nodejs

asdf-python:
	asdf plugin add python 

nodejs:
	asdf install nodejs lts
	asdf global nodejs lts

python:
	asdf install python latest
	asdf global python latest

fish:
	sudo apt-add-repository -y ppa:fish-shell/release-3
	sudo apt update
	sudo apt install -y fish

fisher:
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

starship:
	curl -sS https://starship.rs/install.sh | sh

tmux:
	ln -snvf ${PWD}/.tmux.conf ${HOME}/.tmux.conf

neovim: 
	curl -o "${HOME}/.local/bin/nvim" \
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

dummy: ${HOME}/.local
	@echo 'Dummy'
