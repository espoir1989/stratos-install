#!/bin/bash
cd /root/
wget https://go.dev/dl/go1.17.7.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.7.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
apt install git make gcc -y

git clone https://github.com/stratosnet/sds.git
cd sds
git checkout v0.5.0

make build
make install

cp /root/go/bin/ppd /usr/bin/

cd /home
mkdir rsnode
cd rsnode
ppd config

echo '基础安装完成，请根据教程修改配置文件等操作'