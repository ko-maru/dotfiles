ALL_TARGETS	= zsh

.PHONY: zsh
zsh: bash link-zsh

$(eval $(call generate_symlink_rules,zsh,.zshrc .zprofile .zshenv .zlogin .zlogout))

