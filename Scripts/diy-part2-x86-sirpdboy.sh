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


#更换默认主题为opentopd，并删除bootstrap主题
sed -i 's#luci-theme-bootstrap#luci-theme-opentopd#g' feeds/luci/collections/luci/Makefile
sed -i 's/bootstrap/opentopd/g' feeds/luci/modules/luci-base/root/etc/config/luci

#删除lean大集成的旧版argon主题，更换为新版argon主题，lean中新版主题为arton-new
rm -rf ./package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon  
#全新的[argon-主题]此主题玩法很多,这里看说明【https://github.com/jerrykuku/luci-theme-argon/blob/18.06/README_ZH.md】
#增加可自定义登录背景功能，请自行将文件上传到/www/luci-static/argon/background 目录下，支持jpg png gif格式图片，主题将会优先显示自定义背景，多个背景为随机显示，系统默认依然为从bing获取
#增加了可以强制锁定暗色模式的功能，如果需要，请登录ssh 输入：touch /etc/dark 即可开启，关闭请输入：rm -rf /etc/dark，关闭后颜色模式为跟随系统

# Change default BackGround img
wget -O ./package/lean/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg https://github.com/jiawm/My-OpenWrt-by-Lean/raw/main/BackGround/1.jpg

#git lua-maxminddb 依赖
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb

# Add WOL Plus s大包有该软件
#svn co https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-services-wolplus ./package/luci-app-wolplus
#chmod -R 755 ./package/luci-app-wolplus/*

# Add luci-app-socat
# svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat ./package/luci-app-socat
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat ./package/luci-app-socat
chmod -R 755 ./package/luci-app-socat/*


#替换为sirpdboy中文版netdata
rm -rf ./package/lean/luci-app-netdata 
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ./package/luci-app-netdata
chmod -R 755 ./package/luci-app-netdata/*
