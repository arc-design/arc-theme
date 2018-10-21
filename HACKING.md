This theme uses node-sass/libsass to process the various .scss files. Never edit any of the .css files manually.

#### Editing the CSS based themes in the `common` directory (cinnamon, gnome-shell, gtk-3.0)

* Edit the `common/*/sass/*.scss` files

* Run `make` to generate all css files using sassc (starting with version 20180114). Gulp is no longer required.

--

#### Editing the GTK 2 themes

* Go to `common/gtk-2.0`

* The colors and includes are defined in `light/gtkrc`, `dark/gtkrc` and `darker/gtkrc` for each theme variant

* `main.rc` contains the major part of the theme

* `panel.rc` contains the panel styling for Xfce and MATE

* `apps.rc` contains some application specific rules

Because this theme is heavily based on the pixmap engine, a lot of the styling comes from the images in the `light/assets` and `dark/assets` folders. Don't edit these images directly. See the next section.

--

#### Editing the images for the GTK 2 and GTK 3 themes

* Go to the `common/gtk-2.0/light`, `common/gtk-2.0/dark`, or `common/gtk-3.0/$gtk-version` directory.

* Open the `assets.svg` file in inkscape. Each object in the .svg file corresponds to an image in the `assets` folder.

* Find the object you want to edit and make your changes. Important: Don't change the object id!

* Save `assets.svg` and run `make` (or `make -j$(nproc)` if you're in a hurry) from a terminal in the parent directory.
