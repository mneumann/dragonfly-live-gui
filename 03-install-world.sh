# run as root!
. ./config.sh

mkdir -p ${DESTDIR}

cd ${SRCDIR} && \
make -j ${NCPUS} -DWANT_INSTALLER installworld \
    DESTDIR=${DESTDIR} MAKEOBJDIRPREFIX=${OBJDIR}
