#!/usr/bin/env bash
# shellcheck disable=SC1090
#set -x
set -ueo pipefail

SRC_PATH="$(readlink -f "$(dirname "$0")")"

darker() {
	"$SRC_PATH/scripts/darker.sh" "$@"
}
mix() {
	"$SRC_PATH/scripts/mix.sh" "$@"
}
is_dark() {
	hexinput="$(tr '[:lower:]' '[:upper:]' <<< "$1")"
	half_darker="$(darker "$hexinput" 88)"
	[[ "$half_darker" == "000000" ]]
}


print_usage() {
	echo "usage: $0 [-o OUTPUT_THEME_NAME] [-a AUTOGEN_OPTS] [-j JOBS] PATH_TO_PRESET"
	echo
	echo "examples:"
	# shellcheck disable=SC2028 # This is meant to be usage text.
	echo "	$0 --output my-theme-name <(echo -e \"BG=d8d8d8\\nFG=101010\\nMENU_BG=3c3c3c\\nMENU_FG=e6e6e6\\nSEL_BG=ad7fa8\\nSEL_FG=ffffff\\nTXT_BG=ffffff\\nTXT_FG=1a1a1a\\nBTN_BG=f5f5f5\\nBTN_FG=111111\\n\")"
	echo "	$0 ../colors/retro/twg"
	echo "	$0 --autogen-opts '--disable-cinnamon --disable-gnome-shell' --jobs 4 ../colors/retro/clearlooks"
	exit 1
}

AUTOGEN_OPTS=""
unset JOBS

while [[ "$#" -gt 0 ]]; do
	case "$1" in
		-o|--output)
			OUTPUT_THEME_NAME="$2"
			shift
			;;
		-d|--hidpi)
			OPTION_GTK2_HIDPI="$2"
			shift
			;;
		-a|--autogen-opts)
			AUTOGEN_OPTS="${2}"
			shift
			;;
		-j|--jobs)
			JOBS="${2}"
			shift
		;;
		*)
			if [[ "$1" == -* ]] || [[ "${THEME-}" ]]; then
				echo "unknown option $1"
				print_usage
				exit 2
			fi
			THEME="$1"
			;;
	esac
	shift
done

if [[ -z "${THEME:-}" ]]; then
	print_usage
fi

OPTION_GTK2_HIDPI=$(tr '[:upper:]' '[:lower:]' <<< "${OPTION_GTK2_HIDPI-False}")
export OPTION_GTK2_HIDPI


if [[ "$THEME" == */* ]] || [[ "$THEME" == *.* ]]; then
	source "$THEME"
	THEME=$(basename "$THEME")
else
	if [[ -f "$SRC_PATH/../colors/$THEME" ]]; then
		source "$SRC_PATH/../colors/$THEME"
	else
		echo "Theme '$THEME' not found"
		exit 1
	fi
fi
if [[ $(date +"%m%d") = "0401" ]] && grep -q "no-jokes" <<< "$*"; then
	echo -e "\\n\\nError patching uxtheme.dll\\n\\n"
	ACCENT_BG=000000 BG=C0C0C0 BTN_BG=C0C0C0 BTN_FG=000000 FG=000000
	HDR_BTN_BG=C0C0C0 HDR_BTN_FG=000000 MENU_BG=C0C0C0
	MENU_FG=000000 SEL_BG=000080 SEL_FG=FFFFFF TXT_BG=FFFFFF TXT_FG=000000
fi

ARC_TRANSPARENCY=$(tr '[:upper:]' '[:lower:]' <<< "${ARC_TRANSPARENCY-True}")
ARC_WIDGET_BORDER_COLOR=${ARC_WIDGET_BORDER_COLOR-$(mix ${BG} ${FG} 0.75)}

TXT_FG=$FG
BTN_FG=$FG
HDR_BTN_FG=$MENU_FG

ACCENT_BG=${ACCENT_BG-$SEL_BG}
HDR_BTN_BG=${HDR_BTN_BG-$BTN_BG}
# Not implemented yet:
HDR_BTN_FG=${HDR_BTN_FG-$BTN_FG}
WM_BORDER_FOCUS=${WM_BORDER_FOCUS-$SEL_BG}
WM_BORDER_UNFOCUS=${WM_BORDER_UNFOCUS-$MENU_BG}
SPACING=${SPACING-3}
GRADIENT=${GRADIENT-0}
ROUNDNESS=${ROUNDNESS-2}
ROUNDNESS_GTK2_HIDPI=$(( ROUNDNESS * 2 ))

TERMINAL_COLOR1=${TERMINAL_COLOR1:-F04A50}
TERMINAL_COLOR3=${TERMINAL_COLOR3:-F08437}
TERMINAL_COLOR4=${TERMINAL_COLOR4:-1E88E5}
TERMINAL_COLOR5=${TERMINAL_COLOR5:-E040FB}
TERMINAL_COLOR9=${TERMINAL_COLOR9:-DD2C00}
TERMINAL_COLOR10=${TERMINAL_COLOR10:-00C853}
TERMINAL_COLOR11=${TERMINAL_COLOR11:-FF6D00}
TERMINAL_COLOR12=${TERMINAL_COLOR12:-66BB6A}

INACTIVE_FG=$(mix "$FG" "$BG" 0.75)
INACTIVE_BG=$(mix "$BG" "$FG" 0.75)
INACTIVE_MENU_FG=$(mix "$MENU_FG" "$MENU_BG" 0.75)
INACTIVE_MENU_BG=$(mix "$MENU_BG" "$MENU_FG" 0.75)
INACTIVE_TXT_MIX=$(mix "$TXT_FG" "$TXT_BG")
INACTIVE_TXT_FG=$(mix "$TXT_FG" "$TXT_BG" 0.75)
INACTIVE_TXT_BG=$(mix "$TXT_BG" "$BG" 0.75)

OUTPUT_THEME_NAME=${OUTPUT_THEME_NAME-oomox-arc-$THEME}
DEST_PATH="$HOME/.themes/${OUTPUT_THEME_NAME/\//-}"

if [[ "$SRC_PATH" == "$DEST_PATH" ]]; then
	echo "can't do that"
	exit 1
fi

if [[ ! -d "$(dirname "${DEST_PATH}")" ]] ; then
	mkdir -p "${DEST_PATH}"
fi


tempdir=$(mktemp -d)
post_clean_up() {
	rm -r "$tempdir"
}
trap post_clean_up EXIT SIGHUP SIGINT SIGTERM
cp -r "$SRC_PATH/"* "$tempdir/"
cd "$tempdir"


echo "== Converting theme into template..."

PATHLIST=(
	'./common/'
)
for FILEPATH in "${PATHLIST[@]}"; do
		find "$FILEPATH" -type f -exec sed -i'' \
			-e 's/#cfd6e6/%ARC_WIDGET_BORDER_COLOR%/gI' \
			-e 's/#f5f6f7/%BG%/gI' \
			-e 's/#dde3e9/%BG_DARKER%/gI' \
			-e 's/#3b3e45/%FG%/gI' \
			-e 's/#FFFFFF/%TXT_BG%/gI' \
			-e 's/#3b3e45/%TXT_FG%/gI' \
			-e 's/#5294e2/%SEL_BG%/gI' \
			-e 's/#fcfdfd/%BTN_BG%/gI' \
			-e 's/#e7e8eb/%MENU_BG%/gI' \
			-e 's/#2f343f/%MENU_BG%/gI' \
			-e 's/#D3DAE3/%MENU_FG%/gI' \
			-e 's/#fbfcfc/%INACTIVE_BG%/gI' \
			-e 's/#a9acb2/%INACTIVE_FG%/gI' \
			-e 's/#e2e7ef/%BG_DARKER%/gI' \
			-e 's/#F04A50/%TERMINAL_COLOR1%/gI' \
			-e 's/#F08437/%TERMINAL_COLOR3%/gI' \
			-e 's/#FC4138/%TERMINAL_COLOR9%/gI' \
			-e 's/#73d216/%TERMINAL_COLOR10%/gI' \
			-e 's/#F27835/%TERMINAL_COLOR11%/gI' \
			-e 's/#4DADD4/%TERMINAL_COLOR12%/gI' \
			-e 's/#353945/%MENU_BG2%/gI' \
			-e 's/Name=Arc/Name=%OUTPUT_THEME_NAME%/g' \
			-e 's/#f46067/%TERMINAL_COLOR9%/gI' \
			-e 's/#cc575d/%TERMINAL_COLOR9%/gI' \
			-e 's/#f68086/%TERMINAL_COLOR9_LIGHTER%/gI' \
			-e 's/#d7787d/%TERMINAL_COLOR9_LIGHTER%/gI' \
			-e 's/#f13039/%TERMINAL_COLOR9_DARKER%/gI' \
			-e 's/#be3841/%TERMINAL_COLOR9_DARKER%/gI' \
			-e 's/#F8F8F9/%MENU_FG%/gI' \
			-e 's/#fdfdfd/%MENU_FG%/gI' \
			-e 's/#454C5C/%MENU_FG%/gI' \
			-e 's/#D1D3DA/%MENU_FG%/gI' \
			-e 's/#90949E/%MENU_FG%/gI' \
			-e 's/#90939B/%MENU_FG%/gI' \
			-e 's/#B6B8C0/%INACTIVE_MENU_FG%/gI' \
			-e 's/#666A74/%INACTIVE_MENU_FG%/gI' \
			-e 's/#7A7F8B/%INACTIVE_MENU_FG%/gI' \
			-e 's/#C4C7CC/%INACTIVE_MENU_FG%/gI' \
			-e 's/#BAC3CF/%MENU_FG%/gI' \
			-e 's/#4B5162/%TXT_FG%/gI' \
			-e 's/#AFB8C5/%MENU_FG%/gI' \
			-e 's/#404552/%MENU_BG%/gI' \
			-e 's/#383C4A/%MENU_BG%/gI' \
			-e 's/#5c616c/%FG%/gI' \
			-e 's/#d3d8e2/%SEL_BG%/gI' \
			-e 's/#b7c0d3/%SEL_BG%/gI' \
			-e 's/#cbd2e3/%ARC_WIDGET_BORDER_COLOR%/gI' \
			-e 's/#fcfcfc/%TXT_BG%/gI' \
			-e 's/#dbdfe3/%INACTIVE_TXT_BG%/gI' \
			-e 's/#eaebed/%INACTIVE_TXT_BG%/gI' \
			-e 's/#b8babf/%INACTIVE_TXT_MIX%/gI' \
			-e 's/#d3d4d8/%INACTIVE_TXT_FG%/gI' \
			-e 's/#d7d8dd/%MENU_BG2%/gI' \
			-e 's/#262932/%MENU_BG2%/gI' \
			{} \; ;
done

#Not implemented yet:
			#-e 's/%HDR_BTN_FG%/'"$HDR_BTN_FG"'/g' \
			#-e 's/%WM_BORDER_FOCUS%/'"$WM_BORDER_FOCUS"'/g' \
			#-e 's/%WM_BORDER_UNFOCUS%/'"$WM_BORDER_UNFOCUS"'/g' \
			#-e 's/%SPACING%/'"$SPACING"'/g' \
			#-e 's/%INACTIVE_MENU_FG%/'"$INACTIVE_MENU_FG"'/g' \
			#-e 's/#01A299/%ACCENT_BG%/g' \

#sed -i -e 's/^$material_radius: .px/$material_radius: '"$ROUNDNESS"'px/g' ./src/_sass/gtk/_variables.scss

if [[ "${DEBUG:-}" ]]; then
	echo "You can debug TEMP DIR: $tempdir, press [Enter] when finished"
	read -r answer
	if [[ "${answer}" = "q" ]] ; then
		exit 125
	fi
fi

for template_file in $(find ./common -name '*.thpl') ; do
	cat "${template_file}" >> "${template_file::-5}"
done

ASSETS_FILES=(
	'./common/gtk-2.0/light/assets.svg'
	'./common/gtk-2.0/dark/assets.svg'
	'./common/gtk-3.0/3.18/assets.svg'
	'./common/gtk-3.0/3.20/assets.svg'
)
for assets_file in "${ASSETS_FILES[@]}"; do
	sed -i'' -e 's/%SEL_BG%/%ACCENT_BG%/g' "${assets_file}"
done

echo "== Filling the template with the new colorscheme..."
for FILEPATH in "${PATHLIST[@]}"; do
	find "$FILEPATH" -type f -exec sed -i'' \
		-e 's/%ARC_WIDGET_BORDER_COLOR%/#'"$ARC_WIDGET_BORDER_COLOR"'/g' \
		-e 's/%BG%/#'"$BG"'/g' \
		-e 's/%BG_DARKER%/#'"$(darker $BG)"'/g' \
		-e 's/%FG%/#'"$FG"'/g' \
		-e 's/%ACCENT_BG%/#'"$ACCENT_BG"'/g' \
		-e 's/%SEL_BG%/#'"$SEL_BG"'/g' \
		-e 's/%SEL_FG%/#'"$SEL_FG"'/g' \
		-e 's/%TXT_BG%/#'"$TXT_BG"'/g' \
		-e 's/%TXT_FG%/#'"$TXT_FG"'/g' \
		-e 's/%MENU_BG%/#'"$MENU_BG"'/g' \
		-e 's/%MENU_BG2%/#'"$(mix $MENU_BG $BG 0.85)"'/g' \
		-e 's/%MENU_FG%/#'"$MENU_FG"'/g' \
		-e 's/%BTN_BG%/#'"$BTN_BG"'/g' \
		-e 's/%BTN_FG%/#'"$BTN_FG"'/g' \
		-e 's/%HDR_BTN_BG%/#'"$HDR_BTN_BG"'/g' \
		-e 's/%HDR_BTN_FG%/#'"$HDR_BTN_FG"'/g' \
		-e 's/%WM_BORDER_FOCUS%/#'"$WM_BORDER_FOCUS"'/g' \
		-e 's/%WM_BORDER_UNFOCUS%/#'"$WM_BORDER_UNFOCUS"'/g' \
		-e 's/%SPACING%/'"$SPACING"'/g' \
		-e 's/%INACTIVE_FG%/#'"$INACTIVE_FG"'/g' \
		-e 's/%INACTIVE_BG%/#'"$INACTIVE_BG"'/g' \
		-e 's/%INACTIVE_TXT_MIX%/#'"$INACTIVE_TXT_MIX"'/g' \
		-e 's/%INACTIVE_TXT_FG%/#'"$INACTIVE_TXT_FG"'/g' \
		-e 's/%INACTIVE_TXT_BG%/#'"$INACTIVE_TXT_BG"'/g' \
		-e 's/%INACTIVE_MENU_FG%/#'"$INACTIVE_MENU_FG"'/g' \
		-e 's/%INACTIVE_MENU_BG%/#'"$INACTIVE_MENU_BG"'/g' \
		-e 's/%TERMINAL_COLOR1%/#'"$TERMINAL_COLOR1"'/g' \
		-e 's/%TERMINAL_COLOR3%/#'"$TERMINAL_COLOR3"'/g' \
		-e 's/%TERMINAL_COLOR4%/#'"$TERMINAL_COLOR4"'/g' \
		-e 's/%TERMINAL_COLOR5%/#'"$TERMINAL_COLOR5"'/g' \
		-e 's/%TERMINAL_COLOR9%/#'"$TERMINAL_COLOR9"'/g' \
		-e 's/%TERMINAL_COLOR9_DARKER%/#'"$(darker $TERMINAL_COLOR9 10)"'/g' \
		-e 's/%TERMINAL_COLOR9_LIGHTER%/#'"$(darker $TERMINAL_COLOR9 -10)"'/g' \
		-e 's/%TERMINAL_COLOR10%/#'"$TERMINAL_COLOR10"'/g' \
		-e 's/%TERMINAL_COLOR11%/#'"$TERMINAL_COLOR11"'/g' \
		-e 's/%TERMINAL_COLOR12%/#'"$TERMINAL_COLOR12"'/g' \
		-e 's/%OUTPUT_THEME_NAME%/'"$OUTPUT_THEME_NAME"'/g' \
		{} \; ;
done

#if [[ "$OPTION_GTK2_HIDPI" == "true" ]]; then
	#mv ./src/gtk-2.0/main.rc.hidpi ./src/gtk-2.0/main.rc
#fi
#if [[ "$EXPORT_QT5CT" = 1 ]]; then
	#config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}
	#qt5ct_colors_dir="$config_home/qt5ct/colors/"
	#test -d "$qt5ct_colors_dir" || mkdir -p "$qt5ct_colors_dir"
	#mv ./src/qt5ct_palette.conf "$qt5ct_colors_dir/$OUTPUT_THEME_NAME.conf"
#fi

if [[ "$ARC_TRANSPARENCY" == "false" ]]; then
	AUTOGEN_OPTS="${AUTOGEN_OPTS} --disable-transparency"
fi

echo "== Making theme..."
mkdir distrib
./autogen.sh --prefix="$(readlink -e ./distrib/)" --disable-light --disable-dark "${AUTOGEN_OPTS}"
make --jobs="${JOBS:-$(nproc || echo 1)}" install
echo

echo
rm -fr "${DEST_PATH}"
if [[ "$ARC_TRANSPARENCY" == "false" ]]; then
	mv ./distrib/share/themes/Arc-Darker-solid "${DEST_PATH}"
	if [[ -d ./distrib/share/themes/Arc-solid/cinnamon ]] ; then
		mv ./distrib/share/themes/Arc-solid/cinnamon "${DEST_PATH}"/cinnamon
	fi
	if [[ -d ./distrib/share/themes/Arc-solid/gnome-shell ]] ; then
		mv ./distrib/share/themes/Arc-solid/gnome-shell "${DEST_PATH}"/gnome-shell
	fi
else
	mv ./distrib/share/themes/Arc-Darker "${DEST_PATH}"
	if [[ -d ./distrib/share/themes/Arc/cinnamon ]] ; then
		mv ./distrib/share/themes/Arc/cinnamon "${DEST_PATH}"/cinnamon
	fi
	if [[ -d ./distrib/share/themes/Arc/gnome-shell ]] ; then
		mv ./distrib/share/themes/Arc/gnome-shell "${DEST_PATH}"/gnome-shell
	fi
fi


cd "${DEST_PATH}"
cp ./gtk-2.0/assets/focus-line.png ./gtk-2.0/assets/frame.png
cp ./gtk-2.0/assets/null.png ./gtk-2.0/assets/frame-gap-start.png
cp ./gtk-2.0/assets/null.png ./gtk-2.0/assets/frame-gap-end.png
cp ./gtk-2.0/assets/null.png ./gtk-2.0/assets/line-v.png
cp ./gtk-2.0/assets/null.png ./gtk-2.0/assets/line-h.png


echo "== The theme was installed to ${DEST_PATH}"
echo
exit 0
