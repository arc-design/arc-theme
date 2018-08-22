#!/bin/bash
set -ueo pipefail

INKSCAPE="$(which inkscape)"
OPTIPNG="$(which optipng)"

ASSETS_DIR="$1"
SRC_FILE="${ASSETS_DIR}".svg

i="$2"


result_file="$ASSETS_DIR/$i.png"
if [[ -f "${result_file}" ]] ; then
	echo "${result_file} already exists."
else
	echo "Rendering '${result_file}'"
	if [[ "${OPTION_GTK2_HIDPI:-false}" != "true" ]]; then
		"$INKSCAPE" --export-id="$i" \
					--export-id-only \
					--export-png="${result_file}" "$SRC_FILE" >/dev/null
	else
		"$INKSCAPE" --export-id="$i" \
					--export-id-only \
					--export-dpi=192 \
					--export-png="${result_file}" "$SRC_FILE" >/dev/null
	fi
	"$OPTIPNG" -o7 --quiet "${result_file}"
fi
