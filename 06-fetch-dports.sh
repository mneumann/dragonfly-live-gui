# run as root!
. ./config.sh

cd ${DESTDIR}/usr && \
    make dports-create GITHOST_DPORTS=${GITHOST_DPORTS}

cd ${DESTDIR}/usr/dports && \
    git gc --aggressive
