折叠

# 折叠方法


可用选项 'foldmethod' 来定义折叠方法

- 设置为非 "manual" 的其它值时，所有的折叠都会被删除并且创建新的
- 设置成 "manual"，将不去除已有的折叠


## manual手工

使用命令来手工定义要折叠的范围

折叠的级别仅由嵌套次数来定义

退出文件编辑时，手工折叠会被遗弃。要保存折叠，使用  :mkview  命令。之后要恢复可以使用  :loadview

## indent缩进

由缩进行自动定义折叠

折叠级别由行的缩进除以 'shiftwidth' (向下取整) 计算而得

连续的，有同样或更高的折叠级别的行，形成一个折叠

嵌套的级别数受 'foldnestmax' 选项限制。


## expr表达式

对每行，通过计算选项 'foldexpr' 的值来并得到它的折叠级别

## syntax语法

由带有 "fold" 参数的语法项来定义折叠

折叠级别由嵌套的折叠层数来定义。嵌套数由 'foldnestmax' 限定

## 比较

对没有改动的文本或靠近改动的文本自动定义折叠。

仅适用于当前窗口设定 'diff' 选项来显示不同之处时才有效

## 标志

在文本中可以加入标志来指明折叠开始和结束的地方

选项 'foldtext' 通常设置为使折叠行显示折叠标志之前的文本，可以为折叠命名

标志可以包含级别数，也可以使用匹配对

"zf" 可通过标志来创建一个折叠。 Vim 将为你插入开始和结束标志。这些标志由'foldmarker' 指定

"zd" 可用来删除一个用标志定义的折叠。 Vim 将为你删除标志。Vim 将在折叠的开始和结束处根据 'foldmarker' 查找开始和结束标志


# 折叠命令

所有折叠命令都是以`z`开头

## 创建和删除折叠


仅当 'foldmethod' 设为 "manual" 或 "marker" 时有效

```lua
zf{motion}/{Visual}zf       -- 创建折叠操作符
zF                          -- 对 [count] 行创建折叠。其余同 "zf" 。
:{range}fo[ld]              -- 对 {range} 内的行创建折叠。其余同 "zf"
```
- 用 "manual" 方式，新建的折叠会被关闭。同时 'foldenable' 会被设定。

```lua
zd                          -- 删除 (delete) 在光标下的一层折叠
zD                          -- 递归删除 (Delete) 光标下的所有折叠
zE                          -- 除去 (Eliminate) 窗口里所有的折叠
```


## 打开和关闭折叠

嵌套层数小于 'foldminlines' 的折叠的都会被打开

```lua
zo              -- 打开 (open) 在光标下的折叠
                -- 当给定计数时，相应深度的折叠被打开
                -- 在可视模式下，所选区域的所有行的折叠被打开一级。
zO              -- 循环打开 (Open) 光标下的折叠

zc              -- 关闭 (close) 在光标下的折叠
                -- 当给定计数时，相应深度的折叠被关闭
                -- 在可视模式下，所选区域里的所有行的折叠被关闭一级。
zC              -- 循环关闭 (Close) 在光标下的所有折叠

za              -- 当光标位于一关闭的折叠上时，打开之
                -- 当给定计数时，打开相应数量的被关闭的折叠
                -- 当光标位于一打开的折叠上时，关闭之且设定 'foldenable'
zA              -- 嵌套toggle
```


```lua
zm              -- 折起更多（more）
                -- 'foldlevel'--
zm              -- 折起更多（more）
                -- 'foldlevel' = 0

zr              -- 减少（reduce）折叠
                -- 'foldlevel'++
zR              -- 打开所有折叠
                -- foldlevel = max
```


```lua
zn              -- 不折叠（none）
                -- 'foldenable' = false
zN              -- 正常折叠（normal）
                -- 'foldenable' = true
zi              -- toggle 'foldenable'
```

```lua
:{range}folddo[pen][!]
    -- 在 {range} 内打开折叠
    -- 当加上 [!] 时，嵌套打开所有折叠，否则打开一层折叠

:{range}foldc[lose][!]
    -- 在 {range} 内关闭折叠
    -- 当加上 [!] 时，嵌套关闭所有折叠，否则关闭一层折叠
```



```lua
zv              -- 查看（view）光标所在行：仅打开最小的折叠使光标所在行不被折叠

zx              -- 更新折叠
                -- 撤销被手工打开和关闭的折叠
                -- 设置'foldlevel'为默认值
                -- 使用`zv`查看光标所在行
zX              -- 更新折叠
                -- 清除现有折叠后重新进行折叠
                -- 设置'foldlevel'为默认值
                -- 使用`zv`查看光标所在行
```


## 折叠中移动

```lua
[z              -- 到当前打开的折叠的开始
]z              -- 到当前打开的折叠的结束

zj              -- 到达下一个折叠的开始处
zk              -- 到达上一个折叠的开始处
```

## 对折叠执行命令


```lua
:[range]foldd[oopen] {cmd}
    -- 对所有打开的折叠中的行执行 {cmd}
    -- 给定 [range] 时，仅对范围内那些行起作用
    -- 每次命令被执行时，光标会被定位在要被操作的行上

:[range]folddoc[losed] {cmd}
    -- 对所有在关闭的折叠里的行，执行 {cmd}
    -- 同:foldd {cmd}
```


# 折叠选项

## 颜色

- Folded高亮组'hl-Folded': 设定关闭折叠的颜色
- FolderColunm高亮组: 设定折叠栏的颜色

```lua
:hightlight Folded ...
:hightlight FoldColumn ...
```


## 折叠级别

option 'foldlevel': 选择打开嵌套折叠的层数
- 'foldlevel'==0，关闭所有折叠
- 'foldlevel'==a，打开符合条件的折叠
- 'foldlevel'==max，打开所有折叠

## 折叠文本


option 'foldtext': 定义了一个表达式，用来求得关闭折叠时所显示的文字

## 折叠栏宽度

option 'foldcolumn': 设定在窗口边上显示折叠栏的宽度


## else

- 'foldnable': 是否打开所有折叠
...


# 折叠行为



许多移动命令处理连续被折叠的行就像处理空行一样

在关闭折叠中开始搜索时，不会查找当前折叠里的匹配

在插入模式下，光标所在的行不会被折叠

当使用操作符时，一个关闭的行被作为整体处理

编辑一个已经被编辑过的缓冲区时，上次被使用的折叠设置会被再次使用。



