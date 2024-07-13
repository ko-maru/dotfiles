DOTFILES_DIR	= $(realpath $(dir $(firstword $(MAKEFILE_LIST))))

ALL_TARGETS	+= 
INSTALL_TARGETS	+=
LINK_TARGETS	+=
UNLINK_TARGETS	+=

.ONESHELL:

define generate_symlink_rules
LINK_TARGETS	+= link-$(1)
UNLINK_TARGETS	+= unlink-$(1)

.PHONY: link-$(1)
link-$(1):
	@for dotfile in $(2); do
		ln -snfv "$$(DOTFILES_DIR)/$$$${dotfile}" "$$(HOME)/$$$${dotfile}" 
	done
unlink-$(1):
	@for dotfile in $(2); do
		if [ -e "$$(HOME)/$$$${dotfile}" ]; then
			unlink "$$(HOME)/$$$${dotfile}" 
		fi
	done
endef

include Makefile.d/*.mk

.PHONY: all
all: $(ALL_TARGETS)

.PHONY: install
install: $(INSTALL_TARGETS)

.PHONY: link
link: $(LINK_TARGETS)

.PHONY: unlink
unlink: $(UNLINK_TARGETS)

.PHONY: debug
debug:
	@echo '$(call symlink,git,.gitconfig)'
