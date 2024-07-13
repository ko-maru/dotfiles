ALL_TARGETS	+= brew
INSTALL_TARGETS	+= brew-install

RC_FILE	= $(HOME)/.bashrc

.PHONY: brew
brew: brew-install

.PHONY: brew-install
brew-install:
	@if ! command -v brew >/dev/null 2>&1; then
		# Install requirements
		sudo apt-get update && sudo apt-get install -y build-essential procps curl file git
		# Install Homebrew
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		# Add brew to PATH
		test -d ~/.linuxbrew && eval "$$(~/.linuxbrew/bin/brew shellenv)"
		test -d /home/linuxbrew/.linuxbrew && eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
		shellenv="eval \"\$$($$(brew --prefix)/bin/brew shellenv)\""
		if ! grep -q "^$${shellenv}$$" "$(RC_FILE)"; then (echo; echo "$${shellenv}") >> "$(RC_FILE)"; fi
	fi
