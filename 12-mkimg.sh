# run as root!
. ./config.sh

rmdir -f ${IMGMNT}
mkdir -p ${IMGMNT}

echo "STEP: Determine required image size in 1GB steps"
echo "      Leave ~600MB of unused space"
sz=`du -ck ${DESTDIR} | tail -n 1 | cut -f 1`;			\
sz=`bc -e "((${sz}) * 1.15 + 999999 + 600000) / 1000000" -equit | \
	    cut -f1 -d.`
sz=`bc -e "((${sz}) * 953)" -equit | cut -f1 -d.`

echo $sz MB

rm -f ${IMGFILE}
truncate -s ${sz}M ${IMGFILE}
fdisk -IB -p ${IMGFILE}

echo "STEP: determine free vn device"
VNW=`vnconfig -l | grep "not in use" | head -n 1 | cut -f 1 -d:`

echo Using ${VNW}

vnconfig -e -s labels ${VNW} ${IMGFILE}

echo "STEP: write standard disklabel"
disklabel -w -r ${VNW}s1 auto

echo "STEP: read disklabel back"
disklabel -r ${VNW}s1 > ${IMGFILE}.label

echo "STEP: determine number of sectors of whole disk"
secs=`tail -n 1 ${IMGFILE}.label | cut -f 3 -w`
echo "  a:  ${secs} 0 4.2BSD" >> ${IMGFILE}.label

echo "STEP: write modified disklabel back"
disklabel -R -r ${VNW}s1 ${IMGFILE}.label
rm ${IMGFILE}.label

echo "STEP: write bootsector"
disklabel -B ${VNW}s1
boot0cfg -B -o noupdate ${VNW}
newfs /dev/${VNW}s1a
mount /dev/${VNW}s1a ${IMGMNT}

echo "STEP: Copy files... (this takes a while)"
cpdup ${DESTDIR} ${IMGMNT}

echo "STEP: fixup ${IMGMNT}/etc/fstab"
echo "/dev/${IMGUSBDEV}s1a / ufs rw,noatime 0 1" > ${IMGMNT}/etc/fstab
echo "dummy /tmp tmpfs rw 0 0" >> ${IMGMNT}/etc/fstab
echo "dummy /var/tmp tmpfs rw 0 0" >> ${IMGMNT}/etc/fstab
echo "dummy /var/run tmpfs rw 0 0" >> ${IMGMNT}/etc/fstab
echo "dummy /usr/obj tmpfs rw 0 0" >> ${IMGMNT}/etc/fstab
echo "proc /proc procfs rw 0 0" >> ${IMGMNT}/etc/fstab

echo "STEP: fixup ${IMGMNT}/boot/loader.conf"

fgrep -v kernel_options ${IMGMNT}/boot/loader.conf > ${IMGMNT}/boot/loader.conf.new
echo vfs.root.mountfrom="ufs:${IMGUSBDEV}s1a" >> ${IMGMNT}/boot/loader.conf.new
echo 'snd_hda_load="YES"' >> ${IMGMNT}/boot/loader.conf.new
echo 'kern.kms_console="1"' >> ${IMGMNT}/boot/loader.conf.new
mv ${IMGMNT}/boot/loader.conf.new ${IMGMNT}/boot/loader.conf

echo "STEP: cleanup"
df ${IMGMNT}
sync
sleep 1
umount ${IMGMNT}
vnconfig -u ${VNW}
rmdir ${IMGMNT}
echo "STEP: done"
