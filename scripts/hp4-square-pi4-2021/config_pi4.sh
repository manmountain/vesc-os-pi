#!/bin/bash

set -e
# write config.txt
if ! grep -qE '^enable_dpi_lcd' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

enable_dpi_lcd=1
dtparam=i2c_arm=off
dtparam=spi=off
dtoverlay=hyperpixel4
dpi_group=2
dpi_mode=87
dpi_output_format=0x5f026
dpi_timings=720 0 20 20 40 720 0 15 15 15 0 0 0 60 0 36720000 4

__EOF__
fi

# copy overlays to boot partition
cp -R ${BR2_EXTERNAL_VESC_OS_PATH}/scripts/hp4-square-pi4-2021/dtbo_pi4/* ${BINARIES_DIR}/rpi-firmware/overlays
# copy rotate tool to /usr/bin
#echo ${BR2_EXTERNAL_VESC_OS_PATH}/
cp -R ${BR2_EXTERNAL_VESC_OS_PATH}/scripts/hp4-square-pi4-2021/dist_pi4/hyperpixel4-rotate ${BR2_EXTERNAL_VESC_OS_PATH}/buildroot/output/target/usr/bin
# copy udev rule to /etc/udev/rules.d
cp -R ${BR2_EXTERNAL_VESC_OS_PATH}/scripts/hp4-square-pi4-2021/dist_pi4/98-hyperpixel4-square-calibration.rules ${BR2_EXTERNAL_VESC_OS_PATH}/buildroot/output/target/etc/udev/rules.d


exit $?
