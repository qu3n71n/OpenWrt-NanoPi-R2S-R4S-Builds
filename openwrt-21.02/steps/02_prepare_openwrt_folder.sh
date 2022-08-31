#!/bin/bash
USERDIR=$(pwd)
echo $USERDIR
if [ ! -e "$USERDIR/build" ]; then
    echo "Please run from root / no build dir"
    exit 1
fi

cd "$USERDIR/build"

cp -R openwrt-fresh-2102 openwrt

# install feeds
cd openwrt

# modify default ip
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# modify default feeds

# add custom feeds
sed -i 's,https://git.openwrt.org/feed/packages.git;openwrt-21.02,https://github.com/immortalwrt/luci.git;openwrt-21.02,g' feeds.conf.default
sed -i 's,https://git.openwrt.org/project/luci.git;openwrt-21.02,https://github.com/immortalwrt/packages.git;openwrt-21.02,g' feeds.conf.default
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
git pull

./scripts/feeds update -a && ./scripts/feeds install -a
