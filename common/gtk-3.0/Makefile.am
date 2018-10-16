if ENABLE_LIGHT
gtk3theme_DATA = light/thumbnail.png
endif

if ENABLE_DARKER
gtk3themedarker_DATA = light/thumbnail.png
endif

if ENABLE_DARK
gtk3themedark_DATA = dark/thumbnail.png
endif

EXTRA_DIST = \
	light \
	dark \
	_colors.scss.thpl

SUBDIRS = $(GTK3_VERSION)
DIST_SUBDIRS = 3.18 3.20
