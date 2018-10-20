include ../common.am

light/gtk.css: gtk.css | light
	cp "$<" "$@"
light/gtk-dark.css: gtk-dark.css | light
	cp "$<" "$@"
darker/gtk.css: gtk-darker.css | darker
	cp "$<" "$@"
darker/gtk-dark.css: gtk-dark.css | darker
	cp "$<" "$@"
dark/gtk.css: gtk-dark.css | dark
	cp "$<" "$@"

gtk3themeassetsdir = $(gtk3themedir)/assets
gtk3themedarkerassetsdir = $(gtk3themedarkerdir)/assets
gtk3themedarkassetsdir = $(gtk3themedarkdir)/assets

if ENABLE_LIGHT
gtk3theme_DATA = light/gtk.css light/gtk-dark.css
gtk3themeassets_DATA = $(normal) $(hidpi)
endif

if ENABLE_DARKER
gtk3themedarker_DATA = darker/gtk.css darker/gtk-dark.css
gtk3themedarkerassets_DATA = $(normal) $(hidpi)
endif

if ENABLE_DARK
gtk3themedark_DATA = dark/gtk.css
gtk3themedarkassets_DATA = $(normal) $(hidpi)
endif
