ALL_TARGETS	= git

.PHONY: git
git: link-git

$(eval $(call generate_symlink_rules,git,.gitconfig))
