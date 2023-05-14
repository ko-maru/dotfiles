#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd $(dirname $0); pwd)"

BASE_PACKAGES=(ca-certificate build-essential curl dirmngr fd-find gawk gcc git gnupg gpg g++ \
  libbz2-dev libffi-dev liblzma-dev libncursesw5-dev libssl-dev libreadline-dev libsqlite3-dev \
  libxmlsec1 make man openssh-client ripgrep tk-dev wget unzip xz-utils zlib1g-dev zsh)

install_base_packages() {
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt install -y --ignore-missing "${PACKAGES[@]}"
}

install_asdf() {
  readonly ASDF_DIR="${HOME}/.asdf"
  if [[ ! -d "${ASDF_DIR}" ]]; then
    git clone https://github.com/asdf-vm/asdf.git "${ASDF_DIR}" --branch v0.11.3
    . "${ASDF_DIR}/asdf.sh"
  fi

  local installed_plugins="$(asdf plugin list)"
  if ! "${installed_plugins}" =~ "nodejs"; then
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs lts
    asdf global nodejs lts
  fi
  if ! "${installed_plugins}" =~ "python"; then
    asdf plugin add python
    local latest_version="$(asdf latest python)"
    asdf install python "${latest_version}"
    asdf global python "${latest_version}"
  fi
}

install_dotnet_sdk() {
  # setup the repository
  wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  rm packages-microsoft-prod.deb

  # install .NET SDK
  sudo apt update -y && sudo apt install -y dotnet-sdk-7.0
}

install_docker() {
  # remove old versions
  sudo apt remove docker docker-engine docker.io containerd runc

  # setup the repository
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # install
  sudo apt update -y
  sudo apt install docker-ce containerd.io docker-buildx-plugin docker-compose-plugin
}

install() {
  install_docker
  install_base_packages
  install_asdf
  install_docker
  install_dotnet_sdk
}

locate_dotfiles() {
  ln -snf "${SCRIPT_DIR}/.zshrc" "${HOME}/.zshrc"
}

# install
locate_dotfiles
