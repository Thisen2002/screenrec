#!/bin/bash
set -e
VERSION=${1:-1.0}
PKG=build/screenrec_$VERSION

rm -rf build && mkdir -p $PKG/DEBIAN $PKG/usr/bin \
  $PKG/usr/share/applications \
  $PKG/usr/share/icons/hicolor/scalable/apps

install -m755 src/screenrec $PKG/usr/bin/screenrec
install -m644 packaging/deb/screenrec.desktop $PKG/usr/share/applications/
install -m644 packaging/deb/screenrec.svg $PKG/usr/share/icons/hicolor/scalable/apps/
sed "s/^Version:.*/Version: $VERSION/" packaging/deb/control > $PKG/DEBIAN/control

dpkg-deb --build --root-owner-group $PKG
echo "Built build/screenrec_$VERSION.deb"