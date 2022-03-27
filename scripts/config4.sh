#!/bin/bash

set -e

if ! grep -qE '^dtoverlay=vc4-fkms-v3d' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Activate vc4 gpu driver
dtoverlay=vc4-fkms-v3d
__EOF__
fi

source ${BR2_EXTERNAL_VESC_OS_PATH}/scripts/hp4-square-pi4-2021/config_pi4.sh

exit $?
