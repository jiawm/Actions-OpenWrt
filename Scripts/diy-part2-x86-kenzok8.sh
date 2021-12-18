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
sed -i 's/192.168.1.1/192.168.100.102/g' package/base-files/files/bin/config_generate

# 切换ramips内核为 5.10
sed -i 's/5.4/5.10/g' ./target/linux/ramips/Makefile

# 切换x86内核为 5.10
sed -i 's/5.4/5.10/g' ./target/linux/x86/Makefile
# 添加温度显示
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template

# Remove the default apps 移除默认编译app，不是删除app
sed -i 's/luci-app-ssr-plus //g' target/linux/x86/Makefile
sed -i 's/luci-app-zerotier //g' target/linux/x86/Makefile
sed -i 's/luci-app-unblockmusic //g' target/linux/x86/Makefile
sed -i 's/luci-app-xlnetacc //g' target/linux/x86/Makefile
sed -i 's/luci-app-jd-dailybonus //g' target/linux/x86/Makefile
sed -i 's/luci-app-ipsec-vpnd //g' target/linux/x86/Makefile
sed -i 's/luci-app-adbyby-plus //g' target/linux/x86/Makefile
sed -i 's/luci-app-sfe //g' target/linux/x86/Makefile
sed -i 's/luci-app-uugamebooster//g' target/linux/x86/Makefile
sed -i 's/-luci-app-flowoffload//g' target/linux/x86/Makefile
sed -i 's/kmod-drm-amdgpu \\/kmod-drm-amdgpu/g' target/linux/x86/Makefile


#更换默认主题为argon，并删除bootstrap主题
sed -i 's#luci-theme-bootstrap#luci-theme-argon#g' feeds/luci/collections/luci/Makefile
sed -i 's/bootstrap/argon/g' feeds/luci/modules/luci-base/root/etc/config/luci

#删除lean大集成的旧版argon主题，更换为新版argon主题
rm -rf ./package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon  

# Change default BackGround img
wget -O ./package/lean/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg https://github.com/jiawm/My-OpenWrt-by-Lean/raw/main/BackGround/2.jpg


# Add WOL Plus
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-wolplus ./package/luci-app-wolplus
chmod -R 755 ./package/luci-app-wolplus/*

# Add luci-app-socat
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat ./package/luci-app-socat
chmod -R 755 ./package/luci-app-socat/*
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/socat ./package/socat
chmod -R 755 ./package/socat/*

#替换为sirpdboy中文版netdata
#rm -rf ./package/lean/luci-app-netdata 
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ./package/luci-app-netdata
#chmod -R 755 ./package/luci-app-netdata/*
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata ./package/netdata
#chmod -R 755 ./package/netdata/*

# Add OpenClash
#git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClash

#以下添加sirpdboy管控内容
# Add luci-app-control-weburl
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-control-weburl ./package/luci-app-control-weburl
chmod -R 755 ./package/luci-app-control-weburl/*

# Add luci-app-wrtbwmon
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-wrtbwmon ./package/luci-app-wrtbwmon
chmod -R 755 ./package/luci-app-wrtbwmon/*
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/wrtbwmon ./package/wrtbwmon
chmod -R 755 ./package/wrtbwmon/*


# Add luci-app-cpulimit
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-cpulimit ./package/luci-app-cpulimit
#chmod -R 755 ./package/luci-app-cpulimit/*
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/cpulimit ./package/cpulimit
#chmod -R 755 ./package/cpulimit/*

# Add S大修改的网速控制（主要在管控菜单下）
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-eqos ./package/luci-app-eqos
chmod -R 755 ./package/luci-app-eqos/*

#Add luci-app-dockerman
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-dockerman ./package/luci-app-dockerman
#chmod -R 755 ./package/luci-app-dockerman/*
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/dockerman ./package/dockerman
#chmod -R 755 ./package/dockerman/*


#删除与K大重复app
rm -rf ./package/kenzo/luci-app-eqos #k大的在网络下







