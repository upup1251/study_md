<!-- lua.md -->

```text
    ___       ___       ___   
   /\__\     /\__\     /\  \  
  /:/  /    /:/ _/_   /::\  \ 
 /:/__/    /:/_/\__\ /::\:\__\
 \:\  \    \:\/:/  / \/\::/  /
  \:\__\    \::/  /    /:/  / 
   \/__/     \/__/     \/__/  

```


[toc]

---

lua的特性
- 轻量级: 它用标准C语言编写并以源代码形式开放，编译后仅仅一百余
- 可扩展性 
- 其他
    - 支持面向过程编程和函数式编程
    - 自动内存管理，只提供一种通用类型的表，用它可以实现数组、哈希表、集合和对象
    - 内置模式匹配；闭包中；函数可以看作一个值；协同进程支持
    > 通过闭包和table可以很方便地支持面向对象编程所需要的一些关键机制，比如数据抽象，虚函数，继承和重载等。



# 入门指南


## 变量


**变量的种类**

- 全局变量
- 局部变量
- 表中的域

**特点**

- Lua中的变量全是全局变量，哪怕是语句块或是函数里，除非用local显式声明为局部变量。
    > 局部变量的作用域为从声明位置开始到所在语句块结束。 

- 变量的默认值均为`nil`

**变量赋值**

多值赋值：Lua 可以对多个变量同时赋值，变量列表和值列表的各个元素用逗号分开

> 遇到赋值语句Lua会先计算右边所有的值然后再执行赋值操作



## 数据类型

- nil: 一个空值
    - 输出一个没有赋值的全局变量，会得到一个nil
    - 给全局变量或者table表里的变量赋值为nil时，等同于把他们删掉。

- boolea: false,true
    - false和nil为假，其余为真

- number: double双精度浮点数

- string: 字符串，'/"均可
    - 也可以用2个方括号“[[]]”来表示多行字符串。
    - 尝试对一个数字字符串上进行算术操作时，Lua 会尝试将这个数字字符串转换成一个数字。
    > 与javascript恰恰相反
    - 字符串连接符号为： ..
    - 使用`#`符号来计算字符串的长度，放在字符串的前面。

- table: 关联数组
    - 数组的索引可以是一个数字或者字符串。
    - Lua表的默认初始索引值一般从1开始。
    > 索引的使用：t.[i] = t.i = gettable_event(t,i)

- funciton: 由C或lua编写的函数
    - 在Lua中，函数被看作是“第一类值（first-CLass Value）”，函数可以存在变量里。使用 function 关键字定义。

- userdate: 存储在变量中的C数据结构，可以将任意 C/C++ 的任意数据类型的数据（通常是 struct 和 指针）存储到 Lua 变量中调用。

- thread: 执行的独立线程
    - Lua里，最主要的是协程（coroutine）。它跟线程差不多，拥有自己独立的栈、局部变量和指令指针，可以跟其它协程共享全局变量和其它大部分东西。
    - 线程可以同时多个运行，而协程任意时刻只能运行一个，并且处于运行状态的协程只有被挂起（suspend）时才会暂停。

> type(): 返回目标的数据类型的`字符串`



### lua字符串

形式：

- 单\双引号之间的一串字符
- \[\[ 和 ]] 之间的一串字符


字符串长度的计算

- string.len()
- utf8.len()
    > 包含中文用utf.len()



字符串的操作函数
|序号|函数|描述|
|----|----|----|
|3|string.sub(s,i [,j])|字符串截取，s[i,j]
|1|string.upper(argument)|字符串全部转换为大写字母|
|2|string.lower(argument)|字符串全部转换为小写|
|3|string.gsub(main String, find String, replaceString, num)|在字符串中替换，mianString为与目标字符串，findString为被替换的字符，replaceString为要替换的字符，num替换次数（不指定则全部替换）|
|4|string.find(str, substr, [init,[end]])|在一个指定的目标字符串中搜索指定的内容（第三个参数为索引）。返回其具体位置，不存在则返回nil|
|5|string.reverse(arg)|字符串反转|
|6|string.format(...)|返回一个类似print的格式化字符串|
|7|string.char(arg)和string.byte(arg[,int])|char将整型字转换成字符并连接，byte转换字符为整数值（可以指定某个字符，默认第一个字符）|
|8|string.byte(string)|将字符串变成整数|
|9|string.length(arg)|计算字符串长度|
|10|string.rep(string, n)|返回字符串string的n个拷贝|
|11|..|连接两个字符|
|12|string.gmatch(str, pattern)|一个迭代器函数，每一次调用这个函数，返回一个在字符串str找到的下一个符合pattern描述的字串。如果参数pattern描述的字符串没有找到，迭代函数返回nil|
|13|string.match(str, pattern, init)|只寻找源字串str中的第一个配对，参数init可选，指定搜寻过程的起点，默认为1.在成功配对时，函数将返回配对表达式中的所有捕获结果，如果没有设置捕获标记，则返回整个配对字符串，当没有成功的配对时，返回nil。| 





### lua表table 

- Lua table 使用关联数组，可以用任意类型的值作为数组的索引，只要索引值不是nil。 
> Lua也是通过table来解决模块（module）、包（package）和对象（Object）的。


**table表的构造**

构造器是创建和初始化表的表达式。  
最简单的构造函数是{}，用来创建一个空表。

```lua
-- 初始化表
mytable = {}

-- 指定值
mytable[1]= "Lua"

-- 移除引用
mytable = nil
-- lua 垃圾回收会释放内存
```

table操作

| 名称 | 用途 |
| --- | --- |
|table.concat (table [, sep [, start \[, end]]]) | 连接|
| table.insert (table, \[pos,] value): | 插入 |
| table.remove (table [, pos]) | 移除 |
| table.sort (table [, comp]) | 排序 |

#### lua元表


Lua 中的元表（metatable）是一种强大的机制，它允许我们改变表的行为，尤其是在表上执行算术运算、比较、访问或更新不存在的字段时。
> 元表实际上是表的“元数据”，可以为表添加特殊的功能。

元表主要通过 **元方法（metamethods）** 来控制表的行为，这些元方法是特定名字的函数，当某些操作发生时（如加法、除法、索引访问等）会被 Lua 自动调用。

**设置元表**

- setmetatable(table, metatable): 对指定 table 设置元表（metatable）
> 如果元表（metatable）中存在 __metatable 键值，setmetatable 会失败。

- getmetatable(table): 返回对象的元素（metatable）


**元方法**


- __index元方法

通过键来访问 table 的时候，如果这个键没有值，那么Lua就会寻找该table的metatable(假设有metatable)中的__index键。 

1. 如果__index包含一个表格，Lua会在表格中查找相应的键；
2. 如果__index包含一个函数的话，Lua 就会调用那个函数，table和键会作为参数传递给函数。


- __newindex元方法

__newindex 元方法用来对表更新， __index 则用来对表访问。   
当你给表的一个缺少的索引赋值，解释器就会查找 __newindex 元方法；如果存在则调用这个函数而不进行赋值操作。


- 给表添加操作符

|模式|描述|
|----|----|
|__add|对应的运算符'+'|
|__sub|对应的运算符'-'|
|__mul|对应的运算符'*'|
|__div|对应的操作符'/'|
|__mod|对应运算符'%'|
|__concat|对应连接符'...'|
|__eq|对应'=='|
|__lt|对应'<'|
|__le|对应'<='|
|__unm|对应负号'-'|


- __call元方法

当你给一个表设置了 __call 元方法时，这个表名就可以像函数名一样被调用。每次你尝试使用 () 调用该表时，Lua 会触发 __call 元方法，并执行其中的逻辑。



- __tostring方法

__tostring 元方法用于修改表的输出(print)行为。





# 编程指南

## 循环

- while

```lua
while(condition)
do
   statements
end
```

- for
    - 数值for循环
    ```lua
    -- var 从 exp1 变化到 exp2，每次变化以exp3为步长递增var，并执行一次语句块。exp3可选，不指定则默认为1
    for var=exp1,exp2,exp3 do
        <语句块>
    end
    ```
    - 泛型for循环
    ```lua
    -- 泛型for循环通过一个迭代器函数来遍历所有的值，类似java中的foreach语句。
    a = {"one", "two", "three"}
    for i, v in ipairs(a) do
        print(i, v)
    end

    ```

- repeat...until

重复执行循环，直到 指定的条件为真时为止

```lua
repeat
    statements
until(condition)
```


> lua只存在break和goto循环控制语句


## 选择

```lua
if condition1 then
    -- 当 condition1 为 true 时执行
    action1
elseif condition2 then
    -- 当 condition1 为 false 且 condition2 为 true 时执行
    action2
else
    -- 当所有条件都不满足时执行
    action3
end
```


## lua函数

```lua
optional_function_scope function function_name( argument1, argument2, argument3..., argumentn)
    function_body
    return result_params_comma_separated
end
```

- optional_function_scope: 函数范围

可选的指定函数是全局函数还是局部函数，默认为全局的； 局部使用 local 修饰。

- result_params_comma_separated: 返回值

函数返回值，Lua语言函数可以返回多个值，用逗号隔开


- argument,argument1...: 函数参数列表
    -  Lua 函数支持可变参数。和C语言类似，在参数列表中使用三点符`...`作为可变参数的形参
        - select("#", ...): 可变参数的个数
        > 和`#{...}`同价
        - select(n, ...) : 返回从起点n开始到结束位置的所有参数列表。

> Lua 中可以将函数作为参数传递给函数

## lua运算符

- 算数运算符：+ - * / % ^ - //
    - ^: 幂运算
    - -: 负号
    - //: 整除
- 关系运算符：== ~= > < >= <=
- 逻辑运算符：and or not
- 其他运算符：.. #
    - ..: 连接两个字符串
    - #: 返回字符串或表的长度












# 高级编程



## 面向对象


> 冒号 : 是用来定义和调用方法的语法糖，简化了传递 self 参数的过程。
> 使得 current_object:function_name(...) = current_class.function_name(current_object,...)

**使用表来定义类和对象**

| 属性 | 存放位置 | 特点 |
| --- | --- | --- |
| 对象特有(实例)属性 | 存放在obj中 | 每个对象都有独立的属性，如name,age |
| 类的共享(类)属性 | 存放在类Person中 | 所有对象共享同一个属性，如species |

```lua
Person = {}  -- 定义类 Person
Person.species = "Homo sapiens" --类的共享属性(类属性)

-- 构造函数
function Person:new(name, age)
    local obj = {}  -- 创建一个新对象
    setmetatable(obj, self)  -- 将新对象的元表设为self(此时是Person类)
    self.__index = self  -- 确保查找不到属性或方法时，会从元表self(即Person中)中查找，实现继承
    obj.name = name  -- 为新对象赋值(实例属性)
    obj.age = age
    return obj  --每次调用new的时候就会返回一个新的obj对象
end

-- 实例方法: 依赖于特定的对象，这里是self，表示调用该方法的对象；用冒号:
function Person:sayHello()
    print("Hello, my name is " .. self.name .. " and I am " .. self.age .. " years old.")
end


-- 类方法: 不依赖与特定对象；用点号.
function Person.species()
    return "Homo sapiens"  -- 所有 Person 对象共享的属性
end
```


**创建对象**

```lua
local p1 = Person:new("Alice", 30)
p1:sayHello()  -- 输出: Hello, my name is Alice and I am 30 years old.
```


**实现继承**

```lua
Student = Person:new()  -- 继承自 Person

-- 重写构造函数
function Student:new(name, age, grade)
    local obj = Person.new(self, name, age)  -- 调用父类的构造函数
    obj.grade = grade   -- 添加grade属性
    return obj
end

-- 子类方法
function Student:getGrade()
    print(self.name .. " is in grade " .. self.grade)
end
```




## 错误处理

***错误类型***

- 语法错误
- 运行错误


***错误处理***

- assert

assert首先检查第一个参数，若没问题，assert不做任何事情；否则，assert以第二个参数作为错误信息抛出。

```lua
assert(para1,para2)
```

- error

终止正在执行的函数，并返回message的内容作为错误信息(error函数永远都不会返回)

```lua
error (message [, level])
--Level=0:不添加错误位置信息
--Level=1[默认]：为调用error位置(文件+行号)
--Level=2：指出哪个调用error的函数的函数
```

---

***pcall,xpcall***

pcall 可以用来执行一个函数并捕获可能发生的错误

```lua
success, result = pcall(function, arg1, arg2, ...)
```
- function：需要调用的函数。
- arg1, arg2, ...：传递给函数的参数。
- success：布尔值，表示函数是否成功执行。
- result：如果成功执行，返回函数的结果；如果失败，则返回错误信息



xpcall 是 pcall 的扩展版本，除了可以捕获错误，它还允许你指定一个错误处理函数，用来处理捕获到的错误。

```lua
success, result = xpcall(function, errorHandler)
```

- function：需要调用的函数。
- errorHandler：错误处理函数，在错误发生时调用。
- success：布尔值，表示函数是否成功执行。
- result：如果成功执行，返回函数的结果；如果失败，返回错误处理函数的结果



## 模块与包

***创建模块***

Lua模块是由变量、函数等已知元素组成的 table

- 就是创建一个table，然后把需要导出的常量、函数放入其中
- 返回这个 table 就行。



**导入模块**

```lua
require ("module_name")|"module_name"
```
执行 require 后会返回目标table，并且还会定义一个包含该 table 的全局变量，其名称就是module_name。
> 给加载的模块定义一个别名变量，如local m = require("module_name")


***搜索路径***

- require 用于搜索 Lua 文件的路径是存放在全局变量 package.path 中
- 当 Lua 启动后，会以环境变量 LUA_PATH 的值来初始这个环境变量。




## 迭代器

迭代器是一种对象，能够用来遍历标准模板库容器中的部分或全部元素，每个迭代器对象代表容器中的确定的地址。
> 在Lua中迭代器一种支持指针类型的结构，可以遍历集合的每一个元素。

***泛型for迭代器***

泛型 for 在自己内部保存迭代器，实际上它保存三个值
- 迭代函数: 每次调用时返回下一个值的函数
- 状态常量: 整个迭代过程中保持不变的值，通常用来存储需要在多次迭代中使用的共享数据
- 控制变量: 控制变量是每次迭代时会更新的值，用来追踪迭代的进度。 

泛型 for 迭代器提供了集合的 key/value 对， 语法格式如下

```lua
for k, v in ipairs({1,2,3}) do
    print(k, v)
end
```

> - 其中ipairs为迭代函数
> - {1,2,3}为状态常量，保存将遍历的目标数据
> - 索引k为控制变量，每次递增




***无状态的迭代器***

不会保存任何状态，仅根据当前的输入返回下一个值。

> 每一次迭代，迭代函数都是用两个变量（状态控制 和 控制变量）的值作为参数被调用，一个无状态的迭代器只利用这两个值可以获取下一个元素。


***有状态的迭代器***

通过闭包来保存每次调用时的状态。


<!-- NOTE: 有、无状态迭代器不是很懂 -->




## 协同

***什么是协同***

- 一种特殊的线程: 拥有独立的堆栈，独立的局部变量，独立的指令指针，同时又与其它协同程序共享全局变量和其它大部分东西。
- 可以暂停和恢复其执行，从而允许非抢占式的多任务处理。
- 任一指定时刻只有一个协同程序在运行，只有在明确的被要求挂起的时候才会被挂起。


***基本语法***

协同程序由`coroutine`模块提供支持。

| 方法 | 描述 |
| --- | --- |
| coroutine.create() | 创建并返回coroutine，参数是一个函数 |
| coroutine.resume() | 启动(重启挂起)一个coroutine |
| coroutine.yield() | 挂起coroutine |
| coroutine.status() | 查看 coroutine 的状态:dead\suspend\running |
| coroutine.running() | 返回正在跑的coroutine |
| coroutine.wrap() | 创建 coroutine，返回一个可直接被调用的函数 |

- coroutine.wrap() 和 coroutine.create() 的主要区别

coroutine.wrap() 返回的是一个函数，而不是协程对象。调用这个函数相当于调用 coroutine.resume()，不需要手动管理协程的状态。

- 传参

coroutine.yield(...)：可以从协程中返回值给主程序。
coroutine.resume(coroutine_name, ...)：启动或恢复指定协程coroutine_name，并传递参数	



## 文件I/O


```lua
-- 打开文件操作语句：
file = io.open(filename [,mode])
```

mode可取值

- r: 只读，文件必须存在
- w: 只写，文件不存在则创建，存在则覆盖
- a: 只写，文件不存在则创建，存在则追加到末尾
> r+,w+,a+: 添加可读写操作，其余一致
- b: 二进制模式


***简单模式***

使用内置的io库处理文件

> 常见函数：io.read()、io.write()、io.flush()、io.close()，以及常用的 io.stdin、io.stdout、io.stderr。



***完全模式***

使用文件句柄来进行文件操作。

> 我们需要使用 file:function_name 来代替 io.function_name 方法。




## 数据库访问


Lua 数据库的操作库：`LuaSQL`
> 支持的数据库有：ODBC, ADO, Oracle, MySQL, SQLite 和 PostgreSQL。
> LuaRocks是lua的包管理器，需提前使用它安装对应数据库的数据库驱动



# learn lua in Y minutes



```lua
----------------------------------------------------
-- 1. 变量和流程控制
----------------------------------------------------

num = 42  -- 所有的数字都是双精度浮点型。
-- 别害怕，64位的双精度浮点型数字中有52位用于
-- 保存精确的整型值; 对于52位以内的整型值，
-- 不用担心精度问题。

s = 'walternate'  -- 和Python一样，字符串不可变。
t = "也可以用双引号"
u = [[ 多行的字符串
       以两个方括号
       开始和结尾。]]
t = nil  -- 撤销t的定义; Lua 支持垃圾回收。

-- 块使用do/end之类的关键字标识：
while num < 50 do
  num = num + 1  -- 不支持 ++ 或 += 运算符。
end

-- If语句：
if num > 40 then
  print('over 40')
elseif s ~= 'walternate' then  -- ~= 表示不等于。
  -- 像Python一样，用 == 检查是否相等 ；字符串同样适用。
  io.write('not over 40\n')  -- 默认标准输出。
else
  -- 默认全局变量。
  thisIsGlobal = 5  -- 通常使用驼峰。

  -- 如何定义局部变量：
  local line = io.read()  -- 读取标准输入的下一行。

  -- ..操作符用于连接字符串：
  print('Winter is coming, ' .. line)
end

-- 未定义的变量返回nil。
-- 这不是错误：
foo = anUnknownVariable  -- 现在 foo = nil.

aBoolValue = false

--只有nil和false为假; 0和 ''均为真！
if not aBoolValue then print('false') end

-- 'or'和 'and'短路
-- 类似于C/js里的 a?b:c 操作符：
ans = aBoolValue and 'yes' or 'no'  --> 'no'

karlSum = 0
for i = 1, 100 do  -- 范围包含两端
  karlSum = karlSum + i
end

-- 使用 "100, 1, -1" 表示递减的范围：
fredSum = 0
for j = 100, 1, -1 do fredSum = fredSum + j end

-- 通常，范围表达式为begin, end[, step].

-- 循环的另一种结构：
repeat
  print('the way of the future')
  num = num - 1
until num == 0

----------------------------------------------------
-- 2. 函数。
----------------------------------------------------

function fib(n)
  if n < 2 then return n end
  return fib(n - 2) + fib(n - 1)
end

-- 支持闭包及匿名函数：
function adder(x)
  -- 调用adder时，会创建返回的函数，
  -- 并且会记住x的值：
  return function (y) return x + y end
end
a1 = adder(9)
a2 = adder(36)
print(a1(16))  --> 25
print(a2(64))  --> 100

-- 返回值、函数调用和赋值都可以
-- 使用长度不匹配的list。
-- 不匹配的接收方会被赋值nil；
-- 不匹配的发送方会被丢弃。

x, y, z = 1, 2, 3, 4
-- x = 1、y = 2、z = 3, 而 4 会被丢弃。

function bar(a, b, c)
  print(a, b, c)
  return 4, 8, 15, 16, 23, 42
end

x, y = bar('zaphod')  --> 打印 "zaphod  nil nil"
-- 现在 x = 4, y = 8, 而值15..42被丢弃。

-- 函数是一等公民，可以是局部的，也可以是全局的。
-- 以下表达式等价：
function f(x) return x * x end
f = function (x) return x * x end

-- 这些也是等价的：
local function g(x) return math.sin(x) end
local g; g = function (x) return math.sin(x) end
-- 以上均因'local g'，使得g可以自引用。
local g = function(x) return math.sin(x) end
-- 等价于 local function g(x)..., 但函数体中g不可自引用

-- 顺便提下，三角函数以弧度为单位。

-- 用一个字符串参数调用函数，可以省略括号：
print 'hello'  --可以工作。

-- 调用函数时，如果只有一个table参数，
-- 同样可以省略括号（table详情见下）：
print {} -- 一样可以工作。

----------------------------------------------------
-- 3. Table。
----------------------------------------------------

-- Table = Lua唯一的组合数据结构;
--         它们是关联数组。
-- 类似于PHP的数组或者js的对象，
-- 它们是哈希表或者字典，也可以当列表使用。

-- 按字典/map的方式使用Table：

-- Dict字面量默认使用字符串类型的key：
t = {key1 = 'value1', key2 = false}

-- 字符串key可以使用类似js的点标记：
print(t.key1)  -- 打印 'value1'.
t.newKey = {}  -- 添加新的键值对。
t.key2 = nil   -- 从table删除 key2。

-- 使用任何非nil的值作为key：
u = {['@!#'] = 'qbert', [{}] = 1729, [6.28] = 'tau'}
print(u[6.28])  -- 打印 "tau"

-- 数字和字符串的key按值匹配的
-- table按id匹配。
a = u['@!#']  -- 现在 a = 'qbert'.
b = u[{}]     -- 我们或许期待的是 1729,  但是得到的是nil:
-- b = nil ，因为没有找到。
-- 之所以没找到，是因为我们用的key与保存数据时用的不是同
-- 一个对象。
-- 所以字符串和数字是移植性更好的key。

-- 只需要一个table参数的函数调用不需要括号：
function h(x) print(x.key1) end
h{key1 = 'Sonmi~451'}  -- 打印'Sonmi~451'.

for key, val in pairs(u) do  -- 遍历Table
  print(key, val)
end

-- _G 是一个特殊的table，用于保存所有的全局变量
print(_G['_G'] == _G)  -- 打印'true'.

-- 按列表/数组的方式使用：

-- 列表字面量隐式添加整数键：
v = {'value1', 'value2', 1.21, 'gigawatts'}
for i = 1, #v do  -- #v 是列表的大小
  print(v[i])  -- 索引从 1 开始!! 太疯狂了！
end
-- 'list'并非真正的类型，v 其实是一个table，
-- 只不过它用连续的整数作为key，可以像list那样去使用。

----------------------------------------------------
-- 3.1 元表（metatable） 和元方法（metamethod）。
----------------------------------------------------

-- table的元表提供了一种机制，支持类似操作符重载的行为。
-- 稍后我们会看到元表如何支持类似js prototype的行为。

f1 = {a = 1, b = 2}  -- 表示一个分数 a/b.
f2 = {a = 2, b = 3}

-- 这会失败：
-- s = f1 + f2

metafraction = {}
function metafraction.__add(f1, f2)
  local sum = {}
  sum.b = f1.b * f2.b
  sum.a = f1.a * f2.b + f2.a * f1.b
  return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)

s = f1 + f2  -- 调用在f1的元表上的__add(f1, f2) 方法

-- f1, f2 没有关于元表的key，这点和js的prototype不一样。
-- 因此你必须用getmetatable(f1)获取元表。
-- 元表是一个普通的table，
-- 元表的key是普通的Lua中的key，例如__add。

-- 但是下面一行代码会失败，因为s没有元表：
-- t = s + s
-- 下面提供的与类相似的模式可以解决这个问题：

-- 元表的__index 可以重载用于查找的点操作符：
defaultFavs = {animal = 'gru', food = 'donuts'}
myFavs = {food = 'pizza'}
setmetatable(myFavs, {__index = defaultFavs})
eatenBy = myFavs.animal  -- 可以工作！感谢元表

-- 如果在table中直接查找key失败，会使用
-- 元表的__index 递归地重试。

-- __index的值也可以是function(tbl, key)
-- 这样可以支持自定义查找。

-- __index、__add等的值，被称为元方法。
-- 这里是一个table元方法的清单：

-- __add(a, b)                     for a + b
-- __sub(a, b)                     for a - b
-- __mul(a, b)                     for a * b
-- __div(a, b)                     for a / b
-- __mod(a, b)                     for a % b
-- __pow(a, b)                     for a ^ b
-- __unm(a)                        for -a
-- __concat(a, b)                  for a .. b
-- __len(a)                        for #a
-- __eq(a, b)                      for a == b
-- __lt(a, b)                      for a < b
-- __le(a, b)                      for a <= b
-- __index(a, b)  <fn or a table>  for a.b
-- __newindex(a, b, c)             for a.b = c
-- __call(a, ...)                  for a(...)

----------------------------------------------------
-- 3.2 与类相似的table和继承。
----------------------------------------------------

-- Lua没有内建的类；可以通过不同的方法，利用表和元表
-- 来实现类。

-- 下面是一个例子，解释在后面：

Dog = {}                                   -- 1.

function Dog:new()                         -- 2.
  local newObj = {sound = 'woof'}                -- 3.
  self.__index = self                      -- 4.
  return setmetatable(newObj, self)        -- 5.
end

function Dog:makeSound()                   -- 6.
  print('I say ' .. self.sound)
end

mrDog = Dog:new()                          -- 7.
mrDog:makeSound()  -- 'I say woof'         -- 8.

-- 1. Dog看上去像一个类；其实它是一个table。
-- 2. 函数tablename:fn(...) 等价于
--    函数tablename.fn(self, ...)
--    冒号（:）只是添加了self作为第一个参数。
--    阅读7 & 8条 了解self变量是如何得到其值的。
-- 3. newObj是类Dog的一个实例。
-- 4. self = 被继承的类。通常self = Dog，不过继承可以改变它。
--    如果把newObj的元表和__index都设置为self，
--    newObj就可以得到self的函数。
-- 5. 备忘：setmetatable返回其第一个参数。
-- 6. 冒号（：）的作用和第2条一样，不过这里
--    self是一个实例，而不是类
-- 7. 等价于Dog.new(Dog)，所以在new()中，self = Dog。
-- 8. 等价于mrDog.makeSound(mrDog); self = mrDog。

----------------------------------------------------

-- 继承的例子：

LoudDog = Dog:new()                           -- 1.

function LoudDog:makeSound()
  local s = self.sound .. ' '                       -- 2.
  print(s .. s .. s)
end

seymour = LoudDog:new()                       -- 3.
seymour:makeSound()  -- 'woof woof woof'      -- 4.

-- 1. LoudDog获得Dog的方法和变量列表。
-- 2. 因为new()的缘故，self拥有了一个'sound' key，参见第3条。
-- 3. 等价于LoudDog.new(LoudDog)，转换一下就是
--    Dog.new(LoudDog)，这是因为LoudDog没有'new' key，
--    但是它的元表中有 __index = Dog。
--    结果: seymour的元表是LoudDog，并且
--    LoudDog.__index = Dog。所以有seymour.key
--    = seymour.key, LoudDog.key, Dog.key
--    从其中第一个有指定key的table获取。
-- 4. 在LoudDog可以找到'makeSound'的key；
--    等价于LoudDog.makeSound(seymour)。

-- 如果有必要，子类也可以有new()，与基类相似：
function LoudDog:new()
  local newObj = {}
  -- 初始化newObj
  self.__index = self
  return setmetatable(newObj, self)
end

----------------------------------------------------
-- 4. 模块
----------------------------------------------------


--[[ 我把这部分给注释了，这样脚本剩下的部分可以运行

-- 假设文件mod.lua的内容类似这样：
local M = {}

local function sayMyName()
  print('Hrunkner')
end

function M.sayHello()
  print('Why hello there')
  sayMyName()
end

return M

-- 另一个文件可以使用mod.lua的功能：
local mod = require('mod')  -- 运行文件mod.lua.
-- 注意：require 需要配合 LUA_PATH 一起使用 例如：export LUA_PATH="$HOME/workspace/projectName/?.lua;;"

-- require是包含模块的标准做法。
-- require等价于:     (针对没有被缓存的情况；参见后面的内容)
local mod = (function ()
  <contents of mod.lua>
end)()
-- mod.lua被包在一个函数体中，因此mod.lua的局部变量
-- 对外不可见。

-- 下面的代码可以工作，因为在这里mod = mod.lua 中的 M：
mod.sayHello()  -- Says hello to Hrunkner.

-- 这是错误的；sayMyName只在mod.lua中存在：
mod.sayMyName()  -- 错误

-- require返回的值会被缓存，所以一个文件只会被运行一次，
-- 即使它被require了多次。

-- 假设mod2.lua包含代码"print('Hi!')"。
local a = require('mod2')  -- 打印Hi!
local b = require('mod2')  -- 不再打印; a=b.

-- dofile与require类似，但是不缓存：
dofile('mod2')  --> Hi!
dofile('mod2')  --> Hi! (再次运行，与require不同)

-- loadfile加载一个lua文件，但是并不运行它。
f = loadfile('mod2')  -- Calling f() runs mod2.lua.

-- loadstring是loadfile的字符串版本。
-- (loadstring已弃用, 使用load代替)
g = load('print(343)')  --返回一个函数。
g()  -- 打印343; 在此之前什么也不打印。

--]]
```
