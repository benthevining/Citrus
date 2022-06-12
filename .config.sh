#!/bin/sh

export CITRUS_PATH="${CITRUS_PATH:-$(cd "$(dirname "$0")" && pwd)}"

#

citrus_reload() {
	. "$CITRUS_PATH/Oranges/.config.sh"
	. "$CITRUS_PATH/Limes/.config.sh"
	#. "$CITRUS_PATH/Lemons/.config.sh"
}

citrus_reload

#

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
