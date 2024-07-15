ALL_TARGETS	= starship

.PHONY: starship
starship: install-starship link-starship 

.PHONY: install-starship
install-starship: brew
	brew install starship

$(eval $(call generate_symlink_rules,starship,.config/starship.toml))

