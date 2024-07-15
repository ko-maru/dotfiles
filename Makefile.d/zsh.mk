ALL_TARGETS	= zsh

.PHONY: zsh
zsh: bash link-zsh install-zsh-autosuggestions install-zsh-syntax-highlighting

.PHONY: install-zsh-autosuggestions
install-zsh-autosuggestions: brew
	brew install zsh-autosuggestions

.PHONY: install-zsh-syntax-highlighting
install-zsh-syntax-highlighting: brew
	brew install zsh-syntax-highlighting

$(eval $(call generate_symlink_rules,zsh,.zshrc .zprofile .zshenv .zlogin .zlogout))

