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
# Automatically mount Windows drive when the distribution is launched
[automount]

# Set to true will automount fixed drives (C:/ or D:/) with DrvFs under the root directory set above. Set to false means drives won't be mounted automatically, but need to be mounted manually or with fstab.
enabled = true

# Sets the directory where fixed drives will be automatically mounted. This example changes the mount location, so your C-drive would be /c, rather than the default /mnt/c. 
root = /

# DrvFs-specific options can be specified.  
options = "metadata,uid=1003,gid=1003,umask=077,fmask=11,case=off"

# Sets the `/etc/fstab` file to be processed when a WSL distribution is launched.
mountFsTab = true

# Network host settings that enable the DNS server used by WSL 2. This example changes the hostname, sets generateHosts to false, preventing WSL from the default behavior of auto-generating /etc/hosts, and sets generateResolvConf to false, preventing WSL from auto-generating /etc/resolv.conf, so that you can create your own (ie. nameserver 1.1.1.1).
[network]
hostname = DemoHost
generateHosts = false
generateResolvConf = false

# Set whether WSL supports interop processes like launching Windows apps and adding path variables. Setting these to false will block the launch of Windows processes and block adding $PATH environment variables.
[interop]
enabled = false
appendWindowsPath = false

# Set the user when launching a distribution with WSL.
[user]
default = DemoUser

# Set a command to run when a new WSL instance launches. This example starts the Docker container service.
[boot]
command = service docker start
```

- .wslconfig的配置设置
    - 主要wsl设置：`[wsl2]`
    - 实验性设置：`[experimental]`
```bash
#示例
# Settings apply across all Linux distros running on WSL 2
[wsl2]

# Limits VM memory to use no more than 4 GB, this can be set as whole numbers using GB or MB
memory=4GB 

# Sets the VM to use two virtual processors
processors=2

# Specify a custom Linux kernel to use with your installed distros. The default kernel used can be found at https://github.com/microsoft/WSL2-Linux-Kernel
kernel=C:\\temp\\myCustomKernel

# Sets additional kernel parameters, in this case enabling older Linux base images such as Centos 6
kernelCommandLine = vsyscall=emulate

# Sets amount of swap storage space to 8GB, default is 25% of available RAM
swap=8GB

# Sets swapfile path location, default is %USERPROFILE%\AppData\Local\Temp\swap.vhdx
swapfile=C:\\temp\\wsl-swap.vhdx

# Disable page reporting so WSL retains all allocated memory claimed from Windows and releases none back when free
pageReporting=false

# Turn on default connection to bind WSL 2 localhost to Windows localhost. Setting is ignored when networkingMode=mirrored
localhostforwarding=true

# Disables nested virtualization
nestedVirtualization=false

# Turns on output console showing contents of dmesg when opening a WSL 2 distro for debugging
debugConsole=true

# Enable experimental features
[experimental]
sparseVhd=true
```


# wsl磁盘管理
wsl创建虚拟硬盘(VHD)来存储安装的每个linux发行版的文件，这些VHD使用ext4文件系统类型，表示为ext4.vhdx文件。wsl2会自动调整这些VHD文件的大小，最初为1TB的最大磁盘容量，可进行扩展。
