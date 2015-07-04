# run as root!
. ./config.sh

cd ${DESTDIR}/usr && \
    make src-create-repo GITHOST=${GITHOST}

cd ${DESTDIR}/usr/src && \
    git gc --aggressive
