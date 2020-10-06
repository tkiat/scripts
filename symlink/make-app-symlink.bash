#!/usr/bin/env bash
dest_dir=/mnt/shared/Apps-Linux
src_dir=$dest_dir/GUI

# ----------------------------------------
# GUI
ln -sf $src_dir/bitwarden/Bitwarden-1.22.2-x86_64.AppImage $dest_dir/bitwarden
ln -sf $src_dir/calibre/calibre $dest_dir/calibre
ln -sf $src_dir/chromium/chrome $dest_dir/chromium
ln -sf $src_dir/firefox-dev/firefox $dest_dir/firefox-dev
ln -sf $src_dir/firefox-quantum/firefox $dest_dir/firefox-quantum
ln -sf $src_dir/freefilesync/FreeFileSync $dest_dir/freefilesync
ln -sf $src_dir/libreoffice/x86_64-full-fresh.AppImage $dest_dir/libreoffice
ln -sf $src_dir/postman/Postman $dest_dir/postman
# tor
echo "#!/bin/sh" > $dest_dir/tor-browser
echo "cd $src_dir/tor-browser/Browser && ./firefox" >> $dest_dir/tor-browser
