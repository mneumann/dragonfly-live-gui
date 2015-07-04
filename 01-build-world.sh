. ./config.sh

cd ${SRCDIR} && make -j ${NCPUS} -DWANT_INSTALLER buildworld MAKEOBJDIRPREFIX=${OBJDIR}
