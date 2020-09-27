#! /usr/bin/env bash
# internet
ssid=tkiatd-True80GB
echo -n "Enter WIFI Password: "
read -s ssid_pwd

wpa_passphrase $ssid $ssid_pwd >> /etc/wpa_supplicant/wpa_supplicant.conf # WPA-PSK
sudo ln -s /etc/sv/wpa_supplicant /var/service/wpa_supplicant

sudo ln -s /etc/sv/dhcpcd /var/service/dhcpcd
sleep 5 # wait for dhcpd to generate /etc/resolv.conf then append nameserver to it
echo "nameserver 192.168.43.1" >> /etc/resolv.conf

# localtime
sudo ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime

# add user
echo -n "Enter username: "
read username
echo -n "Enter password: "
read -s password

useradd -m -U -G wheel,users,audio,video,cdrom,input $username
echo -e "$password\n$password" | passwd $username
