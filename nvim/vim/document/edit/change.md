这里描述删除和修改文本的命令
- 修改：用单个命令删除部分文本并将其替换成其他文本
- 所有本文描述的命令都可以被撤销
- 非命令行 (Ex) 的命令可以用 "." 命令重复

# 1. 删除文本


## 删除文本

```lua
["x]x/X
```
- 删除 [count] 个光标 之下和之后/之前 的字符 [到寄存器 x 里]

```lua
["x]d{motion}
```
-  删除 {motion} 动作跨越的文本 [到寄存器 x 里]


```lua
["x]dd
```
- 删除 [count] 行 [到寄存器 x 里]，

```lua
["x]D
```
- 删除光标所在的字符到行尾及其后的 [count]-1 行 [到寄存器 x 里]


```lua
{Visual}["x]x/d
```
- 删除高亮文本 [到寄存器 x 里]

```lua
{Visual}["x]X/D
```
- 删除高亮行 [到寄存器 x 里]
- 可视列块模式里，"D" 删除高亮的文本直到行尾。


```lua
:[range]d[eelte] [x]
```
- 删除 [range] 范围的行 (缺省: 当前行) [到寄存器 x 里]

```lua
:[range]d[elete] [x] {count}
```
- 从 [range] 指定的范围开始，删除 {count} 行 (缺省: 当前行cmdline-ranges) [到寄存器 x 里]

> [!NOTE]
> 如果`[range]`和`{count}`同时出现，那么`[range]`只能指定一个数，即是开始行



## 删除换行符


```lua
J/{Visual}J/gJ/{Visual}gJ
```
- `J`: 连接[count]行,删除缩进，插入不多于两个的空格
- `{Visual}J`: 连接高亮行，但至少包含两行。删除缩进，插入不多于两个的空格 
- `gJ`: 连接[count]行，不插入或删除任何空格。
- `{Visual}`: 连接高亮行，不插入或删除任何空格

```lua
:[range]j[oin][!] [flags]
```

- 连接 [range] 范围的行。和 "J" 相同
- 如有 [!] 时，连接不插入或删除任何空格
- 如果 [range] 包括相同的开始和结束行，该命令不做任何事。缺省行为是连接当前行与下一行。

```lua
:[range]j[oin][!] {count} [flags]
```
- 连接 [range] 开始的 {count} 行，其余同上

> [!NOTE]
> 连接后，'\[ 标记指向被连接的首行之原行尾处，'] 则指向合并后的行尾。




# 删除并插入

```lua
R
```
- 进入替换模式: 每个输入的字符替代一个现有的字符，从光标所在的位置开始。
- 退出删除模式后，重复刚刚输入的文本 [count] - 1 次

```lua
gR
```
- 进入虚拟替换模式: 每个输入的字符替代屏幕位置一个现有的字符
- 退出删除模式后，重复刚刚输入的文本 [count] - 1 次


```lua
["x]c{motion}
```
- 将 {motion} 跨过的文本删除 [到寄存器 x 里] 并开始插入

```lua
["x]cc/S
```
- 删除 [count] 行 [到寄存器 x 里] 并开始插入


```lua
["x]C
```
- 从当前光标位置删除到行尾，再删除 [count]-1 行 [到寄存器 x 里]，并开始插入


```lua
["x]s
```
- 删除 [count] 个字符 [到寄存器 x 里]，并开始插入
- s代表Substitute


```lua
{Visual}["x]c/s
```
- 删除高亮文本 [到寄存器x里] 并开始插入


```lua
{Visual}r{char}
```
- 把所有高亮的字符替换成 {char}

```lua
{Visual}["x]C/S/R
```
- 删除高亮行 [到寄存器 x 里] 并开始插入。
- C在可视列块模式下有所不同


```lua
:{range}c[hange][!]
```
- 用另外的文本替换若干文本行
- 如果没有 {range}，该命令只置换当前行
- 加上 [!] 后，在本命令的执行期间自动继承当前行的缩进，否则按'autoindetn'来


# 简单修改

## r命令

```lua
r{char}
```

- 把光标下的字符换成 {char}
    - 如果 {char} 是 \<CR> 或者\<NL>，则把该字符变成换行符。要换成一个真正的 \<CR>，使用 CTRL-V \<CR>。CTRL-V \<NL> 则换成 \<Nul>。
    -   若 {char} 为 CTRL-E 或 CTRL-Y，使用下一行或上一行的字符来代替


```lua
gr{char}
```
- 替换光标下的虚拟字符。替换发生在屏幕位置而不是文件位置上



## ~,u,U命令


下面的命令根据当前的locale改变字母的大小写

```lua
~/~{motion}/g~{motion}/g~~/{Visual}~
```
- `~`切换光标下字符的大小写，并把光标向右移
- 启动option 'notildeop'则`~`生效，否则`~{motion}`生效
- `g~{motion}`切换{motion}跨越的文本的大小写
- `g~~`切换当前行的大小写
- `{Visual}~`切换高亮文本的大小写



```lua
{Visual}U/gU{motion}/gUU
```
- 变成大写，类似`~`


```lua
{Visual}u/gu{motion}/guu
```
- 变成小写，类似`~`



## g?命令


```lua
g?{motion}/{Visual}g?/g??
```
- 使用Rot13对文本进行编码
> Rot13: 重复两次可以解码



## 递增与递减

```lua
<CTRL-A>/{Visual}<CTRL-A>/{Visual}g<CTRL-A>
```

- `<CTRL-A>`: 把当前光标之上或之后的数值或者字母加上 [count]
- `{Visual}<CTRL-A>`: 给高亮文本内的数值或者字母加上 [count]
- `{Visual}g<CTRL-A>`: 给高亮文本内的数值或者字母加上 [count]；如果高亮超过一行，每行会加上额外的[count]（递增）

```lua
<CTRL-X>/{Visual}<CTRL-X>/{Visual}g<CTRL-X>
```
- 同`<CTRL-X>`，不过是减少[count]


增减操作会考虑十进制开始的负号。二进制、八进制和十六进制值则不会。要忽略正负号，可视地选择数值本身。然后再应用 CTRL-A 或 CTRL-X。



## 将文本左移或右移

```lua
<{motion}/<</{Visual}[count]<
```
- `<{motion}`: 将 {motion} 跨越的多行左移 'shiftwidth' 列
- `<<`: 将 [count] 行左移 'shiftwidth' 列。
- `{Visual}[Count]<`: 将高亮行左移 [count] 个 'shiftwidth' 列

```lua
>{motion}/>>/{Visual}[count]>
```
- 同`<`，但是反向不同


```lua
:[range]</[range]< {count}
```

- `:[range]<`: 将 [range] 指定的多行左移 'shiftwidth' 列
- `[range]< {count}`: 左移 [range] 中从开始的 {count} 行 'shiftwidth' 列
- 对于`>`,只是方向不同，多了ex-flags选项


```lua
:[range]le[ft] [indent] 
```

- 左对齐 [range] 指定的多行。设置缩进距离为 [indent] (缺省为 0)。



# 复杂修改

## 过滤命令

过滤程序: 接受文本作为标准输入，作某些修改，并把结果放到标准输出的程序。

过滤命令把若干文本发送给过滤程序，然后用过滤的输出结果替换。

```lua
!{motion}{filter}   --用外部程序 {filter} 过滤 {motion} 跨越的多行
!!{filter}          -- 用外部程序 {filter} 过滤 [count] 行
{Visual}!{filter}   --用外部程序 {filter} 过滤高亮行
:{range}![!]{filter} [!][args] -- 用外部程序 {filter} 过滤 {range} 指定的多行
```


```lua
={motion}       -- 用 'equalprg' 选项指定的外部程序过滤 {motion} 跨越的多行
==              -- 和 ={motion} 类似，过滤 [count] 行
{Visual}=       --  和 ={motion} 类似，过滤高亮行
```

- 如果 equalprg 没有设置（默认是空），Vim 会用内置的排版规则，针对不同语言，Vim 根据缩进规则调整格式

> Vim 使用临时文件来处理过滤



## 替代

```lua
:[range]s[ubstitute]/{pattern}/{string}/[flags] [count]
```
- 对 [range] 指定的行把 {pattern} 的匹配替代成{string}
- 如果不指定 [range] 和 [count]，仅在当前行进行替代。
- 如果指定 [count]，在 [range] 区域内 和 [range] 最后一行开始的 [count]行进行替代
- 如果不指定 [range] ，则从当前行开始。

<!-- TODO: next time do it -->




# 复制并移动文本

```lua
"{a-zA-Z0-9.%:-"}       -- 指定下次删除、抽出和放置命令使用的寄存器
                        -- 大写字符使得删除和抽出命令附加到该寄存器
                        -- {.%#:} 只能用于放置命令

:reg[isters]            -- 显示所有编号和命名寄存器的类型和内容
                        -- 类型: c(harracterwise),l(inewise),b(blockwise-visual)
:reg[isters]/di[splay] {arg}      -- 显示 {arg} 里提到的编号和命名寄存器的内容





```


