# Arc Pro Theme

Arc Pro is a flat theme with transparent elements for GTK 3, GTK 2 and GNOME Shell which supports GTK 3 and GTK 2 based desktop environments like GNOME, Unity, Budgie, Pantheon, Xfce, MATE, etc.

Only GTK 3 (Gnome / Budgie) is somewhat supported at the moment, this theme is very much a work in progress. (Any help is much appreciated.)

This version is a basic spin / hack in an attempt to make it dark gray, so expect most of it to not work properly.

## Arc-Pro will be available in three variants 

##### Arc-Pro (TODO)

##### Arc-Pro-Dusk (TODO)

##### Arc-Pro-Night (Experimental / WIP) - Budgie Screenshot

![A screenshot of the Arc-Dark theme](https://i.imgur.com/Pf6opUO.png)

### Manual Installation

#### This theme is only being tested on the Gnome 3.22 version, others will still default to the original theme.

To build the theme the follwing packages are required 
* `autoconf`
* `automake`
* `pkg-config` or `pkgconfig` for Fedora
* `libgtk-3-dev` for Debian based distros or `gtk3-devel` for RPM based distros
* `git` to clone the source directory

**Note:** For distributions which don't ship separate development packages, just the GTK 3 package is needed instead of the `-dev` packages.

For the theme to function properly, install the following
* GNOME Shell 3.14 - 3.24, GTK 3.14 - 3.22
* The `gnome-themes-standard` package
* The murrine engine. This has different names depending on the distro.
  * `gtk-engine-murrine` (Arch Linux)
  * `gtk2-engines-murrine` (Debian, Ubuntu, elementary OS)
  * `gtk-murrine-engine` (Fedora)
  * `gtk2-engine-murrine` (openSUSE)
  * `gtk-engines-murrine` (Gentoo)

Install the theme with the following commands

#### 1. Get the source

Clone the git repository with

    git clone https://github.com/mantissa-/arc-pro-theme --depth 1 && cd arc-pro-theme

#### 2. Build and install the theme

    ./autogen.sh --prefix=/usr
    sudo make install

Other options to pass to autogen.sh are

    --disable-transparency     disable transparency in the GTK3 theme
    --disable-light            disable Arc Pro support
    --disable-darker           disable Arc Pro Dusk support
    --disable-dark             disable Arc Pro Night support
    --disable-cinnamon         disable Cinnamon support
    --disable-gnome-shell      disable GNOME Shell support
    --disable-gtk2             disable GTK2 support
    --disable-gtk3             disable GTK3 support
    --disable-metacity         disable Metacity support
    --disable-unity            disable Unity support
    --disable-xfwm             disable XFWM support

    --with-gnome=<version>     build the theme for a specific GNOME version (3.14, 3.16, 3.18, 3.20, 3.22)
                               Note 1: Normally the correct version is detected automatically and this
                               option should not be needed.
                               Note 2: For GNOME 3.24, use --with-gnome-version=3.22
                               (this works for now, the build system will be improved in the future)

After the installation is complete the theme can be activated with `gnome-tweak-tool` or a similar program by selecting `Arc-Pro`, `Arc-Pro-Dusk` or `Arc-Pro-Night` as Window/GTK+ theme and `Arc-Pro` or `Arc-Pro-Night` as GNOME Shell/Cinnamon theme.

If the `--disable-transparency` option was used, the theme will be installed as `Arc-Pro-solid`, `Arc-Pro-Dusk-solid` and `Arc-Pro-Night-solid`.

## Uninstall

Run

    sudo make uninstall

from the cloned git repository, or

    sudo rm -rf /usr/share/themes/{Arc-Pro,Arc-Pro-Dusk,Arc-Pro-Night}


## Troubleshooting

If you use Ubuntu with a newer GTK/GNOME version than the one included by default (i.e Ubuntu 14.04 with GTK 3.14 or Ubuntu 15.04 with GTK 3.16, etc.) the prebuilt packages won't work properly and the theme has to be installed manually as described above.
This is also true for other distros with a different GTK/GNOME version than the one included by default

--

If you get artifacts like black or invisible backgrounds under Unity, disable overlay scrollbars with

    gsettings set com.canonical.desktop.interface scrollbar-mode normal


## Bugs
If you find a bug, please report it at https://github.com/mantissa-/arc-pro-theme/issues
I'm very slowly porting (hacking) this theme in my free time though, so don't expect any wonders.

## License
Arc Pro is available under the terms of the GPL-3.0. See `COPYING` for details.
