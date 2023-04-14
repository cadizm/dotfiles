.PHONY: sync

REPOSITORY = $(shell pwd)

sync:
	. ${HOME}/.venvs/dotfiles/bin/activate; \
	dotfiles --sync --force --repo=$(REPOSITORY) --config=$(REPOSITORY)/.dotfilesrc
