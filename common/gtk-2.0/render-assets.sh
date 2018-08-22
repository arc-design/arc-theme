#!/bin/bash
set -ueo pipefail

# Make sure that parallel is GNU parallel and not moreutils.
# Otherwise, it fails silently. There's no smooth way to detect this.
if [[ "$(which parallel 2> /dev/null)" ]]; then
  cmd=(parallel)
else
  cmd=(xargs -n1)
fi


ASSETS_DIR="assets"
DARK_ASSETS_DIR="assets-dark"


"${cmd[@]}" ./render-asset.sh ${ASSETS_DIR} < assets.txt
"${cmd[@]}" ./render-asset.sh ${DARK_ASSETS_DIR} < assets.txt


cp $ASSETS_DIR/entry-toolbar.png menubar-toolbar/entry-toolbar.png
cp $ASSETS_DIR/entry-active-toolbar.png menubar-toolbar/entry-active-toolbar.png
cp $ASSETS_DIR/entry-disabled-toolbar.png menubar-toolbar/entry-disabled-toolbar.png

cp $ASSETS_DIR/menubar.png menubar-toolbar/menubar.png
cp $ASSETS_DIR/menubar_button.png menubar-toolbar/menubar_button.png


cp $DARK_ASSETS_DIR/button.png menubar-toolbar/button.png
cp $DARK_ASSETS_DIR/button-hover.png menubar-toolbar/button-hover.png
cp $DARK_ASSETS_DIR/button-active.png menubar-toolbar/button-active.png
cp $DARK_ASSETS_DIR/button-insensitive.png menubar-toolbar/button-insensitive.png

cp $DARK_ASSETS_DIR/entry-toolbar.png menubar-toolbar/entry-toolbar-dark.png
cp $DARK_ASSETS_DIR/entry-active-toolbar.png menubar-toolbar/entry-active-toolbar-dark.png
cp $DARK_ASSETS_DIR/entry-disabled-toolbar.png menubar-toolbar/entry-disabled-toolbar-dark.png

cp $DARK_ASSETS_DIR/menubar.png menubar-toolbar/menubar-dark.png
cp $DARK_ASSETS_DIR/menubar_button.png menubar-toolbar/menubar_button-dark.png

exit 0
