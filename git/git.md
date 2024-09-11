# github配置ssh key
往github上push项目的时候，走https的方式，每次都需要输入账号和密码，二采用ssh的方式，则只需在github账号下配置一个ssh key即可。

步骤：
1. 使用密钥生成工具生存rsa密钥和公钥
2. 将rsa公钥添加掉代码托管平台
3. 将rsa密钥添加到ssh-agent中，为ssh client指定使用的密钥文件

```bash
//检查是否存在rsa公钥
cd ~/.ssh 
ls
//若存在id_rsa和id_rsa.pub文件说明已经有ssh key

//生成ssh key
ssh-keygen -t rsa -C "xxx@xxx.com"

//在github上添加公钥
settings->SSH and GPG keys->New SSH key

//验证是否成功
ssh -T git@github.com
```

# 初次运行git前的配置
git自带一个git config的工具来设置git外观和行为的配置变量
| 配置文件 | 说明 |
| --- | --- |
| /etc/gitconfig | 包含系统上每一个用户及他们仓库的通用配置。 如果在执行 git config 时带上 --system 选项，那么它就会读写该文件中的配置变量。 |
| ~/.gitconfig或~/.config/git/config | 只针对当前用户。 你可以传递 --global 选项让 Git 读写此文件，这会对你系统上 所有 的仓库生效。 |
| workspace/.git/config | 针对该仓库。 你可以传递 --local 选项让 Git 强制读写此文件，虽然默认情况下用的就是它。  |

```bash
//配置用户信息
git config --global user.name "upup1215"
git config --global user.email tianqi1251@outlook.com
git config --global core.editor neovim

//检查配置信息
git config --list
// 查看所有配置以及它们所在的文件
git config --list --show-origin

```

# git基础

## 获得git仓库

- 在已存在的目录中初始化仓库
```bash
git init
//该命令将创建一个名为 .git 的子目录，这个子目录含有你初始化的 Git 仓库中所有的必须文件
```

- 克隆现有的仓库
```bash
git clone <url> [LocalName]
//新创建一个目录，并在这个目录下初始化一个 .git 文件夹， 从远程仓库拉取下所有数据放入 .git 文件夹，然后从中读取最新版本的文件的拷贝
```


## 记录每次更新到仓库
工作目录下的每一个文件都不外乎这两种状态：已跟踪 或 未跟踪。 已跟踪的文件是指那些被纳入了版本控制的文件，在上一次快照中有它们的记录，在工作一段时间后， 它们的状态可能是未修改，已修改或已放入暂存区。简而言之，已跟踪的文件就是 Git 已经知道的文件。

![](https://git-scm.com/book/en/v2/images/lifecycle.png)

- 跟踪新文件
`git add filename`

- 检查当前文件状态
```bash
git status

git status -s
M README    //修改过的文件
MM Rakefile //
A  lib/git.rb   //新添加到暂存区的文件
M  lib/simplegit.rb //修改过的文件
?? LICENSE.txt      //新添加的未跟踪文件
```

- 忽略文件`.gitignore`
文件.gitignoew的格式
    - 所有空行或以#开头的行都会被Git忽略
    - 可以使用glob模式匹配
    - 匹配模式可以以/开头防止递归
    - 匹配模式可以以/结尾指定目录
    - 要忽略指定模式外的文件或目录，可以在模式前加上！取反
>  glob 模式是指 shell 所使用的简化了的正则表达式。 星号（*）匹配零个或多个任意字符；[abc] 匹配任何一个列在方括号中的字符 （这个例子要么匹配一个 a，要么匹配一个 b，要么匹配一个 c）； 问号（?）只匹配一个任意字符；如果在方括号中使用短划线分隔两个字符， 表示所有在这两个字符范围内的都可以匹配（比如 [0-9] 表示匹配所有 0 到 9 的数字）。 使用两个星号（\*\*）表示匹配任意中间目录，比如 a/\*\*/z 可以匹配 a/z 、 a/b/z 或 a/b/c/z 等。

- 查看已暂存和未暂存的修改`git diff`

- 提交更新`git commit`
