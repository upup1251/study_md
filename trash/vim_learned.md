# start
## 打开多个窗口
- 打开多个窗口
```
打开两个水平分割的窗口  
vim -o2  

打开两个垂直分割的窗口  
vim O2
```
- 打开多个文件  
    ```
    vim filename1 filename2 ...
    ```
## 保存、退出  
```
:w filename     保存  
:q      退出  
:q!     退出不保存  
:wq     退出并保存  

多个buffer的退出  
:qall   :qall!  wqall
```
# 第二章 缓冲区buffers、窗口windows和选项卡tabs





vimrc+set hidden
## buffers
```
:buffers    查看所有buffer  
:bnext(previous)    切换至下（上）一个buffer  
:buffer+文件名/:buffer+n    切换至指定buffer  
:bdelete+文件名/:buffer+n   删除指定buffer  
<C-O>,<C-I>    跳转 
```
## windowos
一个windows就是buffer上的一个窗口  
```
打开：
:vsplit filename     垂直分割当前窗口，并在新窗口打开filename文件  
:split filename     水平分割当前窗口，并打开filename  
:new filename   创建一个新窗口并打开filename文件  

切换：
Ctrl-W H    移动光标到左边的窗口
Ctrl-W J    移动光标到下面的窗口
Ctrl-W K    移动光标到上面的窗口
Ctrl-W L    移动光标到右边的窗口

普通模式下关于窗口的指令
Ctrl-W V    打开一个新的垂直分割的窗口
Ctrl-W S    打开一个新的水平分割的窗口
Ctrl-W C    关闭一个窗口
Ctrl-W O    除了当前窗口，关闭所有其他的窗口
```
## tabs
tab是窗口的集合，关闭tab时，仅仅是关闭了窗口布局，文件的数据仍然储存在内存的buffer中，没有被关闭。
``````
:tabnew file.txt    在tab中打开一个文件
:tabclose           关闭当前tab
:tabnext/gt            切换至下一个tab
:tabprevious/gT        切换至前一个tab
:tablast            切换至最后一个tab
:tabfirst           切换至第一个tab
n+gt	切换到第几个tab
```  


