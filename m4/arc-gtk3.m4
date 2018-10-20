# ARC_GTK3()
# ---------------
AC_DEFUN([ARC_GTK3], [
    GTK3DIR="$srcdir/common/gtk-3.0"
    PKG_PROG_PKG_CONFIG()
    AC_ARG_WITH(
        [gtk3],
        [AS_HELP_STRING(
            [--with-gtk3],
            [GTK3 minor version]
        )],
        [GTK3_VERSION="$withval"],
        [PKG_CHECK_EXISTS(
            [gtk+-3.0],
            [GTK3_VERSION=`$PKG_CONFIG --modversion gtk+-3.0`],
            [AC_MSG_ERROR([Could not determine GTK3 version. Install GTK3 and its development files (libgtk-3-dev for Debian/Ubuntu based distros and gtk3-devel for RPM based distros), or specify the version using '--with-gtk3=<version>' option.])]
        )]
    )

    # Trim version extras
    GTK3_VERSION=`echo $GTK3_VERSION | cut -d. -f-2`

    # Extra major and minor version components
    GTK3_VERSMJR=`echo $GTK3_VERSION | cut -d. -f1`
    GTK3_VERSMNR=`echo $GTK3_VERSION | cut -d. -f2`

    AS_IF(
        [test "x$GTK3_VERSMJR" != x3], [AC_MSG_ERROR([Invalid GTK3 version: $GTK3_VERSION])],
        [test "0$GTK3_VERSMNR" -lt 17], [AC_MSG_ERROR([GTK3 version too old: $GTK3_VERSION])],
        [test "0$GTK3_VERSMNR" -lt 19], [GTK3_VERSION=3.18],
        [test "0$GTK3_VERSMNR" -lt 25], [GTK3_VERSION=3.20],
        [AC_MSG_ERROR([GTK3 version too new: $GTK3_VERSION])]
    )
    AC_SUBST([GTK3_VERSION])
    AC_SUBST([gtk3themedir], [${themedir}/gtk-3.0])
    AC_SUBST([gtk3themedarkerdir], [${themedarkerdir}/gtk-3.0])
    AC_SUBST([gtk3themedarkdir], [${themedarkdir}/gtk-3.0])
    AC_MSG_RESULT([Building for GTK3 $GTK3_VERSION])
])
