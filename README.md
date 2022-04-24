
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
apt install git make gcc vim -y
```

##### 拉取sds代码

```
git clone https://github.com/stratosnet/sds.git
cd sds
git checkout v0.7.0
```

##### 编译

```
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
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
sed -i "s/http\:\/\/127\.0\.0\.1\:1317/https\:\/\/rest\-tropos\.thestratos\.org/g" configs/config.yaml
```

```
vim configs/config.conf
```

```
SPList:
- P2PAddress: stsds1mr668mxu0lyfysypq88sffurm5skwjvjgxu2xt
  P2PPublicKey: stsdspub1zcjduepq4v8yu6nzem787nfnwvzrfvpc5f7thktsqjts6xp4cy4a2j4rgm7sgdy4zy
  NetworkAddress: 35.73.160.68:8888
- P2PAddress: stsds1ftcvm2h9rjtzlwauxmr67hd5r4hpxqucjawpz6
  P2PPublicKey: stsdspub1zcjduepqq9rk5zwkzfnnszt5tqg524meeqd9zts0jrjtqk2ly2swm5phlc2qtrcgys
  NetworkAddress: 46.51.251.196:8888
- P2PAddress: stsds12uufhp4wunhy2n8y5p07xsvy9htnp6zjr40tuw
  P2PPublicKey: stsdspub1zcjduepqkst98p2642fv8eh8297ppx7xuzu7qjz67s9hjjhxjxs834md7e0s5rm3lf
  NetworkAddress: 18.130.202.53:8888
- P2PAddress: stsds1wy6xupax33qksaguga60wcmxpk6uetxt3h5e3e
  P2PPublicKey: stsdspub1zcjduepqyyfl7ljwc68jh2kuaqmy84hawfkak4fl2sjlpf8t3dd00ed2eqeqlm65ar
  NetworkAddress: 35.74.33.155:8888
- P2PAddress: stsds1nds6cwl67pp7w4sa5ng5c4a5af9hsjknpcymxn
  P2PPublicKey: stsdspub1zcjduepq6mz8w7dygzrsarhh76tnpz0hkqdq44u7usvtnt2qd9qgp8hs8wssl6ye0g
  NetworkAddress: 52.13.28.64:8888
- P2PAddress: stsds1403qtm2t7xscav9vd3vhu0anfh9cg2dl6zx2wg
  P2PPublicKey: stsdspub1zcjduepqzarvtl2ulqzw3t42dcxeryvlj6yf80jjchvsr3s8ljsn7c25y3hq2fv5qv
  NetworkAddress: 3.9.152.251:8888
- P2PAddress: stsds1hv3qmnujlrug00frk86zxr0q23rnqcaquh62j2
  P2PPublicKey: stsdspub1zcjduepqj69eeq07yfdgu4cdlupvga897zjqjakuru0qar5na7as4kjr7jgs0k7aln
  NetworkAddress: 18.223.175.117:8888
```

```
 ChainId: tropos-3
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
stchaincli tx send 发送钱包地址 接收钱包地址 金额ustos --chain-id=tropos-3 --keyring-backend=test --gas=auto --node 节点地址
```

##### 开启节点

```
cd /home/rsnode
ppd start
```

##### 后台运行
screen运行
```
screen -S rsnode
cd /home/rsnode
ppd start
然后Ctrl + A + D切换到前台
screen -ls 查看后台
screen -r rsnode 恢复前台
```
重定向运行
```
ppd start 2>&1 >> sds.log & 
```
service运行
```
wget https://raw.githubusercontent.com/espoir1989/stratos-install/main/sds.service
mv sds.service /lib/systemd/system/
systemctl daemon-reload
systemctl enable sds.service
systemctl start sds.service
```

检查运行状况
```
systemctl status sds.service
```
查看日志
```
journalctl -u sds.service -f 
```
停止服务
```
systemctl stop sds.service
```

修改配置
```
[Unit]
Description=Stratos SDS node
After=network-online.target

[Service]
User=root
ExecStart=/usr/bin/ppd start -r /home/rsnode #根据实际需求修改
Restart=on-failure
RestartSec=3
LimitNOFILE=8192

[Install]
WantedBy=multi-user.target
```

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


#### 查看质押情况
```
https://rest-tropos.thestratos.org/register/staking/owner/钱包地址
```

#### 查看收益

```
https://rest-tropos.thestratos.org/pot/rewards/wallet/钱包地址
```
