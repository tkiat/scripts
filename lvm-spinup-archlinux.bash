#!/usr/bin/env bash
# create a new logical volume containing void linux
# root password: archlinux

# config ----------------------------------------------
# lvm
disk="/dev/sda"
disk_part="/dev/sda1"
hostname=arch-linux
lv_name=arch_linux
lv_size=10G
vg_name=tkiatd
filesystem=ext4

mirror='https://mirror.kku.ac.th/archlinux/\$repo/os/\$arch'
# extract from file or download from url if not exist
filepath=~/Downloads/archlinux-bootstrap-2020.09.01-x86_64.tar.gz
url=https://mirror.kku.ac.th/archlinux/iso/2020.09.01/archlinux-bootstrap-2020.09.01-x86_64.tar.gz
# code ------------------------------------------------
# create and format new lvm logical volume
sudo lvcreate --name $lv_name -L $lv_size $vg_name
eval sudo "mkfs.$filesystem" -L $lv_name "/dev/$vg_name/$lv_name"
# extract starter file and mount it
mnt_dir="/mnt/$vg_name-$lv_name-temp"
sudo mkdir -p $mnt_dir
sudo mount "/dev/$vg_name/$lv_name" $mnt_dir
if [ -f "$filepath" ]; then
	sudo tar xvf $filepath -C $mnt_dir --strip-components=1
else
  cd $mnt_dir && sudo curl $url | tar -xz --strip-components=1
fi
for dir in dev proc run sys
do
	echo "$mnt_dir/$dir"
	sudo mkdir -p "$mnt_dir/$dir"
	sudo mount --rbind /$dir "$mnt_dir/$dir"
	sudo mount --make-rslave "$mnt_dir/$dir"
done

# chroot
sudo chroot "$mnt_dir" /bin/bash <<EOF
pacman-key --init
pacman-key --populate archlinux
echo -e "Server = $mirror""\n\$(cat /etc/pacman.d/mirrorlist)" > /etc/pacman.d/mirrorlist
pacman -Syyu
pacman -S --noconfirm base base-devel linux linux-firmware lvm2 grub
genfstab -U / >> /etc/fstab
ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
hwclock --systohc
echo -e 'en_US.UTF-8 UTF-8'"\n\$(cat /etc/locale.gen)" > /etc/locale.gen
locale-gen
echo -e "archlinux\narchlinux" | passwd root
echo $hostname > /etc/hostname
echo "LANG=en_US.UTF-8" > /etc/locale.conf

sed -i 's#GRUB_CMDLINE_LINUX_DEFAULT="[^"]*#& cryptdevice=UUID=$(blkid $disk_part -o value -s UUID):luks:allow-discards cryptkey=/:/boot/volume.key#' /etc/default/grub
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub

echo "$hostname $disk_part /boot/volume.key   luks" >> /etc/crypttab

sed -i 's/^HOOKS/#HOOKS/' /etc/mkinitcpio.conf
echo -e 'HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)'"\n\$(cat /etc/mkinitcpio.conf)" > /etc/mkinitcpio.conf

mkdir -p /boot/grub && grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P

pacman -S --noconfirm dhcp dhcpcd wpa_supplicant vim

systemctl enable dhcpcd
systemctl enable wpa_supplicant
echo 'nameserver 192.168.43.1' >> /etc/resolv.conf
EOF

sudo cp /boot/volume.key "$mnt_dir/boot"
# update main grub entry
sudo update-grub
