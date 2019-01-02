#!/bin/sh

test -z "$srcdir" && srcdir=$(dirname "$0")
test -z "$srcdir" && srcdir=.

set -ue

cwd=$(pwd)
cd "$srcdir"

mkdir -p m4
autoreconf --verbose --force --install

cd "$cwd"
# shellcheck disable=SC2068
"$srcdir/configure" $@
