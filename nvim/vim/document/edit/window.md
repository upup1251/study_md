使用多个窗口和缓冲区进行编辑

# 简介

## 缓冲区：内存中的文件文本

1. 缓冲区的描述

- "缓冲区" 是一块内存区域，里面存储着正在编辑的文件
- 如果没有把缓冲区里的文件存盘，那么原始文件不会被更改。
- 每个缓冲区有唯一的编号

2. 缓冲区的状态

- 激活：缓冲区的内容在窗口里显示
- 隐藏：缓冲区的内容不被显示
- 非激活：缓冲区的内容不被显示，也不包含任何数据

| 状态      | 在窗口显示 | 文件载入 | `:buffers` 命令显示 |
|-----------|------------|----------|----------------------|
| 激活      | 是         | 是       | 'a'                 |
| 隐藏      | 否         | 是       | 'h'                 |
| 非激活    | 否         | 否       | ' '                 |




## 窗口：缓冲区的试图

每个窗口有唯一的标识符，称为窗口 ID

窗口中缓冲区末行之后的行称为填充行。缺省，这些行以波浪号 (~) 字符开头

## 标签页：窗口的集合


# 启动Vim


参数 "-o" 和 "-O" 可以让 Vim 为参数列表里的每一个文件打开一个窗口

参数 "-oN"，这里的 N 是一个十进制数，用这个参数可以打开 N 个水平分割的窗口

状态行用来分割窗口。选项 'laststatus' 用来设置最后一个窗口在什么时候可以有状态栏:
- 'laststatus' = 0        永远不会有状态行
- 'laststatus' = 1        窗口数多于一个的时候
- 'laststatus' = 2        总是显示状态行

# 窗口命令

所有的 CTRL-W 命令都可以用  :wincmd  执行


## 打开和关闭窗口

```lua
<CTRL-W> s/S    -- 把当前窗口分割成两个，结果是两个窗口显示同一个文件
:[N]sp[lit] [file]
-- 新打开的窗口高度为 N (默认值是当前窗口高度的一半)
-- 如果给出 [file]，在新窗口中编辑该文件

:[N]sf[ind] {file}  -- 与 ":split" 命令相同，但是会给缓冲区置位 'readonly' 选项。
:[N]sf[ind] {file}  -- 与 ":split" 命令相同，但是会在 'path' 里寻找 {file}


<CTRL-W> n      -- 创建一个新窗口并且开始编辑一个空文件
:[N]new [file]  -- 新窗口的高度为 N (默认值为现存高度的一半)
                -- 如果给了file，则编辑它

:[N]vne[w] [file]   -- 与 :new 命令相似，但是它垂直分割窗口

<CTRL-W> v/V    -- 把当前窗口垂直分割成两个，结果是两个窗口显示同一个文件
:[N]vs[plit] [file]
-- 新打开的窗口宽度为 N (默认值是当前窗口高度的一半)
-- 如果给出 [file]，在新窗口中编辑该文件


<CTRL-W> ^      -- 把当前窗口分成两个，并且编辑轮换文件
                -- 如果指定了计数，分割窗口，并且编辑第 N 个缓冲区。
```



```lua
:ver[tical]/hor[izontal]/lefta[bove]/rightb[elow]/to[pleft]/bo[tright] {cmd}
-- 执行 {cmd}，如果包含一个分割窗口的指令，那么该窗口出现在目标位置
```


# 关闭窗口


```lua
:q[uit]
:{count}q[uit]
<CTRL-W> q
    -- 没有 {count}: 退出当前窗口
    -- 给出 {count}，退出第 {count} 个窗口
    -- 如果 [count] 大于最后一个窗口号，关闭最后一个窗口
    -- 如果退出的是最后一个编辑窗口 (不包括帮助或预览窗口)，就会退出Vim。

q[uit]!
:{count}q[uit]!
    -- 没有 {count}: 退出当前窗口
    -- 如果给出 {count}，退出第 {count}个窗口。
    -- 如果这是缓冲区的最后一个窗口，那么对于此缓冲区的改动将全部丢失并退出vim
```

```lua
:clo[se][!]
:{count}clo[se][!]
<CTRL-W> c
    -- 没有 {count}: 退出当前窗口
    -- 如果给出 {count}，退出第 {count}个窗口
```


```lua
:hid[e]
:{count}hid[e]
    -- 没有 {count}: 除非是屏幕上的最后一个窗口，退出当前窗口
    -- 如果给出 {count}: 退出第 {count} 个窗口
    -- 缓冲区被隐藏起来

:hid[e] {cmd}
    --  执行 {cmd}，其间置位 'hidden' 选项。{cmd} 执行完毕后，先前的'hidden' 选项会被恢复
```

```lua
:on[ly][!]
:{count}on[ly][!]
<CTRL-W> o
    -- 使当前窗口成为屏幕上唯一的窗口。其它窗口都关闭
    -- 如果置位了 'hidden' 选项，被关闭窗口里的所有缓冲区变成隐藏
    -- 如果没有置位 'hidden'，但是置位了 'autowrite' 选项，那么已经更改的缓冲区被写入文件
    -- 否则，除非使用 [!] 强制关闭，那些包含修改过的缓冲区的窗口不被删除，它们转入隐藏状态
```


# 把光标移动到另一个窗口

```lua
<CTRL-W> j      -- 将光标向下移动[count]个窗口
<CTRL-W> h      -- 将光标向左移动[count]个窗口
<CTRL-W> k      -- 将光标向上移动[count]个窗口
<CTRL-W> l      -- 将光标向右移动[count]个窗口
```


```lua
<CTRL-W> w
    -- 没有添加计数，则将光标移动到当前窗口的右/下方的窗口
    -- 如果右/下方没有窗口，就移动到左上角的窗口。
    -- 添加了计数，就移动到第 N 个窗口 (从左上方到右下方依次计数)。

<CTRL-W> W 
    -- 没有添加计数，则将光标移动到当前窗口的左/上方的窗口
    -- 如果左/上方没有窗口，就移动到右下角的窗口
    -- 要是添加了计数，就移动到第 N 个窗口，类似于 <CTRL-W> w
```

```lua
<CTRL-W> t      -- 把光标移动到左上角的窗口
<CTRL-W> b      -- 把光标移动到右下角的窗口
<CTRL-W> p      -- 把光标移动到上一个访问(preview)的窗口
<CTRL-W> P      -- 把光标移动到预览窗口
```


# 移动窗口

```lua
<CTRL-W> r      -- 向右/下方向旋转窗口
<CTRL-W> R      -- 向左/上方向旋转窗口

<CTRL-W> x      
    -- 若没有计数: 交换当前窗口与下一个窗口。如果没有下一个窗口，则与前一个窗口交换。
    -- 若有计数: 交换当前窗口与第 N 个窗口 (第一个窗口为 1)
```



```lua
<CTRL-W> K      -- 把当前窗口放到最顶端，并且是最大宽度
<CTRL-W> J      -- 把当前窗口放到最低端，并且是最大宽度
<CTRL-W> H      -- 把当前窗口放到最左端，并且是最大宽度
<CTRL-W> L      -- 把当前窗口放到最右端，并且是最大宽度
<CTRL-W> T      -- 把当前窗口移动到一个新的标签页上
```


# 改变窗口大小

```lua
<CTRL-W> =      -- 使得所有窗口 (几乎) 等宽、等高

:res[ize] -N 
<CTRL-W> -
    -- 使得当前窗口高度减 N (默认值是 1)

:res[ize] +N
<CTRL-W> +
    -- 使得当前窗口高度加 N (默认值是 1)

:res[ize] [N]
<CTRL-W> _
    -- 设置当前窗口的高度为 N (默认值为最大可能高度)
```

```lua
z{nr}<CR>
    -- 设置当前窗口的高度为 {nr}
```

```lua
<CTRL-W> <      -- 使当前窗口宽度减N（默认是1）
<CTRL-W> >      -- 使当前窗口宽度加N（默认是1）

:vert[ical] res[ize] [N]
<CTRL-W> |      
    -- 使当前窗口宽度减N（默认是最大可能宽度）
```


<!-- TODO: later: windows.txt 7.参数和缓冲列表的命令 -->