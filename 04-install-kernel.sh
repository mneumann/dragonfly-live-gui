# run as root!
. ./config.sh

mkdir -p ${DESTDIR}

cd ${SRCDIR} && \
make -j ${NCPUS} -DWANT_INSTALLER installkernel \
    KERNCONF=X86_64_GENERIC DESTDIR=${DESTDIR} MAKEOBJDIRPREFIX=${OBJDIR}
