# 0.计算机概论
# 1.linux是什么与如何学习
# 2.主机规划和磁盘分割
# 3.安装centos
# 4.首次登陆和线上求助
## 首次登陆
### 图形界面tty5
### 终端界面tty2  
#### **顶端的字符**可以在`/etc/issue`文件中修改 
#### **指令**的组成
>[upupup@upupup]$ **command [-options] parameter1 parameter2 ...**  
>1. 一条命令第一个输入的部分绝对是『指令command』或『可执行文件』  
>2. command为指令的名称，如cd等等  
>3. 中刮号[]并不存在于实际的指令中，而加入选项设定时，通常选项前会带- 号，例如-h；有时候会使用选项的完整全名，则选项前带有-- 符号，例如--help；
>4. parameter1 parameter2.. 为依附在选项后面的参数，或者是command 的参数；
>5. 指令, 选项, 参数等这几个咚咚中间以空格来区分，不论空几格shell 都视为一格。所以空格是很重要的特殊字元！；
>6. 指令太长的时候，可以使用反斜线\ 来跳脱[Enter]符号，使指令连续到下一行。注意！反斜线后就立刻接特殊字符，才能跳脱！
#### **语言**的支持  
`locale`:查看目前支持的语言,这样输出就不会出现乱码的情况
#### **基础操作指令**  
 `date`:日期  
 `cal`:日历  
 `bc`:计算器  
#### **热键** 
`tab`:x1:自动补全；   x2:显示出所有符合前缀的名字  
`<C_c>`:中断目前程式  
`<C-d>`:键盘输入结束;   相当于输入exit  
`[shift]+{[PageUP]|[Page Down]}`:翻页  
## 线上求助help,man,info,doc
### **--help**
### **man**
>man date
>表格的第一行，你可以看到的是『DATE(1)』:其中的（1）对应了这个指令的属性
### **info**
>the file is stored in under `/user/share/doc`
## 关机
### check the usage now 
- `who`:check the user inline  
- `netstat -a`:check the usage of the network  
- `ps -aux`:check the systemctl process  
### the command of it
`sync` `reboot` `halt`  `poweroff`  
`shutdown`:with the option,it can send message to the user inline the shutdown will come  
# the file permissions and the dirctory  
linux is a muti-users system,classed by **`owner`,`group` and `others`**.So the file permissons of each file is important.So the permissions **`read`,`write` and `execute`** is improtant too.
## the message of the file 
>example:-rwxr--r-- 1 root root 1864 May 4 18:01 hello.cpp
>- the first symbol is the kind of the file  
d:dirctory;  
-:file;  
l:link;  
b:disk;  
c:the external device like mouse,leyborad etc...  
>- the permissons between kinds of users  
owner,group,others in order   
>- the file in it  
>- owner  
>- group  
>- size  
>- the revise latest
>- filename
##To change the permissons fo the file `chgrp` `chown` `chmod`
### **`chgrp`**:change the group of the file---change group
### **`chown`**:change the owner of the file---change owner
### **`chmod`**:change the permissons of the file---
## the dirctory of linux
### the default that FHS pointed
- /(root):the file with power on  
- /usr(unix software resource):the file of the app  
- /var(varible):the file generated with the system go
### the file under `/`
- the file FHS needs musts
>`/bin`:the commands all the user can use  
`/sbin`:the command the root use only  
>`/boot`:the file needs when the power on  
`/dec`:all the devices  
`/etc`:the set-up of system  
`/lib`:the functions of system  
`/media`:the device that could bu removed  
`/mnt`:the disk will be mounted timely  
`/opt`:the app by app-stores  
`/run`:the file generated after the power on  
`/ser`:the network service file  
`/tmp`:the file tempt saved
- the file FHS recommand
>`/home`:store the all the user  
`/lib<qual>`:the function with Binary format  
`/root`:the home for root  
- the file another  
>`/lost+found`:wrong happenend,will save the file lost  
`/proc`:the file generate in the memory,in processing  
`/sys`:record the message of the device in memory  
### the file under `/usr`
- the file FHS needs must
>`/usr/bin`:the same as /bin  
`/usr/lib`:the same as /lib,link to it  
`/usr/local`:the app download  
`/usr/sbin`:the /sbin link to it  
`/usr/share`:some doc  
- the file FHS recommand
>`/usr/games`:the file of game  
`/usr/include`:the C++ header file  
`/sur/libexec`:the exeuted file like .sh and script  
`/sur/lib<qual>`:/lib<qual> link to it  
`usr/src`:src=source,some 原始码
### the file under `/var`  
>`/var/cache`:file the bash generate  
`/var/lib`:file was needed when the app processing   
`/var/lock`:the file other app is using,lock it lest other app use it together  
`/var/log`:the file of the use login  
`/var/mail`:the mail-box  
`/var/run`:the PID of the processing system or app  
`/var/spool`:the file waitting for other app fetch  

# the command of linux file and dirctory
## the dirctory
- the special dirctory
>`.`:presently dirctory  
`..`:the upper dirctory  
`-`:the last dirctory  
`~username`:the home of username  
### the commands of dirctory  
> `cd `:switch the dirctory  
 `pwd`:print the dirctory  
 `mkdir`:make a dirctory  
 `rmdir`:remove a empty dirctory  
 `ls`:list the dirctory or file  
 `cp`:copy  
 `mv`:move or rename  
 `rm`:remove   
 `dirname`:get the dirname of the path  
 `basename`:get the name of the file  

 >why the command could be found?  
 the $PATH tell the bash where to find the path of command 

## the file 
### command look up to file
>`cat`:satrt at the begin of the file  
`tac`:the opposite of cat,start from the end  
`nl`:look with line number  
`more`:look file page by page form the begin   
`less`:page by page from the end  
`od`:look it by Binary  
### revise the file time or make a new file  
`touch`
## the pre_set-up permissons and the hidden of the file or dirctory
### pre_set-up of file
`umask`:look the settings of file
>it will give you 4 numbers  
the first is a special permissons  
the three left is the permissons that was removed  

`umask xxx`:set the number of the permissons

### hidden the file
**`chattr`**:set the hidden property of file  
**`lsattr`**:look the hidden property of file

### look up the kind of file 
**`file`**:it will display the porperty of the file   

## the seasrch of the file and command 

### saerch the command
**`which`**
### search the file
**`whereis`**:search the file in some special path  
**`locate`**:search the file in the daily file-database  
>**`updatedb`**:update the database the locate search now insteal everyday automaticly  
**`find`**:search from the disk slowly  


# linux disk and the file system
## the linux ETX 
>每个file(不管是一般file还是目录)都会占用一个inode ， 且可依据档案内容的大小来分配多个block 给该档案使用。
### the knowledge of linux file system    
the linux filesystem pointed **three paetion**
>superblock:record the total message of current filesystem,such as the  all capacity and the free capacity of the inode/block and the filesystem format  
>inode:record the property of the file,such as the permissons and the owner/group/others of a file.record the block num of each file.  
>block:the content of the file.
### the EXT2 filesystem
with so many inode and block together,the etx2 divided the disk to several **block** group,each all contains 
>**inode/block/superblock/**  
>**filesystem description**/:tell where the block in the disk   
>**block bitmap/inode bitmap**:the empty partion of block and inode  
### `dumpe2fs`
>search the disk ETX stitution
## the file tree with ETX
### dirctory
when create a dirotory,the system will be given a inode and some block,
the inode record the property and permisson of the dir,the num of each block belong to him.the block record the filename and their inode num belong to current dir
### file
when create,the system will give him a inode and some block.the dir record the inode num,then the inode num point to a block where the content be
>LINK file  
1. hard link:without making a file,only creat a inode num and filename on the block of the current dirctory   
2. Symbolic Link:making a file,let the inode of the file pointed  to the block of the real file.

### the new XFS after EXT
the XFS divide disk to three partion
>data section:include inode/data block/superblock as EXT,but the inode and block is not preformat,so is faster than EXT
>log section:the file which in memory to be revise will be recoeded   
realtime section:creating file,the content appear here firstly,then to disk

### the command of watch the disk usage 
**`df`**:the usage of all disk  
**`du`**:the usage of current dir  


## the part,formation,check and mount of disk
>to add a new disk
###list the status of the disk   
**`lsblk`**:list block device  
>MAJ:MIN:the major code and the minor code  
RM:wheather removable device  
RO:wheather read only  
TYPE:disk/partion(分割槽)/rom..  

**`blkid`**:the uuid(the same as `lsblk -f`)  
**`parted devicd_name print`**:display the partionstatus  

### part the disk
**`gdisk`**:for GPT  
**`fdisk`**:for MBR  
**`parted`**:all  

### format the disk
**`mkfs`**:make filesystem  
>mkfs is a muti command,could make different filesystem formations

`mkfs.xfs`:format to xfs  
`mkfs.ext4`:format to ext4  
`mkfs[tab][tab]`:others  

### the mount and umount 
>when we mount a partion to a dirctory,the content will be didden temptly,will be visable after umount

**`mount`**:mount the disk  
**`mount -o remount,rw,auto dir_name`:remount lest only be read.  
**`umount`**:umount the disk  
>add finish
### revise the disk property
`mknod`  
`xfs_admin`  
`tune2fs`  

## auto mount  
>the format for oneline
[diskname/UUID etc.] [mount point] [filesystem] [parameter] [dump] [fsck]  

## special dev mount by loop
## the another memory room -- swap
>part  
format(`mkswap`)  
use(`swapon`)  
watch(`swapon -s`/`free`)


# zip

# vim 
# bash
>the shell like a app to talk to the kernel,aim to tell the kernel what we do and what to do to the hardware
## the variable in shell
### the  operation of variable
1. by commond
- echo + $variable_name:creat
- variable_name=value:assignment
- export variable_name:make it a environment variable
- unset variable_name:cancel
2. be cin
- read
3.with the type of variable
- declare
---
**`env`**:envrionment-->list all the variable in the environment
**`set`**:all the variable
>PS1:it will determine the char appear in the shell ,like name@deskpot_name:~$

## the other_name of command and the history
**`alias`**  
**`unalias`**  
---
**`history`**
with the `!`,wo can use the command in the history

## the environment of bash shell

## redierct > and >>

## pipe
