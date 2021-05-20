#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# 修改openwrt登陆地址,把下面的192.168.2.1修改成你想要的就可以了，其他的不要动
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate


#更换默认主题为argon，并删除bootstrap主题
sed -i 's#luci-theme-bootstrap#luci-theme-argon#g' feeds/luci/collections/luci/Makefile
sed -i 's/bootstrap/argon/g' feeds/luci/modules/luci-base/root/etc/config/luci

#删除lean大集成的旧版argon主题，更换为新版argon主题
rm -rf ./package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon  


#git lua-maxminddb 依赖
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb

# Add WOL Plus
svn co https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-services-wolplus ./package/luci-app-wolplus
chmod -R 755 ./package/luci-app-wolplus/*

# Add luci-app-socat
# svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat ./package/luci-app-socat
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat ./package/luci-app-socat
chmod -R 755 ./package/luci-app-socat/*

#替换为sirpdboy中文版netdata
rm -rf ./package/lean/luci-app-netdata && git clone https://github.com/sirpdboy/luci-app-netdata.git package/lean/luci-app-netdata
