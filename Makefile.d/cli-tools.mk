ALL_TARGETS	+= cli-tools
INSTALL_TARGETS	+= cli-tools-install

.PHONY: cli-tools
cli-tools: cli-tools-install

.PHONY: cli-tools-install
cli-tools-install: brew
	@brew install bat duf eza fd fzf ghq git-delta jesseduffield/lazygit/lazygit jesseduffield/lazydocker/lazydocker keychain ripgrep tldr zoxide
