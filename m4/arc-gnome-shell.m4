# ARC_GNOME_SHELL()
# ---------------
AC_DEFUN([ARC_GNOME_SHELL], [
    GNOME_SHELL_DIR="$srcdir/common/gnome-shell"
    PKG_PROG_PKG_CONFIG()
    AC_ARG_WITH(
        [gnome-shell],
        [AS_HELP_STRING(
            [--with-gnome-shell],
            [gnome-shell minor version]
        )],
        [GNOME_SHELL_VERSION="$withval"],
        [PKG_CHECK_EXISTS(
             [libmutter-3],
             [GNOME_SHELL_VERSION=`$PKG_CONFIG --modversion libmutter-3`],
             [AC_MSG_ERROR([Could not determine gnome-shell version. Install mutter and its development files (libmutter-dev for Debian/Ubuntu based distros and mutter-devel for RPM based distros).])]
         )]
    )

    # Trim version extras
    GNOME_SHELL_VERSION=`echo $GNOME_SHELL_VERSION | cut -d. -f-2`

    # Extra major and minor version components
    GNOME_SHELL_VERSMJR=`echo $GNOME_SHELL_VERSION | cut -d. -f1`
    GNOME_SHELL_VERSMNR=`echo $GNOME_SHELL_VERSION | cut -d. -f2`

    # Evenize the minor version for stable versions
    AS_IF(
        [test `expr $GNOME_SHELL_VERSMNR % 2` != "0"],
        [GNOME_SHELL_VERSION="$GNOME_SHELL_VERSMJR.`expr $GNOME_SHELL_VERSMNR + 1`"]
    )
    AS_IF(
        [! test -e "$GNOME_SHELL_DIR/$GNOME_SHELL_VERSION"],
        [AC_MSG_ERROR([Invalid gnome-shell version: $GNOME_SHELL_VERSION])]
    )
    AC_SUBST([GNOME_SHELL_VERSION])
    AC_MSG_RESULT([Building for gnome-shell $GNOME_SHELL_VERSION])
])
