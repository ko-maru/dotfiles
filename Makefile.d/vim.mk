ALL_TARGETS	= vim

.PHONY: vim
vim: install-vim link-vim 

.PHONY: install-vim
install-vim: brew
	brew install neovim unzip ripgrep fd node

$(eval $(call generate_symlink_rules,vim,.vimrc .config/nvim))

