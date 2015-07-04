# run as root!
. ./config.sh

# Save the /etc for the installer
cpdup ${DESTDIR}/etc ${DESTDIR}/etc.hdd

mtree -deU -f ${SRCDIR}/etc/mtree/BSD.local.dist -p ${DESTDIR}/usr/local/
mtree -deU -f ${SRCDIR}/etc/mtree/BSD.var.dist -p ${DESTDIR}/var
dev_mkdb -f ${DESTDIR}/var/run/dev.db ${DESTDIR}/dev

# Install root skeletons
cpdup -X cpignore -o ${ROOTSKEL} ${DESTDIR}
((cd ${ROOTSKEL} && find .) | fgrep -v cpignore | (cd ${DESTDIR} && xargs chown root:wheel))

# Setup password
pwd_mkdb -p -d ${DESTDIR}/etc ${DESTDIR}/etc/master.passwd

# Copy some files
FILES=" Makefile \
        etc.${MACHINE_ARCH} \
        rc.d/Makefile \
        periodic/Makefile      \
        periodic/daily/Makefile    \
        periodic/security/Makefile \
        periodic/weekly/Makefile   \
        periodic/monthly/Makefile"

for UPGRADE_ITEM in ${FILES}; do
    cp -R ${SRCDIR}/etc/${UPGRADE_ITEM} ${DESTDIR}/etc/${UPGRADE_ITEM}
done
