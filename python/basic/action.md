# 输出

print()


- 格式化输出
    - `百分号 (%) 格式化`：print("Name: %s, Age: %d" % (name, age))
    - `str.format`：print("Name: {}, Age: {}".format(name, age))
    - `f-string`：print(f"Name: {name}, Age: {age}")

> 转义字符：`\+字母`  
> 结束字符：print('内容' , end='pass')pass可以是/n，/t，自定义等       默认为end='/n'换行


# 输入

```python
variable = input('提示信息')

```

> 注意，输入内容都会当作`str`字符串处理，我们需要进行类型转换:`目标类型名(变量名)`

# 程序控制

## 选择

- if

```python
if condition1:
    # Code to execute if condition1 is true
elif condition2:
    # Code to execute if condition1 is false and condition2 is true
else:
    # Code to execute if both condition1 and condition2 are false

```
> 三目运算符：value_if_true if condition else value_if_false

- match

```python
match some_value:
    case 0:                     # 匹配常量
        pass
    case (x, y):                # 匹配数据结构
        pass
    case int():                 # 匹配类型
        pass
    case n if n < 0:            # 带条件的匹配
        pass
    case _:                     # 默认情况下执行（相当于 switch 语句中的 "default"）
        pass
```
> 不同于c,只有第一个匹配的模式会被执行



## 循环

```python
# 1. for循环
for item in iterable:
    # Code to execute for each item

# 2. while循环
while condition:
    # Code to execute as long as condition is true

# 3. break 和 continue 和 else
在 for 循环中，else 子句会在循环成功结束最后一次迭代之后执行。
在 while 循环中，它会在循环条件变为假值后执行。
无论哪种循环，如果因为 break 而结束，那么 else 子句就 不会 执行。

```
- range()：生成等差数列，可用于循环
> 该对象只有在被迭代时才一个一个地返回所期望的列表项，并没有真正生成过一个含有全部项的列表，从而节省了空间。



# 公共操作
```python
运算符：+ ：作用：合并
            用法：序列1 + 序列2
            支持：字符串，列表，元组
        *： 作用：复制多份
            用法：序列名 * 数字
            支持：字符串，列表，元组
        in/not in：作用：判断是否存在
             用法：print(查找的数据 in 序列名)
            支持：字符串，列表，元组，字典
        =：a,b=b,a  # 交换变量值
        id(variable)：返回variable地址

函数：len(): 作用：统计数据个数
            用法：print(len(序列名))
      del(): 作用：删除
            用法：del 目标 /del(目标)
      max/min(): 作用：返回最大值或最小值
            用法：print(max(序列名))
      range(): 作用：生成从start到end的数字，步长为step
            用法：range(start,end,step)
            注：不包含end   
                与for循环配套
                可以只写end，其余可省略默认
      enumerate()：作用：将一个可遍历的数据组合成索引序列，返回下标和值，即元组
            用法：enumerate(可遍历的对象，start=0)
                注：与for循环配套
                    start指第一个下标的起始值

```

- pass 
 语句不执行任何动作。语法上需要一个语句，但程序毋需执行任何动作时，可以使用该语句。



# 推导式
推导式（comprehensions）是一种简洁的方式来创建列表、集合、字典等数据结构。
```python

# 有无条件的列表/集合推导式
[/{expression for item in iterable]/}
[/{expression for item in iterable if condition]/}

# 有无条件的字典推导式
{key_expression: value_expression for item in iterable}
{key_expression: value_expression for item in iterable if condition}

# 生成器(迭代器)推导式
(expression for item in iterable)
(expression for item in iterable if condition)
```



# 拆包
拆包（unpacking）是将一个可迭代对象（如列表、元组、字典）中的元素分配到多个变量中的过程。
```python
# 元组、列表拆包
point = [/(10, 20]/)    # 定义一个元组
x, y = point        # 拆包元组
print(x)  # 输出: 10
print(y)  # 输出: 20


# 字典拆包
data = {"name": "Alice", "age": 30, "profession": "Engineer"}       # 定义一个字典
for key, value in data.items():     # 拆包字典的键值对
    print(f"{key}: {value}")
# 输出:
# name: Alice
# age: 30
# profession: Engineer


# 函数返回值拆包
def get_user_info():
    return "Alice", 30, "Engineer"
name, age, profession = get_user_info()
print(name)        # 输出: Alice
print(age)         # 输出: 30
print(profession)  # 输出: Engineer


# 拆包用于循环
pairs = [(1, 'a'), (2, 'b'), (3, 'c')]      # 列表包含多个元组
for number, letter in pairs:                # 在循环中拆包
    print(number, letter)
# 输出:
# 1 a
# 2 b
# 3 c


# 扩展拆包
a, *b, c = (1, 2, 3, 4, 5)
print(a)  # 输出: 1
print(b)  # 输出: [2, 3, 4]
print(c)  # 输出: 5
```



# 函数
```python
def function_name(parameters):
    """
    # 注释
    """

    # 函数体
    return value


```

> 函数定义在当前符号表中把函数名与函数对象关联在一起。解释器把函数名指向的对象作为用户自定义函数。还可以使用其他名称指向同一个函数对象


# 参数形式
定长参数：
    位置参数:函数调用时根据函数定义的参数 位置 来传递参数
    默认参数:一些参数带有默认值
    关键字参数:函数调用时通过'键=值'形式加以指定
不定长参数:
    位置参数：def function_name(*args):         # *args：用于接收任意数量的位置参数，并将其作为一个元组传递给函数。
    关键字参数：def function_name(**kwargs):    # **kwargs：用于接收任意数量的关键字参数，并将其作为一个字典传递给函数。


> 在函数体内修改变量：直接修改重新赋值：属于局部变量  
> global 变量名 '\n' 重新赋值：属于全局变量

- lambda表达式  
Lambda 表达式是 Python 中用于创建匿名函数的一种方式。它们可以用于定义简单的函数，而不需要使用 def 关键字。
```python
lambda arguments: expression
# lambda：关键字，用于定义 Lambda 表达式。
# arguments：函数的参数列表，可以是一个或多个参数。
# expression：一个表达式，该表达式的结果就是 Lambda 表达式的返回值。
```


-  高阶函数  
高级函数（高级函数）通常指的是可以接受函数作为参数或返回函数的函数。
```python
map()：     将函数应用于可迭代对象中的每个元素，并返回一个迭代器。
filter()：  根据函数的返回值过滤可迭代对象中的元素。
# even_numbers = filter(lambda x: x % 2 == 0, numbers)
reduce()：  将函数累积应用于可迭代对象中的元素，最终返回一个值（需要 functools 模块）。
```


# 异常捕获

- 格式
```python
try:
    # 可能引发异常的代码
    pass
except ExceptionType1 as e1:
    # 处理 ExceptionType1 异常
    pass
except ExceptionType2 as e2:
    # 处理 ExceptionType2 异常
    pass
else:
    # 如果没有异常发生，执行这部分代码
    pass
finally:
    # 无论是否发生异常，都会执行这部分代码
    pass

```
> 可捕获的异常：
> - 特地异常：except ZeroDivisionError as e:
> - 多个异常：except (ValueError, TypeError) as e:
> - 所有异常：except Exception as e:  # 捕获所有异常 

- 自定义异常
    - 创建自己的异常类，通常通过继承内置的 Exception 类。
    - 重新__str__方法，print打印错误提示信息



# 迭代器
定义 __iter__() 方法用于返回一个带有 __next__() 方法的对象。 如果类已定义了 __next__()，那么 __iter__() 可以简单地返回 self，随后可调用itre(variable)方法获得一个迭代器对象，在对其迭代过程中，会多次调用__next__（），知道运行至raise StopIteration语句

- 生成器
生成器的写法类似于标准函数，但当它们要返回数据时会使用 yield 语句。
```python
def reverse(data):
    for index in range(len(data)-1, -1, -1):
        yield data[index]


>>> for char in reverse('golf'):
...     print(char)
...
f
l
o
g
```
