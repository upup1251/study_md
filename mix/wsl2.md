```text

                                                        lllllll 
                                                        l:::::l 
                                                        l:::::l 
                                                        l:::::l 
wwwwwww           wwwww           wwwwwww  ssssssssss    l::::l 
 w:::::w         w:::::w         w:::::w ss::::::::::s   l::::l 
  w:::::w       w:::::::w       w:::::wss:::::::::::::s  l::::l 
   w:::::w     w:::::::::w     w:::::w s::::::ssss:::::s l::::l 
    w:::::w   w:::::w:::::w   w:::::w   s:::::s  ssssss  l::::l 
     w:::::w w:::::w w:::::w w:::::w      s::::::s       l::::l 
      w:::::w:::::w   w:::::w:::::w          s::::::s    l::::l 
       w:::::::::w     w:::::::::w     ssssss   s:::::s  l::::l 
        w:::::::w       w:::::::w      s:::::ssss::::::sl::::::l
         w:::::w         w:::::w       s::::::::::::::s l::::::l
          w:::w           w:::w         s:::::::::::ss  l::::::l
           www             www           sssssssssss    llllllll
```

[toc]


# wsl的基本命令

- 安装
```bash
wsl --install  <Distribution Name>  
//--distribution：指定安装的linux发行版
//--no-launch：安装linux发行版，但不启动它
//--web--download：通过联机渠道安装，而不是使用Microsoft Store

wsl --list --online     //获取发行版名称的有效列表

wsl --list --verbose [--all|--running|--quiet]  //列出已安装的linux发行版

wsl --set-version <distribution name> <versionNumber>   //设置wsl版本
wsl --set-default-version <version> //设置默认wsl版本
wsl --set-default <Distribution Name>   //设置默认linux发行版
```

- 启动
```bash
wsl  --distribution <Distribution Name> --user <User Name>

//更改发行版的默认用户
<DistributionName> config --default-user <UserName>
```

- 更新
```bash
wsl --update

//检查wsl状态
wsl --status
//检查wsl版本
wsl --version
//help命令
wsl --help

```

- 关闭
```powershell
wsl --shutdown
```

- Terminate
```powershell
wsl --terminate <Distribution Name>
```

- 标识ip地址
```powershell
//查看wsl2安装的liunx发行版ip地址
wsl hostname -I 

//返回wsl2看到的windows的ip地址
ip route shwo | grep -i default | awk '{print $3}'
```

- 导出和导入
```powershell
//导出
wsl --expoer <Distribution Name> <FileName>

//导入
wsl --import <Distribution Name> <InstallLocation> FileName>
```

- 卸载
```powershell
wsl --unregister <Distribution>
```

- 磁盘
```powershell
wsl --mount <DiskPath>

wsl --unmount <DiskPath>
```



# 跨windows和linux文件系统工作

- 跨操作系统io的文件读取速度差，各自的文件保存在各自的系统目录下

- 使用windows文件资源管理器打开wsl项目，`explorer.exe .`

- window和linux命令之间的互操作性
    1. windows命令行运行linux工具：`wsl <command>`
    2. 从linux运行windows工具：`[tool-name].exe`
    3. 混合命令
> echo 0|1 > /proc/sys/fs/binfmt_misc/WSLInterop-late
> 可用于控制单个wsl会话运行windows工具的功能

- 通过WSLNEV在windows和wsl中共享环境变量


# 高级设置配置

- wsl.conf和.wslconfig
    - .wslconfig用于在wsl2上的全局配置
    > 默认情况下，.wslconfig 文件不存在。 它必须创建并存储在%UserProfile%目录中才能应用这些配置设置。
    > 要访问 %UserProfile% 目录，请在 PowerShell 中使用 cd ~ 访问主目录（通常是用户配置文件 C:\Users\<UserName>），或者可以打开 Windows 文件资源管理器并在地址栏中输入 %UserProfile%。
    - wsl.conf用于在wsl1或wsl2上各个发行版的本地设置
    > 作为unix文件存储在发行版的/etc目录中

- wsl.conf的配置设置
    - 自动装载设置：`automount`
    - 网络设置：`network`
    - 互操作设置：`interop`
    - 用户设置：`user`
    - 启动设置：`boot`
```bash
# 示例
# 当启动发行版时自动挂载Windows驱动器
[automount]

# 设置为true将会自动挂载固定驱动器（如C:/或D:/）到上面设置的根目录下。设置为false则不会自动挂载，需要手动或通过fstab挂载。
enabled = true

# 设置固定驱动器自动挂载的目录位置。此示例更改了挂载位置，因此你的C盘将挂载为/c，而不是默认的/mnt/c。
root = /

# 可以指定DrvFs的特定选项。
options = "metadata,uid=1003,gid=1003,umask=077,fmask=11,case=off"

# 设置在WSL发行版启动时处理`/etc/fstab`文件。
mountFsTab = true

# 启用WSL 2的DNS服务器网络主机设置。此示例更改了主机名，设置generateHosts为false，以阻止WSL默认自动生成/etc/hosts；并设置generateResolvConf为false，阻止WSL自动生成/etc/resolv.conf，这样可以自行创建（如nameserver 1.1.1.1）。
[network]
hostname = DemoHost
generateHosts = false
generateResolvConf = false

# 设置WSL是否支持启动Windows应用和添加路径变量的互操作进程。将这些设置为false会阻止启动Windows进程并阻止添加$PATH环境变量。
[interop]
enabled = false
appendWindowsPath = false

# 设置启动WSL发行版时的默认用户。
[user]
default = DemoUser

# 设置新WSL实例启动时要运行的命令。此示例启动Docker容器服务。
[boot]
command = service docker start
```

- .wslconfig的配置设置
    - 主要wsl设置：`[wsl2]`
    - 实验性设置：`[experimental]`
```bash
#示例
# 设置适用于所有在WSL 2上运行的Linux发行版
[wsl2]

# 限制虚拟机内存使用不超过4GB，可以使用GB或MB的整数值进行设置
memory=4GB 

# 设置虚拟机使用两个虚拟处理器
processors=2

# 指定使用自定义Linux内核，默认内核可在https://github.com/microsoft/WSL2-Linux-Kernel找到
kernel=C:\\temp\\myCustomKernel

# 设置额外的内核参数，此处启用旧的Linux基础镜像（如Centos 6）
kernelCommandLine = vsyscall=emulate

# 设置交换存储空间为8GB，默认是可用RAM的25%
swap=8GB

# 设置交换文件路径位置，默认为%USERPROFILE%\AppData\Local\Temp\swap.vhdx
swapfile=C:\\temp\\wsl-swap.vhdx

# 禁用页面报告，因此WSL保留从Windows中分配的所有内存，即使空闲也不会释放
pageReporting=false

# 启用默认连接，将WSL 2的localhost绑定到Windows的localhost。若networkingMode=mirrored，此设置将被忽略
localhostforwarding=true

# 禁用嵌套虚拟化
nestedVirtualization=false

# 启用调试控制台，在打开WSL 2发行版时显示dmesg内容
debugConsole=true

# 启用实验性功能
[experimental]
sparseVhd=true
```


# wsl磁盘管理

wsl创建虚拟硬盘(VHD)来存储安装的每个linux发行版的文件，这些VHD使用ext4文件系统类型，表示为ext4.vhdx文件。wsl2会自动调整这些VHD文件的大小，最初为1TB的最大磁盘容量，可进行扩展。
