ALL_TARGETS	= bash

.PHONY: bash
bash: link-bash

$(eval $(call generate_symlink_rules,bash,.bashrc .profile .bash_profile .bash_login .bash_logout))
:
