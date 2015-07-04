# run as root!
. ./config.sh

mount_null /dev ${DESTDIR}/dev
cp /etc/resolv.conf ${DESTDIR}/etc/
$CHROOT_CMD "ldconfig -elf /lib /usr/lib /usr/lib/gcc* /usr/lib/compat"

$CHROOT_CMD "pkg ins -y ${PACKAGES}"

umount ${DESTDIR}/dev
rm ${DESTDIR}/etc/resolv.conf
rm -rf ${DESTDIR}/usr/obj/dports
rm -rf ${DESTDIR}/usr/distfiles

#
# Finally, update the locate(8) database
#
#${CHROOT_CMD} /etc/periodic/weekly/310.locate
#umount ${ISOROOT}/dev
#
# Recopy files that dports may have updated in /etc into /etc.hdd
#
#cpdup ${ISOROOT}/etc/shells ${ISOROOT}/etc.hdd/shells
#cpdup ${ISOROOT}/etc/group ${ISOROOT}/etc.hdd/group
