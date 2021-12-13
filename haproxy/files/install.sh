#!/bin/bash

rm -rf /etc/yum.repos.d/* 
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-$(awk -F '"' 'NR==5{print $2}' /etc/os-release).repo
sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
yum -y install make gcc pcre-devel bzip2-devel openssl-devel systemd-devel
useradd -r -M -s /sbin/nologin haproxy
cd /usr/src/
tar xf haproxy-${version}.tar.gz
cd haproxy-${version}
make clean && \
                 make TARGET=linux-glibc  \
                 USE_OPENSSL=1  \
                 USE_ZLIB=1  \
                 USE_PCRE=1  \
                 USE_SYSTEMD=1 && \
                 make install PREFIX=/usr/local/haproxy && \
cp haproxy /usr/sbin/
echo 'net.ipv4.ip_nonlocal_bind = 1' >>  /etc/sysctl.conf
echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf

mkdir /usr/local/haproxy/conf
yum remove -y gcc make
rm -rf /usr/src/* /var/cache/* 
