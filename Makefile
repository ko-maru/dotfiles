DOTFILES_DIR	= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

ALL_TARGETS	+= install
INSTALL_TARGETS	+=

.ONESHELL:

include Makefile.d/*.mk

.PHONY: all
all: $(ALL_TARGETS)

.PHONY: install
install: $(INSTALL_TARGETS)

.PHONY: debug
debug:
