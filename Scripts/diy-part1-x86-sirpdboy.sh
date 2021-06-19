#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#


# Uncomment a feed source
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default


git clone https://github.com/xiaorouji/openwrt-passwall.git package/lienol
git clone https://github.com/tty228/luci-app-serverchan.git package/custom/serverchan
git clone https://github.com/jiawm/luci-app-poweroff.git package/poweroff
git clone https://github.com/linkease/nas-packages.git package/nas #添加ddnsto和linkease
git clone https://github.com/sirpdboy/sirpdboy-package.git package/sirpdboy



