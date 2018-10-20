ithemedir       = $(DESTDIR)$(themedir)
ithemedarkerdir = $(DESTDIR)$(themedarkerdir)
ithemedarkdir   = $(DESTDIR)$(themedarkdir)


install-exec-hook:

install-data-local:

if ENABLE_PLANK

if ENABLE_LIGHT
	$(MKDIR_P) $(ithemedir)
	cp -R $(srcdir)/Arc-Plank/. $(ithemedir)/plank
endif # ENABLE_LIGHT

if ENABLE_DARKER
	$(MKDIR_P) $(ithemedarkerdir)
	cp -R $(srcdir)/Arc-Plank/. $(ithemedarkerdir)/plank
endif # ENABLE_DARKER

if ENABLE_DARK
	$(MKDIR_P) $(ithemedarkdir)
	cp -R $(srcdir)/Arc-Plank/. $(ithemedarkdir)/plank
endif # ENABLE_DARK
endif # ENABLE_PLANK


uninstall-local:


EXTRA_DIST = \
	Arc-Plank
