ALL_TARGETS	= mise

.PHONY: mise
mise: bash install-mise link-mise 

.PHONY: install-mise
install-mise: brew
	brew install mise


$(eval $(call generate_symlink_rules,mise,.miserc .zprofile .miseenv .zlogin .zlogout))

