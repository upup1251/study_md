ok,here are my fruit of the fish shell language,by [fish官方文档](https://fishshell.com/docs/current/tutorial.html)


```text
   ___              __         
 /'___\ __         /\ \        
/\ \__//\_\    ____\ \ \___    
\ \ ,__\/\ \  /',__\\ \  _ `\  
 \ \ \_/\ \ \/\__, `\\ \ \ \ \ 
  \ \_\  \ \_\/\____/ \ \_\ \_\
   \/_/   \/_/\/___/   \/_/\/_/
```


---
[toc]


# 1. 命令和进程
## 1.1 语法预览 
1. 所有的程序在fish中都可以看作命令command,如果该程序文件是位于$PATH的目录下，我们则可以直接通过该程序的名字调用他，否则需要包括他的目录
2. 命令和参数是通过space隔开的，每一条命令以回车return或者分号结束`;`


## 1.2 参数的引号
有时我们传递给命令的参数中包含了space,$或*。为了避免其特殊含义，我们可以使用引号  
`单引号`:原样输出  
`双引号`:只会进行 变量展开 和 命令替代in the `$(command)`


## 1.3 命令执行操作符

|操作|操作符|用法|
|---|---|---|
|顺序执行|\||从左到右依次执行命令|
|逻辑与|&&/and|会执行第二条语句，如果第一条语句成功执行  |
|逻辑或|\|\|/or|会执行第二条语句，如果第一条语句未能执行|


## 1.4. 输入输出重定向
三种io流(FD是每个流的绑定数字)

|stdin(FD:0)|标准输入流，默认从键盘输入|
|---|---|
|stdout(FD:1)|标准输出流，默认输出到屏幕|  
|stderr(FD:2)|标准错误输出流，默认输出到屏幕 |

> 流的方向可以被改变通过重定向符号`>`

| `<SOURCE_FILE`|从文件中读取，让文件代替标准输入流 |
|---|---|
|  `>DESTINATION`|将数据输出到一个文件中  |
|  `2>DESTINATION`|将错误输出到文件中  |
|  `>>DESTINATION_FILE`|将数据追加到一个文件中  |
|  `2>>DESTINATION_FILE`|将错误信息追加到一个文件中  |
|  `>?DESTINATION`or`2>?DESTINATION`|不会覆盖一个已存在的文件  |

> `DESTINATION`可能是  
> - 一个文件名(>/dev/null 为黑洞)
> - `&`+FD流绑定的数字(将信息输出到指定流中，可将各个流关联起来)  
> - `&-`  
方便考虑，`&>`可以将输出和错误信息同时输出到同一个目的地上  
我们可通过`N<DESTINATION`和`N>DESTINATION`和`N>>DESTINATION_FILE`(其中N是各个流的FD)来改变各个流的输出方向  


## 1.5. 状态动词`status`
当一个进程退出时，他会返回一个退出状态给启动他的程序(一般是shell)。退出状态一般是一个数字，为0时表示没有发生错误，否则存在一些问题。其存储在`$status`变量中  

|退出状态|含义|
|---|---|
| 0|成功执行|
| 1|未能实现要求的操作  |
| 121|参数错误  |
| 123|命令名包含错误字符|
| 124|通配符未匹配|
| 125|命令找到了，操作系统不执行  |
| 126|目标不是可执行文件> 127:未能找到命令名  |

## 1.6 进程管理  
启动后台进程：`command` + `&`

|命令|作用|
|---|---|
|`fg [PID...]`|将后台程序拉回前台,默认最新进程，可添加`%进程号`进行特定进程的恢复    |
|`bg [PID...]`|将前台进程送至后台  |
|`disown [PID...]`|将后台进程杀死|
|`jobs`|查看目前已经开始的进程，可查看起进程号  |
|`CTRL+Z`|在前台程序中将该程序放入后台  |


# 2. shell变量
`set xxx xxx`:设置变量和他的值  
> shell变量只存在字符类型
> 如果fish变量的值中存在空格，fish不会像其他sh一样对他们进行进一步划分，而是永远当作一个值。即不会将touch "my file"切割为my，file两个文件   
## 2.1 变量范围  
> 可通过`set -u/g/f/l`设置  

|前缀|范围|
|---|---|
| `universial`|可以被所有的fish任务访问，重启后仍存在  |
| `global`|只可被目前的fish任务访问，可以使用set -e擦除  |
| `function`|只有特定的函数可以访问  |
| `local`|只可被当前的代码块访问  |

## 2.2 环境变量
- set -x / --export 设置环境变量
- set -u / --unexport 取消设置

## 2.3 list列表
> 列表可以存储多个字符串在一个变量中,用下标访问  

|用法|含义|
|---|---|
|`set variable_name value1 value2 ...`|创建list  |

> `cout $hi`|输出hi中的动词数量  
> `contains variable_name $hi``echo $status`|查看hi中是否含有变量，有的话返回状态0


### 2.3.1切片  
fish中的列表下标从1开始  
$list[2]:获得list中第二个元素的值  
$list\[1..3]:获得list中第一个到第三个元素的值  
> 当列表的下标为负数的时候，则会反转列表，-1为倒数第一个  



# 3. 控制语句

## 3.1 判断条件

> 就像其余shell语言，不同于编程语言，这里的条件是一条命令  
> 如果该语句返回一个true exit status(__0__),则会执行该语句  

- 普通命令条件
> 命令是否执行取决与用于判断的命令的退出状态是多少$status
 
 - test命令条件
> 比较字符串、数字、文件信息使用test命令
> test命令可添加参数和选项，后返回true或false

|用法|为true的情况|
|---|---|
|目录和文件的相关操作| |
|-e file|file存在|
|-s file|file size大小大于0|
|-b file|file是一个block device块设备|
|-c file|file是一个character device字符设备|
|-d file|file是一个directory目录|
|-f file|file是一个regular文件（存储用户数据的文件）|
|-L file|file是一个symbolic link链接文件|
|-O file|file存在并且owned属于当前用户|
|-G file|file存在并且和usr是一个组|
|-r file|file readable可读|
|-w file|file writable可写|
|-x file|file exec可执行|
|目录和文件的比较操作| |
|file1 -nt file2|file1 new than新于 file2,或者file1存在file2不存在|
|file1 -ot file2|file1 new than老于 file2,或者file1不存在file2存在|
|file1 -ef file2|file1和file2是同一个文件 |
|字符串操作| |
|string1 = string2|相等|
|string1 != string2|不相等|
|-n string|strig长度is non-zero不为0|
|-z string|strig长度is zero为0|
|数字操作| |
|num1 -eq num2|equal,相等|
|num1 -ne num2|not equal,不相等|
|num1 -gt num2|greater than,大于|
|num1 -ge num2|greater than or equal,大于或等于|
|num1 -lt num2|less than,小于|
|num1 -le num2|less than or equal,小于或等于|
|连接操作符| |
|cond1 -a cond2|and|
|cond1 -o cond2|or|
|!EXPRESSION|非|
|(EXPRESSION)|返回表达式的值|


## 3.2条件语句

|关键字|备注|
|---|---|
|if| |
|case|会进行字符串的匹配  |


### 3.3 循环语句  
|关键字|备注|
|---|---|
|while|while执行起来就像一个重复执行的if语句  |
|for|用于迭代列表中的每一个值|
|break和continue| |



# 4. 函数
## 4.1 函数参数列表$argv  

|参数类型|存储位置|
|---|---|
|列表|`$argv`列表，传递给函数的参数会被存储在`$argv`列表中|
|选项|`argparse`列表，存储类似于-h.-r...，函数传参时会被选项和参数会被分开处理  |

## 4.2 特殊函数
|函数类型|作用|
|---|---|
自动加载函数|我们可以添加`function_name.fish`在`$fish_function_path`中，fish会自动加载该路径中的文件  |
自动化函数|当遇到某些情况时，会自动执行该函数|
特殊函数|`fish_title`:程序名函数,当一条新的命令被执行的时候，程序名会改变    |
| |`fish_prompt` `fish_right_prompt` `fish_mode_prompt`:用户提示符函数名，可更改提示符形式    |
| |`fish_greeting`:登陆时问候函数，我们可以修改变量`fish_greting`来修改问候语  |



## 5. 参数扩展

> 当fish接收到一条命令时，在他将这条命令发送给下一方时，它会对该命令进行扩展  

### 5.1 通配符  

|通配符|含义|
 |---|---|
| `*`|将会匹配任意数量的字符,但是不包括/,只会在当前目录中寻找目标文件|
|`**`|将会包括任意数量的字符，并且会到子目录中去寻找目标文件  |
|`?`|只会匹配一个字符，不包括/|

### 5.2 变量扩展
`set variable_name value `:设置自己的变量  
使用变量  
- $variable_name
- {$variable_name}
- "$variable_name"


### 5.3 命令替换
用法：  
- `outerconmmand (innercommand)`
- `outerconmmand $(innerconmmand)`
- `outerconmmand "innercommand"`

注意：
- 命令替换只的是使用另外一条命令的输出作为本命令的参数  
- 如果另外一个命令的输出有很多行，那么则会把每一行分割为一个单独的参数，与其余shell不同,当使用双引号时则不会进行分割处理  

### 5.4 大括号{}扩展

大括号被用于实现列表，在大括号扩展这里列表中的值会变成一个新的,单独的参数  
> 例：echo n{1,2,3}.txt    # n1.txt n2.txt n3.txt

### 波形符扩展
`~`:扩展为用户的家目录地址  

优先级顺序：
1. 命令替换  
2. 变量扩展  
3. 大括号扩展  
4. 通配符扩展  


# 6. 历史目录

|命令｜作用｜
|---｜---｜
| `dirh` | 打印历史目录 |
|`cdh`|快速导航到历史目录|
|`prevd`|回到上个目录，同ALT+方向键左  |
|`nextd`|回到下个目录，同ALT+方向键右  |

# 7. 附录

|操作|操作描述|
|---|---| |
|注释|`#`:添加在其后的都将成为注释，没有多行注释，只有单行注释  |
|转义字符 |\ + 特殊字符|
|abbr别名| |
|管道命令|将一个命令的标准输出和另一个命令的标准输入联系起来|
|管道状态$pipestatus |会储存管道命令中每一条指令的状态，存储在列表中  |
|自动建议|fish的自动建议依赖于历史命令|
|隐私模式|不会记录命令 <cmd>fish --private / -P<cr>|
|vi_mode模式| |
|交互模式| |
