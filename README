# 使用Docker构建LEDE固件

基础固件使用的 https://github.com/coolsnowwolf/lede

## 新增的插件

- OpenClash
- 广告过滤adguardhome
- argon主题

## 使用方式

1. 拉取镜像并进入镜像

~~~
docker pull registry.cn-hangzhou.aliyuncs.com/tianzeng/openwrt_build
docker run -it registry.cn-hangzhou.aliyuncs.com/tianzeng/openwrt_build bash
~~~

2. 自定义镜像内容生成.config 文件

~~~
cd /lede
make menuconfig
~~~

3. 编译

~~~
export FORCE_UNSAFE_CONFIGURE=1

make -j$(($(nproc) + 1)) V=s
~~~

大概1-2个小时编译完成

编译完成之后可以通过命令把固件拷贝到宿主机上面

~~~
docker cp ${CONTAINER ID}:/lede/bin/targets/x86/64/*.img .
~~~