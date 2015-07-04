# run as root!
. ./config.sh

dd if=${IMGFILE} of=/dev/${IMGUSBDEV} bs=1m
