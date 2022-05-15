#!/usr/bin/env bash

# shellcheck disable=SC1090

export PATH="${HOME}/bin:${PATH}"
export PAGER="less"
export EDITOR="vim"
export VISUAL="vim"

[[ -f ~/.bashrc ]] && . ~/.bashrc