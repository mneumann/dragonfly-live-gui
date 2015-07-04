# run as root!
. ./config.sh

mount_null /dev ${DESTDIR}/dev
cp /etc/resolv.conf ${DESTDIR}/etc/
$CHROOT_CMD "ldconfig -elf /lib /usr/lib /usr/lib/gcc* /usr/lib/compat"

for package in ${DPORTS_PACKAGES}; do
    $CHROOT_CMD "cd /usr/dports/${package} && make install clean"
done

umount ${DESTDIR}/dev
rm ${DESTDIR}/etc/resolv.conf
rm -rf ${DESTDIR}/usr/obj/dports
rm -rf ${DESTDIR}/usr/distfiles
