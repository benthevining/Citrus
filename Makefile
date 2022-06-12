SHELL := /bin/sh
.ONESHELL:
.SHELLFLAGS: -euo
.DEFAULT_GOAL: help
.NOTPARALLEL:
.POSIX:

#

override CITRUS_ROOT = $(patsubst %/,%,$(strip $(dir $(realpath $(firstword $(MAKEFILE_LIST))))))

include $(CITRUS_ROOT)/Limes/util/util.make

override BUILDS = $(CITRUS_ROOT)/Builds

ORANGES ?= $(CITRUS_ROOT)/Oranges
LIMES ?= $(CITRUS_ROOT)/Limes
LEMONS ?= $(CITRUS_ROOT)/Lemons

#

.PHONY: help
help:  ## Print this message
	@$(call print_help,"$(CITRUS_ROOT)/Makefile")

#

.PHONY: init
init:  ## Initializes the workspace and installs all dependencies
	@cd $(CITRUS_ROOT) && \
		$(PRECOMMIT) install --install-hooks --overwrite && \
		$(PRECOMMIT) install --install-hooks --overwrite --hook-type commit-msg
	@cd $(ORANGES) && make init
	@cd $(LIMES) && make init
	@cd $(LEMONS) && make init

#

$(BUILDS):
	@cd $(CITRUS_ROOT) && $(CMAKE) --preset maintainer

.PHONY: config
config: $(BUILDS) ## configure CMake

.PHONY: open
open: config ## Opens the Citrus project in an IDE
	$(CMAKE) --open $(BUILDS)

#

.PHONY: build
build: config ## runs CMake build
	@cd $(CITRUS_ROOT) && $(CMAKE) --build --preset maintainer --config $(CONFIG)

#

$(BUILDS)/install_manifest.txt:
	$(SUDO) $(CMAKE) --install $(BUILDS) --config $(CONFIG)

.PHONY: install
install: $(BUILDS)/install_manifest.txt ## runs CMake install

#

.PHONY: pc
pc:  ## Runs all pre-commit hooks over all files
	@cd $(CITRUS_ROOT) && $(GIT) add . && $(PRECOMMIT) run --all-files

.PHONY: pcr
pcr: pc ## Runs pre-commit over every repo, recursively
	@cd $(ORANGES) && make pc
	@cd $(LIMES) && make pc
	@cd $(LEMONS) && make pc

#

.PHONY: uninstall
uninstall: config ## Runs uninstall script
	$(SUDO) $(CMAKE) -P $(BUILDS)/uninstall.cmake

.PHONY: clean
clean: ## Cleans the source tree
	@echo "Cleaning..."
	$(RM) $(BUILDS)
	$(PRECOMMIT) gc
	@cd $(ORANGES) && make clean
	@cd $(LIMES) && make clean
	@cd $(LEMONS) && make clean

.PHONY: wipe
wipe: clean ## Wipes the cache of downloaded dependencies
	@echo "Wiping cache..."
	$(RM) $(CACHE)
