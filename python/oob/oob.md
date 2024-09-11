- 类的创建
类定义了对象的属性和行为。属性是类的变量，行为是类的方法（函数）。可以使用 class 关键字定义一个类。
```python
# 类的声明
class ClassName:
    def __init__(self, parameters):     # 构造方法
        # 初始化属性
        self.attribute1 = value1
        self.attribute2 = value2
        # 其他初始化代码

    def method_name(self, parameters):
        # 方法体
        return value

# 对象的创建
object = class(param...)    # 调用构造方法


```
> 注意self必须有

- 魔法方法
Python 类可以定义特殊方法（魔法方法），这些方法以双下划线开头和结尾。它们用于实现特定的操作，如对象的表示、比较、运算等。
```python
__init__()      构造函数
__str__()       替换print（对象）时输出的内存地址，而是输出return的返回值(常为解释说明的文字)
__del__()       析构函数
```

- 继承
类可以继承其他类，这样子类（派生类）可以重用或扩展父类（基类）的属性和方法。
```python
class ChildClass(ParentClass1,ParentClass2)
     def __init__(self, name, age, employee_id):
        super().__init__(name, age)  # 调用父类的构造函数
        self.employee_id = employee_id
```
> 一个类有多个父类时，默认使用第一个父类的 同名 属性和方法




- 访问权限
    - public：无下划线前缀
    - proctect：单根下划线前缀`_`
    - private：双根下划线前缀`__`


- 多态
    - 鸭子类型：通过对象是否实现了某些方法来决定是否可以进行操作，不需要显式声明类型
    - 方法重写：子类重写父类的方法，实现不同的行为。
    - 接口(抽象方法)和抽象类：定义抽象基类，强制子类实现特定的方法，确保一致的接口。
    > python无需进行类型声明，可将任一类型的数据赋值给一个新声明的变量或者形参，从而调用不同类型对象的方法实现多态

- 类属性和类方法
    - 类属性：类属性在类体内直接定义，不在任何方法内。
    > 实例属性一般定义在__self__方法内
    - 类方法：:修饰器@staticmethod
    > 不能直接访问类属性，因为它们不接收 cls 或 self 参数。




