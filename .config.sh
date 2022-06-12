#!/bin/sh

export CITRUS_PATH="${CITRUS_PATH:-$(cd "$(dirname "$0")" && pwd)}"

. "$CITRUS_PATH/Oranges/.config.sh"
. "$CITRUS_PATH/Limes/.config.sh"
