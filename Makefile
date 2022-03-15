SHELL := /bin/sh
.ONESHELL:
.SHELLFLAGS: -euo
.DEFAULT_GOAL: help
.NOTPARALLEL:
.POSIX:

#

override CITRUS_ROOT = $(patsubst %/,%,$(strip $(dir $(realpath $(firstword $(MAKEFILE_LIST))))))

override THIS_MAKEFILE = $(CITRUS_ROOT)/Makefile

include $(CITRUS_ROOT)/scripts/util.make

#

help:  ## Print this message
	@$(call print_help)

#

init:  ## Initializes the workspace and installs all dependencies
	@chmod +x $(CITRUS_ROOT)/scripts/alphabetize_codeowners.py
	@cd $(CITRUS_ROOT) && $(call precommit_init)

pc:  ## Runs all pre-commit hooks over all files
	@cd $(CITRUS_ROOT) && $(call run_precommit)

# update all submodules

# run nitpick

# run pc in all submodules

# update util.make in submodules
