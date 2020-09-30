#!/usr/bin/env bash
# create a new logical volume containing void linux
# root password: voidlinux
disk="/dev/sda"
disk_part="/dev/sda1"
filepath=~/Downloads/void-x86_64-ROOTFS-20191109.tar.xz
filesystem=xfs
hostname=vaio-linux-void
lv_name=void_glibc
lv_size=20G
vg_name=tkiatd

mnt_dir="/mnt/$vg_name-$lv_name-temp"

sudo lvcreate --name $lv_name -L $lv_size $vg_name

eval sudo "mkfs.$filesystem" -L $lv_name "/dev/$vg_name/$lv_name"
sudo mkdir -p $mnt_dir
sudo mount "/dev/$vg_name/$lv_name" $mnt_dir
# url="https://alpha.de.repo.voidlinux.org/live/current/$filepath"
# cd $mnt_dir && sudo curl -O $url
sudo tar xvf $filepath -C $mnt_dir
for dir in dev proc sys run; do sudo mkdir -p "$mnt_dir/$dir" ; sudo mount --rbind /$dir "$mnt_dir/$dir" ; sudo mount --make-rslave "$mnt_dir/$dir" ; done

sudo cp /etc/resolv.conf "$mnt_dir/etc"
sudo mv /boot/volume.key "$mnt_dir/boot"

sudo chroot "$mnt_dir" /bin/bash <<EOF
xbps-install -Suy xbps
xbps-install -uy
xbps-install -y base-system
xbps-install -y lvm2 cryptsetup grub
xbps-remove base-voidstrap

chown root:root /
chmod 755 /
echo -e "voidlinux\nvoidlinux" | passwd root
echo $hostname > /etc/hostname
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/default/libc-locales
xbps-reconfigure -f glibc-locales

echo "# <file system>             <dir> <type>      <options>             <dump>  <pass>" >  /etc/fstab
echo "tmpfs                       /tmp  tmpfs       defaults,nosuid,nodev 0       0"      >> /etc/fstab
echo "/dev/$vg_name/$lv_name      /     $filesystem defaults              0       0"      >> /etc/fstab

sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& rd.lvm.vg=$vg_name rd.luks.uuid=$(blkid $disk_part -o value -s UUID)/' /etc/default/grub
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub

echo "$hostname   $disk_part   /boot/volume.key   luks" >> /etc/crypttab
echo "install_items+=\" /boot/volume.key /etc/crypttab \"" > /etc/dracut.conf.d/10-crypt.conf
mkdir -p /boot/grub && update-grub
xbps-reconfigure -fa
EOF
# update main grub entry
sudo update-grub

# sudo umount $mnt_dir
# sudo rm -r $mnt_dir
