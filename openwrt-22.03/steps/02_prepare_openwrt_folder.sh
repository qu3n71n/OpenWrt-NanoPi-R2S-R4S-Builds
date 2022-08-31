#!/bin/bash
ROOTDIR=$(pwd)
echo $ROOTDIR
if [ ! -e "$ROOTDIR/build" ]; then
    echo "Please run from root / no build dir"
    exit 1
fi

cd "$ROOTDIR/build"

cp -R openwrt-fresh-2203 openwrt

# install feeds
cd openwrt

# modify default ip
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# add custom feeds
#sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
#sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
sed -i '$a src-git luciImmortalWrt https://github.com/immortalwrt/luci.git;openwrt-21.02' feeds.conf.default
sed -i '$a src-git packagesImmortalWrt https://github.com/immortalwrt/packages.git;openwrt-21.02' feeds.conf.default
git pull

./scripts/feeds update -a && ./scripts/feeds install -a
