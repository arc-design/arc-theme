if !ENABLE_TRANSPARENCY
plankthemedir   = $(datadir)/plank/themes/Arc-solid
else
plankthemedir   = $(datadir)/plank/themes/Arc
endif

iplankthemedir  = $(DESTDIR)$(plankthemedir)

install-exec-hook:

install-data-local:

if ENABLE_PLANK
	$(MKDIR_P) $(iplankthemedir)
	cp -R $(srcdir)/Arc-Plank/. $(iplankthemedir)
endif # ENABLE_PLANK


uninstall-local:

if ENABLE_PLANK
	rm -rf $(iplankthemedir)
endif # ENABLE_PLANK


EXTRA_DIST = $(srcdir)/Arc-Plank
