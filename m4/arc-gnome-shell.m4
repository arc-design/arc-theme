# ARC_GNOME_SHELL()
# ---------------
AC_DEFUN([ARC_GNOME_SHELL], [
    GNOME_SHELL_DIR="$srcdir/common/gnome-shell"
    AC_ARG_WITH(
        [gnome-shell],
        [AS_HELP_STRING(
            [--with-gnome-shell],
            [gnome-shell minor version]
        )],
        [GNOME_SHELL_VERSION="$withval"],
        [AC_CHECK_PROG(
            [GNOME_SHELL_FOUND],
            [gnome-shell],
            [yes],
            [no]
        )
        AS_IF(
            [test "x$GNOME_SHELL_FOUND" = xyes],
            [GNOME_SHELL_VERSION=`gnome-shell --version | cut -d' ' -f3`],
            [AC_MSG_ERROR([Could not find gnome-shell from \$PATH.])]
        )
        AS_IF(
            [test -z "$GNOME_SHELL_VERSION"],
            [AC_MSG_ERROR([Could not determine gnome-shell version.])]
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
