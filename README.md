
#### 本教程非官方教程

系统：ubuntu 18+

#### 区块浏览器
https://explorer-tropos.thestratos.org/

#### 官方教程
https://github.com/stratosnet/sds/wiki/Tropos-Incentive-Testnet

####  全节点部署

#### SDS节点

##### 一键安装脚本

```
wget https://raw.githubusercontent.com/espoir1989/stratos-install/main/init.sh
sh init.sh
```

##### 基础环境安装

```
wget https://go.dev/dl/go1.17.7.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.7.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
apt install git make gcc -y
```

##### 拉取sds代码

```
git clone https://github.com/stratosnet/sds.git
cd sds
git checkout v0.5.0
```

##### 编译

```
make build
make install
```

##### 转移

```
cp /root/go/bin/ppd /usr/bin/
```

##### 配置生成

```
cd /home
mkdir rsnode
cd rsnode
ppd config
```

##### 生成节点p2p key与钱包

```
ppd config -w -p
根据提示输入密码，钱包名称，钱包密码，助记词等等，如果没助记词，直接回车，会生成新的地址
记得记录下助记词
```

#####  修改配置文件

```
vim config/config.conf
```

```
SPList:
- P2PAddress: ""
  P2PPublicKey: ""
  NetworkAddress: 13.58.35.167:8888
```

```
 ChainId: tropos-1
```

``` 根据实际情况修改
Port: 18081 #节点运行端口
NetworkAddress: 你的公网ip
```

##### 领水或者转账

```领水
curl -s -X POST https://faucet-tropos.thestratos.org/faucet/钱包地址
```

```转账
stchaincli tx send 发送钱包地址 接收钱包地址 金额ustos --chain-id=tropos-1 --keyring-backend=test --gas=auto --node 节点地址
```

##### 开启节点

```
cd /home/rsnode
ppd start
```

##### 后台运行
```
screen -S rsnode
cd /home/rsnode
ppd start
然后Ctrl + A + D切换到前台
screen -ls 查看后台
screen -r rsnode 恢复前台
```
后台运行也可以使用nohup，service，docker等方式

##### 开始挖矿

```
cd /home/rsnode
ppd terminal
```

###### 注册节点
```
rp 
```

###### 质押激活，质押10个代币
```
activate 10000000000 10000 1000000
```

###### 开启挖矿
```
startmining
```
###### 日志输出端口后，运行成功

##### 查看收益

```
https://rest-tropos.thestratos.org/pot/rewards/钱包地址
```
