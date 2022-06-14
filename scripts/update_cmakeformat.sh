#!/usr/bin/sh

script_dir="$(cd "$(dirname "$0")" && pwd)"
readonly script_dir

readonly citrus_root="$script_dir/.."

readonly output_file="$citrus_root/.cmake-format.json"

readonly python_script="$citrus_root/Oranges/scripts/update_cmakeformat_config.py"

python3 "$python_script" \
	--input "$citrus_root/Oranges/util/OrangesCMakeCommands.json" \
	--output "$output_file"

python3 "$python_script" \
	--input "$citrus_root/Limes/util/LimesCMakeCommands.json" \
	--output "$output_file"
