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

    # Evenize the minor version for stable versions
    AS_IF(
        [test `expr $GTK3_VERSMNR % 2` != "0"],
        [GTK3_VERSION="$GTK3_VERSMJR.`expr $GTK3_VERSMNR + 1`"]
    )
    AS_IF(
        [! test -e "$GTK3DIR/$GTK3_VERSION"],
        [AC_MSG_ERROR([Invalid GTK3 version: $GTK3_VERSION])]
    )
    AC_SUBST([GTK3_VERSION])
    AC_MSG_RESULT([Building for GTK3 $GTK3_VERSION])
])
