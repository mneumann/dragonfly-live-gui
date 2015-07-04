# run as root!
. ./config.sh

mkdir -p ${DESTDIR}

cd ${SRCDIR}/etc && \
make -m ${SRCDIR}/share/mk distribution \
    DESTDIR=${DESTDIR} MAKEOBJDIRPREFIX=${OBJDIR}
