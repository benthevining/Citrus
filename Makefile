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
	@cd $(CITRUS_ROOT)/Oranges && $(MAKE) init
	@cd $(CITRUS_ROOT)/Limes && $(MAKE) init

pc:  ## Runs all pre-commit hooks over all files
	@cd $(CITRUS_ROOT) && $(call run_precommit)
	@echo "Checking Oranges..."
	@cd $(CITRUS_ROOT)/Oranges && $(MAKE) pc
	@echo "Checking Limes..."
	@cd $(CITRUS_ROOT)/Limes && $(MAKE) pc

update: ## Update all git submodules
	@cd $(CITRUS_ROOT) && $(GIT) submodule update

# update util.make in submodules
