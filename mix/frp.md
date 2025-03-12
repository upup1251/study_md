frp
- 内网穿透
- 端口转发

# 下载

1. 可使用`brew`下载

```sh 
brew install frpc
brew info frpc  # 查看frpc配置文件地址
```

2. 手动下载

- [github release](https://github.com/fatedier/frp/releases) 
- 注意选择合适的版本下载

```sh 
uname -m # 查看本机架构
file frpc/frps # 查看当前frpc/frps适用的架构
# for mac m1: darwin_arm64  可能不对，有点急
# for ubuntu: linux_amd64
```


# 客户端client
- frpc
- frpc.toml

```toml
# 服务器ip和其监听的端口
serverAddr = "47.76.198.142"
serverPort = 7000

[[proxies]]
name = "test-tcp"
type = "tcp"
localIP = "127.0.0.1"
localPort = 8080    # 本地被映射的端口
remotePort = 80     # 服务器暴露的端口
```

## 启动frp服务

1. 手动启动

```sh 
/path/to/frpc -c frpc.toml
```

2. brew自启动

```sh 
brew service start frpc
```


#  服务端serve
- frps 
- frps.toml

```toml
# 服务器监听端口
bindPort = 7000
```

## 启动frp服务

1. 手动启动

```sh 
/path/to/frps -c frps.toml
```

2. 服务器frps服务自启动

使用systemctl启动

```sh 
# 服务器使用systemed自启动
# 将该文件放在/etc/systemed/system/目录下
# 使用systemctl start/enable frps.services启动
[Unit]
# 服务名称，可自定义
Description = frp server
After = network.target syslog.target
Wants = network.target

[Service]
Type = simple
# 启动frps的命令，需修改为您的frps的安装路径，需要从/开始
ExecStart = /path/to/frps -c /path/to/frps.toml

[Install]
WantedBy = multi-user.target
```
