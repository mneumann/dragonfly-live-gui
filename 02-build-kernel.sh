. ./config.sh

cd ${SRCDIR} && \
make -j ${NCPUS} -DWANT_INSTALLER buildkernel \
    KERNCONF=X86_64_GENERIC MAKEOBJDIRPREFIX=${OBJDIR}
