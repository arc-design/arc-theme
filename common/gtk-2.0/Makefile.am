VPATH =

targets := $(shell cat $(srcdir)/assets.txt)
light := $(patsubst %,light/assets/%.png,$(targets))
dark := $(patsubst %,dark/assets/%.png,$(targets))

mbt_entry := $(filter entry-%toolbar,$(targets))
mbt_menubar := $(filter menubar%,$(targets))
mbt_button := $(filter button%,$(targets))

mbt_light := \
	$(srcdir)/menubar-toolbar/menubar-toolbar.rc \
	$(patsubst %,menubar-toolbar/%.png,$(mbt_entry) $(mbt_menubar))

mbt_dark := \
	$(srcdir)/menubar-toolbar/menubar-toolbar-dark.rc \
	$(patsubst %,menubar-toolbar/%-dark.png,$(mbt_entry) $(mbt_menubar)) \
	$(patsubst %,menubar-toolbar/%.png,$(mbt_button))

rc := apps main panel xfce-notify
srcrc := $(patsubst %,$(srcdir)/%.rc,$(rc))

light: $(light)
dark: $(dark)
mbt_light: $(mbt_light)
mbt_dark: $(mbt_dark)

light/assets dark/assets menubar-toolbar:
	$(MKDIR_P) "$@"/

clean:
	rm -rf light/assets/ dark/assets/ menubar-toolbar/*.png

$(light): $(srcdir)/light/assets.svg | light/assets
$(dark): $(srcdir)/dark/assets.svg | dark/assets

if RENDERSVG

$(light) $(dark):
	$(RENDERSVG) --export-id "$(basename $(notdir $@))" --dpi $(if $(filter $(OPTION_GTK2_HIDPI),true),192,96) --zoom $(if $(filter $(OPTION_GTK2_HIDPI),true),2,1) "$<" "$@"
if OPTIPNG
	$(OPTIPNG) -o7 --quiet "$@"
endif

else

$(light) $(dark):
	$(INKSCAPE) --export-id-only --export-png="$@" --export-id="$(basename $(notdir $@))" --export-dpi=$(if $(filter $(OPTION_GTK2_HIDPI),true),192,96) "$<" >/dev/null
if OPTIPNG
	$(OPTIPNG) -o7 --quiet "$@"
endif

endif


menubar-toolbar/%-dark.png: dark/assets/%.png | menubar-toolbar
	cp "$<" "$@"

menubar-toolbar/%.png: light/assets/%.png | menubar-toolbar
	cp "$<" "$@"

.PHONY: light dark mbt_light mbt_dark clean

if ENABLE_LIGHT
gtk2themedir = $(themedir)/gtk-2.0
gtk2themeassetsdir = $(gtk2themedir)/assets
gtk2theme_DATA = $(srcrc) $(srcdir)/light/gtkrc
gtk2themeassets_DATA = $(light)
nobase_gtk2theme_DATA = $(mbt_light)
endif

if ENABLE_DARKER
gtk2themedarkerdir = $(themedarkerdir)/gtk-2.0
gtk2themedarkerassetsdir = $(gtk2themedarkerdir)/assets
gtk2themedarker_DATA = $(srcrc) $(srcdir)/darker/gtkrc
gtk2themedarkerassets_DATA = $(light)
nobase_gtk2themedarker_DATA = $(mbt_dark)
endif

if ENABLE_DARK
gtk2themedarkdir = $(themedarkdir)/gtk-2.0
gtk2themedarkassetsdir = $(gtk2themedarkdir)/assets
gtk2themedark_DATA = $(srcrc) $(srcdir)/dark/gtkrc
gtk2themedarkassets_DATA = $(dark)
nobase_gtk2themedark_DATA = $(mbt_dark)
endif

EXTRA_DIST = \
	assets.txt \
	$(srcrc) \
	$(patsubst %,%/assets.svg,light dark) \
	$(patsubst %,%/gtkrc,light darker dark) \
	$(patsubst %,menubar-toolbar/menubar-toolbar%,.rc -dark.rc)
