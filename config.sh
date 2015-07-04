SRCDIR=/usr/src
OBJDIR=/home/mneumann/obj
DESTDIR=/home/mneumann/obj/img
IMGFILE=/home/mneumann/obj/live.img
IMGMNT=/home/mneumann/obj/mnt
IMGUSBDEV=da8

ROOTSKEL=`pwd`/skel
NCPUS=`sysctl -n hw.ncpu`
GITHOST_DPORTS=mirror-master.dragonflybsd.org
GITHOST=git.dragonflybsd.org
MACHINE_ARCH=x86_64
CHROOT_CMD="/usr/sbin/chroot ${DESTDIR} sh -c"

# required: install "pkg"
DPORTS_PACKAGES="ports-mgmt/pkg"

PACKAGES=""
PACKAGES="${PACKAGES} vim tmux sudo pwgen irssi"
PACKAGES="${PACKAGES} xorg"
PACKAGES="${PACKAGES} xfce xfce4-mixer"
PACKAGES="${PACKAGES} xfce4-battery-plugin xfce4-screenshooter-plugin xfce4-netload-plugin xfce4-xkb-plugin"
PACKAGES="${PACKAGES} firefox thunderbird epdfview eog GraphicsMagick wifimgr abiword"
