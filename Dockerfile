FROM ubuntu:18.04

# 切换源，安装apt更新，并且加上依赖
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/ShangHai
RUN apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync


# 基础镜像代码
RUN git clone https://github.com/coolsnowwolf/lede

WORKDIR /lede
# 安装插件
# OpenClash，这鬼玩意贼大，只能用fetch去安装
RUN mkdir package/luci-app-openclash && cd package/luci-app-openclash && git init && git remote add -f origin https://github.com/vernesong/OpenClash.git && git fetch
# 广告过滤
RUN  git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
# 主题 luci-theme-argon
RUN  rm -rf package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
# 剩余脚本
RUN  ./scripts/feeds update -a && ./scripts/feeds install -a

# 默认配置文件
COPY .config /lede/.config

RUN  make -j8 download V=s
