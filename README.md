# Arc Theme

Arc is a flat theme with transparent elements for GTK 3, GTK 2 and GNOME Shell which supports GTK 3 and GTK 2 based desktop environments like GNOME, Unity, Pantheon, Xfce, MATE, Cinnamon (>=3.4), Budgie Desktop (10.4 for GTK+3.22) etc.

The NicoHood/arc-theme repository is a fork of the horst3180/arc-theme repository  which as been umaintained since March 2017.
Its aim is to continue the maintenance of arc-theme. The two maintainers are the Arch-Linux and Debian & Ubuntu packaging maintainers.

It is strongly encouraged to submit pull-requests to suggest fixes and enhancements.

## Arc is available in three variants

##### Arc

![A screenshot of the Arc theme](http://i.imgur.com/Ph5ObOa.png)

##### Arc-Darker

![A screenshot of the Arc-Darker theme](http://i.imgur.com/NC6dqyl.png)

##### Arc-Dark

![A screenshot of the Arc-Dark theme](http://i.imgur.com/5AGlCnA.png)

## Installation

### Packages

|Distro|Package Name/Link|
|:----:|:----:|
| Arch Linux | [`arc-gtk-theme`](https://www.archlinux.org/packages/community/any/arc-gtk-theme/), [`arc-solid-gtk-theme`](https://www.archlinux.org/packages/community/any/arc-solid-gtk-theme/) |
| Debian | `arc-theme` |
| Fedora | `arc-theme` |
| Gentoo/Funtoo | `x11-themes/arc-theme` from the [Scriptkitties Overlay][sk-overlay] |
| Sabayon | `arc-theme`
| Solus | `arc-gtk-theme` |
| Ubuntu 16.10 and later | `arc-theme`
| Ubuntu 16.04 and later | `arc-theme` from [fossfreedom/arc-gtk-theme-daily](https://launchpad.net/~fossfreedom/+archive/ubuntu/arc-gtk-theme-daily) |
| FreeBSD | `x11-themes/gtk-arc-themes` |

--

### Manual Installation

To build the theme the following packages are required
* `autoconf`
* `automake`
* `sassc` for GTK 3, Cinnamon, or GNOME Shell
* `pkg-config` or `pkgconfig` for Fedora
* `git` to clone the source directory
* `optipng` for GTK 2, GTK 3, or XFWM
* `inkscape` for GTK 2, GTK 3, or XFWM

The following packages are optionally required
* `gnome-shell`for auto-detecting the GNOME Shell version
* `libgtk-3-dev` for Debian based distros or `gtk3-devel` for RPM based distros, for auto-detecting the GTK3 version

**Note:** For distributions which don't ship separate development packages, just the GTK 3 package is needed instead of the `-dev` packages.

For the theme to function properly, install the following
* GNOME Shell 3.18 - 3.32, GTK 3.18 - 3.24
* The `gnome-themes-extra` package
* The murrine engine. This has different names depending on the distro.
  * `gtk-engine-murrine` (Arch Linux)
  * `gtk2-engines-murrine` (Debian, Ubuntu, elementary OS)
  * `gtk-murrine-engine` (Fedora)
  * `gtk2-engine-murrine` (openSUSE)
  * `gtk-engines-murrine` (Gentoo)

Install the theme with the following commands

#### 1. Get the source

Clone the git repository with

    git clone https://github.com/NicoHood/arc-theme --depth 1 && cd arc-theme

#### 2. Build and install the theme

    ./autogen.sh --prefix=/usr
    sudo make install

Other options to pass to autogen.sh are

    --disable-transparency         disable transparency in the GTK3 theme
    --disable-light                disable Arc Light support
    --disable-darker               disable Arc Darker support
    --disable-dark                 disable Arc Dark support
    --disable-cinnamon             disable Cinnamon support
    --disable-gnome-shell          disable GNOME Shell support
    --disable-gtk2                 disable GTK2 support
    --disable-gtk3                 disable GTK3 support
    --disable-metacity             disable Metacity support
    --disable-unity                disable Unity support
    --disable-xfwm                 disable XFWM support
    --disable-plank                disable Plank theme support
    --disable-openbox              disable Openbox support

    --with-gnome-shell=<version>   build the gnome-shell theme for a specific version
    --with-gtk3=<version>          build the GTK3 theme for a specific version
                                   Note: Normally the correct version is detected automatically
                                   and these options should not be needed.
    
After the installation is complete the theme can be activated with `gnome-tweak-tool` or a similar program by selecting `Arc`, `Arc-Darker` or `Arc-Dark` as Window/GTK+ theme and `Arc` or `Arc-Dark` as GNOME Shell/Cinnamon theme.

If the `--disable-transparency` option was used, the theme will be installed as `Arc-solid`, `Arc-Darker-solid` and `Arc-Dark-solid`.

## Uninstall

Run

    sudo make uninstall

from the cloned git repository, or

    sudo rm -rf /usr/share/themes/{Arc,Arc-Darker,Arc-Dark}

## Extras

### Arc KDE
A port of Arc for the Plasma 5 desktop with a few additions and extras. Available [here](https://github.com/PapirusDevelopmentTeam/arc-kde).

### Arc icon theme
The Arc icon theme is available at https://github.com/NicoHood/arc-icon-theme

### Plank theme
As of version `20180114` the plank theme will be installed along with the normal arc gtk theme. You can disable the install by passing `disable-plank` to the autogen command.
Now open the Plank preferences window by executing `plank --preferences` from a terminal and select `Gtk+` as the theme.

### FirefoxColor theme
Arc color palettes for FirefoxColor testpilot project

1.[Arc](https://color.firefox.com/?theme=XQAAAALsAAAAAAAAAABBqYhm849SCiazH1KEGccwS-xNVAWBveAusLC2VAlvlSjJ6UJSeqAgCYbdusEoPO6gs3O7v6uHbeft01vfMj--IcmWccV5ZVhbS5pAY21H4rQoo83UfS5UcAgLsFRnmMUloj0SFmW1HehCUMDfDxPPF1kUuA9qWMRgNi28lIsiXLMPZZcTMJdrmyjo335zNimxUcokvCK-KCKaas3H1WasbB4OVMJidW2cC2pVrAp_-pQmAA)

2.[Arc-Dark](https://color.firefox.com/?theme=XQAAAALsAAAAAAAAAABBqYhm849SCiazH1KEGccwS-xNVAVYwOBtiY0uPWyYE7WQD-5SgdZ71r2F-lXEQxrGAEzv_buK8bCyok70SsUy0GeciWa6veHgAFpeOvR5esr0TgHrmzAVtbaluSV2pYGKFkF03u_F69WpX-5y0OWddI2Y12nn6XZrfhTCe6wjAGRgrpfgKzbG8oTgp9v362NBpHcLnPzzzzC_3PGq4PfhQJimy-2PSgzHFoG6322X_-hAUAA)

3.[Arc-Darker](https://color.firefox.com/?theme=XQAAAALsAAAAAAAAAABBqYhm849SCiazH1KEGccwS-xNVAWBveAusLC2VAlvlSjJ6UJSeqAgCYbdusEoPO6gs3O7v6uHbeft01vfMkT1y4Tf1nzX1xYaRp0u6XBPage606lAwQt0F0O7Q6pf8R-lAjw8ljDMgG2fgvNk2K-ZUhapxWWNnKLb0LTrm1yLUWJYMgTx2cr9o4MWazvWLg9DPQcdumiH0qiUFROpAtIMassKweMS9iAEenpp0qT_Et_AAA)

### Arc-Dark for Ubuntu Software Center
The Arc Dark theme for the Ubuntu Software Center by [mervick](https://github.com/mervick) can be installed from [here](https://github.com/mervick/arc-dark-software-center). It solves readability issues with Arc Dark and the Ubuntu Software Center.

## Troubleshooting

If you get artifacts like black or invisible backgrounds under Unity, disable overlay scrollbars with

    gsettings set com.canonical.desktop.interface scrollbar-mode normal


## Bugs
If you find a bug, please report it at https://github.com/NicoHood/arc-theme/issues

## License
Arc is available under the terms of the GPL-3.0. See `COPYING` for details.

## Full Preview
![A full screenshot of the Arc theme](http://i.imgur.com/tD1OBQ3.png)
<sub>Screenshot Details: Icons: [Arc](https://github.com/NicoHood/arc-icon-theme) | Launcher Icons based on [White Pixel Icons](http://darkdawg.deviantart.com/art/White-Pixel-Icons-252310560) | [Wallpaper](https://pixabay.com/photo-869593/) | Font: Futura Bk bt</sub>

[sk-overlay]: https://github.com/fkmclane/overlay/tree/master/x11-themes/arc-theme
[NicoHood-fossfreedom]: https://launchpad.net/~fossfreedom/+archive/ubuntu/arc-gtk-theme-daily
