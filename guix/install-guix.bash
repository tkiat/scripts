#!/usr/bin/env bash
# Reference: https://guix.gnu.org/manual/en/html_node/Binary-Installation.html
url=https://ftp.gnu.org/gnu/guix/guix-binary-1.1.0.x86_64-linux.tar.xz
filename=$(echo $url | awk -F/ '{print $NF}')
if [ $(whoami) != "root" ]; then
	echo "Must be superuser!"
	echo "exit 1"
	exit 1
fi
echo "cd /tmp"
cd /tmp
if [ -f "$filename" ]; then
	echo "file found, extracting ..."
	tar --warning=no-timestamp -xf $filename
else
	echo "file not found, downloading from $url ..."
	http_code=$(curl -O -s -o /dev/null -w "%{http_code}" $url)
	if [ $http_code != "200" ]; then
		echo "download error, http status code: $http_code"
		exit 1
	fi
	echo "extracting ..."
	tar xf $filename
fi
echo "mv var/guix /var/ && mv gnu /"
mv var/guix /var/ && mv gnu /

echo "mkdir -p ~root/.config/guix"
mkdir -p ~root/.config/guix

echo "ln -sf /var/guix/profiles/per-user/root/current-guix ~root/.config/guix/current"
ln -sf /var/guix/profiles/per-user/root/current-guix ~root/.config/guix/current

GUIX_PROFILE="`echo ~root`/.config/guix/current" ; \
	  source $GUIX_PROFILE/etc/profile""

if ! cat /etc/group | grep -q guixbuild; then
	echo "add group guixbuild ..."
	groupadd --system guixbuild
fi

echo "add a build user pool ..."
for i in `seq -w 1 10`;
do
	useradd -g guixbuild -G guixbuild \
	-d /var/empty -s `which nologin`\
	-c "Guix build user $i" --system    \
	guixbuilder$i;
done

echo "make guix command available to all users ..."
mkdir -p /usr/local/bin
cd /usr/local/bin
ln -s /var/guix/profiles/per-user/root/current-guix/bin/guix

mkdir -p /usr/local/share/info
cd /usr/local/share/info
for i in /var/guix/profiles/per-user/root/current-guix/share/info/* ; do ln -s $i ; done

echo "using substitutes from ci.guix.gnu.org ..."
guix archive --authorize < ~root/.config/guix/current/share/guix/ci.guix.gnu.org.pub

echo "not finish yet, run command ~root/.config/guix/current/bin/guix-daemon --build-users-group=guixbuild as a service and then follow https://guix.gnu.org/manual/en/html_node/Application-Setup.html and then probably create /etc/netgroup for nscd"
