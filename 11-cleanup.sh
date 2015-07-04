# run as root!
. ./config.sh

mount_null /dev ${DESTDIR}/dev
cp /etc/resolv.conf ${DESTDIR}/etc/

du -ch ${DESTDIR} | tail -n1
$CHROOT_CMD "pkg clean -ay"
du -ch ${DESTDIR} | tail -n1

umount ${DESTDIR}/dev
rm ${DESTDIR}/etc/resolv.conf
rm -rf ${DESTDIR}/usr/obj/dports
rm -rf ${DESTDIR}/usr/distfiles
