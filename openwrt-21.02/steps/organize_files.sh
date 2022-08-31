#!/bin/bash
ROOTDIR=$(pwd)
echo $ROOTDIR
if [ ! -e "$ROOTDIR/build" ]; then
    echo "Please run from root / no build dir"
    exit 1
fi


NANOPI_MODEL=$1
NANOPI_MODEL_LOW=$(echo ${NANOPI_MODEL} | tr '[:upper:]' '[:lower:]')
VARIANT=$2
OPENWRT_BRANCH=$3
RELTAG=$4

mkdir -p ./artifact/
#mv build/openwrt/bin/targets/rockchip/armv8/* ./artifact/
mv build/openwrt/bin/targets/rockchip/armv8/*.buildinfo ./artifact/
mv build/openwrt/bin/targets/rockchip/armv8/*sysupgrade.img* ./artifact/

cd ./artifact/
ls -Ahl
mv openwrt-rockchip-armv8-friendlyarm_nanopi-$NANOPI_MODEL_LOW-ext4-sysupgrade.img.gz OpenWrt-AO-NanoPi$NANOPI_MODEL-$VARIANT-$OPENWRT_BRANCH-$RELTAG-ext4.img.gz
mv openwrt-rockchip-armv8-friendlyarm_nanopi-$NANOPI_MODEL_LOW-squashfs-sysupgrade.img.gz OpenWrt-AO-NanoPi$NANOPI_MODEL-$VARIANT-$OPENWRT_BRANCH-$RELTAG-squashfs.img.gz
gzip -d *.gz && exit 0
gzip --best *.img
ls -Ahl
#zip -r OpenWrt-AO-NanoPi$NANOPI_MODEL-$VARIANT-$OPENWRT_BRANCH-$RELTAG.zip ./
zip OpenWrt-AO-NanoPi$NANOPI_MODEL-$VARIANT-$OPENWRT_BRANCH-$RELTAG-buildinfo.zip *.buildinfo
zip OpenWrt-AO-NanoPi$NANOPI_MODEL-$VARIANT-$OPENWRT_BRANCH-$RELTAG-ext4.zip *$VARIANT*ext4*
zip OpenWrt-AO-NanoPi$NANOPI_MODEL-$VARIANT-$OPENWRT_BRANCH-$RELTAG-squashfs.zip *$VARIANT*squashfs*
#cp ../build/openwrt/*.config ./
ls -Ahl

