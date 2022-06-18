#!/bin/sh
# This script exports the CITRUS_PATH environment variable and sources the Oranges and Limes .config.sh scripts.

# Public: The path to the Citrus repository root.
export CITRUS_PATH="${CITRUS_PATH:-$(cd "$(dirname "$0")" && pwd)}"

#

# Public: This function re-sources the Oranges and Limes .config.sh scripts.
citrus_reload() {
	# shellcheck source=Oranges/.config.sh
	. "$CITRUS_PATH/Oranges/.config.sh"

	# shellcheck source=Limes/.config.sh
	. "$CITRUS_PATH/Limes/.config.sh"


	#. "$CITRUS_PATH/Lemons/.config.sh"
}

citrus_reload

#

# Public: This function prints help for the citrus command.
citrus_print_help() {
	cat << EOF
citrus management command

usage:

	citrus go
		cd to the Citrus repo's root directory.

	citrus open
		Open the Citrus project in an IDE.

	citrus reload
		Re-source the citrus shell scripts.
EOF
}

#

# Public: A helper command with several sub-commands:
#   go - changes the working directory to the Citrus repository
#   help - prints help
#   open - opens the Citrus project in an IDE
#   reload - re-sources the shell configuration scripts
citrus() {
	case "$1" in
		go) cd "$CITRUS_PATH" || exit 1 ;;
		help) citrus_print_help ;;
		open) cd "$CITRUS_PATH" && make open ;;
		reload) citrus_reload ;;
		"") citrus_print_help ;;
		*)
			echo "Unknown subcommand $1 requested"
			exit 1
	esac
}
