#!/usr/bin/env bash
dest_dir=/usr/local/bin

app_dir=/mnt/shared/Apps-Linux
gui_dir=$app_dir/GUI
game_dir=$app_dir/Game
# ----------------------------------------
# GUI
sudo ln -sf $gui_dir/bitwarden/Bitwarden-1.22.2-x86_64.AppImage $dest_dir/bitwarden
sudo ln -sf $gui_dir/calibre/calibre $dest_dir/calibre
sudo ln -sf $gui_dir/chrome/chrome $dest_dir/chrome
sudo ln -sf $gui_dir/chromium/chrome $dest_dir/chromium
# sudo ln -sf $gui_dir/firefox-beta/firefox $dest_dir/firefox-beta
sudo ln -sf $gui_dir/firefox-dev/firefox $dest_dir/firefox-dev
# sudo ln -sf $gui_dir/firefox-nightly/firefox $dest_dir/firefox-nightly
sudo ln -sf $gui_dir/firefox-quantum/firefox $dest_dir/firefox-quantum
sudo ln -sf $gui_dir/freefilesync/FreeFileSync $dest_dir/freefilesync
# sudo ln -sf $gui_dir/icecat/icecat $dest_dir/icecat
sudo ln -sf $gui_dir/krita/krita-4.3.0-x86_64.appimage $dest_dir/krita
sudo ln -sf $gui_dir/libreoffice/x86_64-full-fresh.AppImage $dest_dir/libreoffice
sudo ln -sf $gui_dir/opera/opera $dest_dir/opera
sudo ln -sf $gui_dir/postman/Postman $dest_dir/postman
sudo ln -sf $gui_dir/standard-notes/standard-notes-3.4.6-linux-x86_64.AppImage $dest_dir/standard-notes
sudo ln -sf $gui_dir/thunderbird/thunderbird $dest_dir/thunderbird
sudo ln -sf $gui_dir/vivaldi/vivaldi $dest_dir/vivaldi

sudo ln -sf $app_dir/tor-browser $dest_dir/tor-browser

# Game
# sudo ln -sf $game_dir/Supertux/SuperTux_2-v0.6.2.glibc2.27-x86_64.AppImage $dest_dir/supertux
