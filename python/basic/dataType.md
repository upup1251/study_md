# 运算符

```python
# 算数运算符
//  整除
%   取余
**  指数
/   除
*   乘

# 赋值运算符
# 单变量赋值
variable = value
# 一一对应关系
variable1 variable2 ... = value1 value2 ...

# 复合赋值运算符
+=  -=  /=  //= %=  **=

# 比较运算符
== != > < >= <=

# 逻辑运算符
and  or  not

# 数字运算符
and or
# and有0则为0，否则为最后一个非0数字
# or有0则为0，否则为第一个非0数字
```


# 数据类型

| 符号 | 含义 |
| --- | --- |
| int | 整数型 |
| float | 浮点型 |
| bool | 布尔类型 |
| str | 字符串 |
| list | 列表 |
| tuple | 元组 |
| set | 集合 |
| dict | 字典 |

> 任何对象都拥有bool值，False包括FALSE，None，0，空字符串，空集合，空列表，空元组，空字典。其余全为ture


## 字符串
```python
variable = 'value'
```
> '和"不进行区分

- 下标
    - python中的字符串类似于数组，可用`下标`访问  
    - `切片`：sequence[start:stop:step]
    > 负索引： 可以使用负索引，从序列末尾向前数。

- 字符串可用的操作

```python
# 查找
find:       检测某个子串是否包含在这个字符串中，有则返回子串开始下标，否则返回-1
index:      检测某个子串是否包含在这个字符中，有则返回子串开始下标，否则报错
count:      检测出现的次数

# 修改
replace:    新字符串序列 = 字符串序列.replace('旧子串'，'新子串'，替换次数)
split:      list = 字符串序列.split（分割字符，num）
join:       字符或子串.join（多字符组成的序列）

# 判断
startwith   字符串序列.startswith(字串，开始位置下标，结束位置下标)
endswith
isdigit
isalpha
...
```


## 列表
```python
# 列表像可用数组访问的结构体
变量名 = ['str-数据1'，int-数据2，float-数据3.......]


# 查
print()     print(变量名[下标])
index()     列表序列.index（数据，开始位置下标，结束位置下标）
count()     查询列表中数据出现次数
len()       查询列表中数据个数


# 判
in/not in   判断是不是在列表中，可与if语句结合


# 增
append()    列表尾端增加数据，追加的数据将原封不动的加入原列表
extend()    列表末尾增加数据，增加的数据将按顺序拆开到原列表
insert()    将数据插入自己想要的任意位置


# 删
del()       del()或者del pass --可删除列表
            del 序列名[下标]--删除指定下标的数据
pop()       删除指定下标的数据，若不写下标，则删最后一个数据
remove()    删除指定数据，如有多个删除项，只删除第一个
clear()     清空列表数据，保留空列表    


# 改
reverse()   将列表内数据顺序颠倒    
sort()      排序


#复制
copy()

```
> 列表嵌套：类似于多维数组

## 元组
```python
# 存储无法改变的多个数据，不可变类型
variable = (value1,value2...)
> variable = (value1,)  # 如果只有一个元素，那么需要加,号


# 查
print()
index()


# 计数
count()
lend()


# 修改
tuple = (1,2,[a,b,c])
tuple[2][1] = d
# 只能修改内嵌数据
```


## 字典
```python
# 通过键值对进行存储
variable = {key1 = value1,key2 = value2...}


# 增改
value[key] = value


# 删
del(variable)/del variable  删除字典
del variable[key]           删除键值对
variable.clear()            清空字典


# 查
print(variable[key])        输出对应value
variable.get(key,默认值)    返回对应value，否则默认值
keys()                      返回所有key值
values()                    返回所有value值
items()                     返回所有键值对



# 遍历
for key in my_dict:
for value in my_dict.values():
for key, value in my_dict.items():

```


## 集合
```python
# 没有下标，无顺序，无重复数据
variable = {value1,value2...}
variable = set()        # 空集合


# 增加
variable.add(value)     只能添加单一数据，不可添加序列
variable.update(value)   添加序列，列表，不能添加单一数据


# 删
remove()    删除指定数据，数据不存在则报错
discard()   删除指定数据，不存在不会报错
pop()       随机删除某个数据，并返回这个数据
```
> 添加序列：list = set（'asdfg'）     #{'a','s','d','f','g'}




