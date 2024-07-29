ALL_TARGETS	= tmux

.PHONY: tmux
tmux: install-tmux link-tmux 

.PHONY: install-tmux
install-tmux: brew
	brew install tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

$(eval $(call generate_symlink_rules,tmux,.tmux.conf))

