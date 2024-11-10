# 表达式和运算符

## 运算符

- 算数运算符：= + - * / % ++ -- **
> `+`用于字符串相加时，他们会连接起来

- 赋值运算符：= += -= *= /= %= **=

- 比较和逻辑运算符：== === != > < >= <= && || !
> ===：绝对相等：值和类型均相等

- 逻辑运算符：&& || !

- delete运算符：删除一个对象的属性或者一个数组中某一个键值。

- typeof运算符：返回操作对象的类型

- void：表明一个运算'void (expression);'没有返回值

- 关系运算符：
    - in：所指定的属性确实存在于所指定的对象中，则会返回true
    - instanceof: 所判别的对象确实是所指定的类型，则返回true。

- 位运算符


## 表达式

表达式是一组代码的集合，它返回一个值。

- 基本表达式
    - `this`: 被用于指代当前的对象

- 左值表达式
    - `new`: 创建一个自定义类型或者是预置类型的对象实例
    - `super`: 调用一个对象父类的函数


# 程序控制语句

## 条件语句

- if语句

**为false的值**: false,undefined,null,0,NaN,''

```js
if (condition1) {
  // 如果 condition1 为 true，执行这段代码
} else if (condition2) {
  // 如果 condition1 为 false 且 condition2 为 true，执行这段代码
} else {
  // 如果以上条件都为 false，执行这段代码
}

```
- 三元运算符
```js
result = condition ? valueIfTrue : valueIfFalse;
```

- switch语句
```js
switch (expression) {
  case value1:
    // 如果 expression === value1，执行这段代码
    break;  //如果没有break，则会一直往下面执行
  case value2:
    // 如果 expression === value2，执行这段代码
    break;
  default:
    // 如果以上都不匹配，执行这段代码
}
```



### 判断相等

javascript提供三种不同的值比较运算
- `==`: 宽松相等
    - 会自动执行类型转换
    - 对 NaN、-0 和 +0 进行特殊处理（故 NaN != NaN，且 -0 == +0）；
- `===`: 严格相等
    - 不进行类型转换
    - 对 NaN、-0 和 +0 进行特殊处理（故 NaN != NaN，且 -0 == +0）；
- `object.is()`: 
    - 不进行类型转换
    - 不对 NaN、-0 和 +0 进行特殊处理（故 NaN == NaN，且 -0 =! +0）；


## 循环语句

- for
```js
for (initialization; condition; increment) {
  // 循环执行的代码
}

```
- for...in   

遍历对象的可枚举属性的键（包括数组的索引）。

```js
for (variable in object) {
  // 每次迭代，variable 都会是对象中的一个属性名
  // 在循环体中可以使用 object[variable] 来获取属性值
}

```

- for...of

遍历可迭代对象的元素值（如数组、字符串、Map、Set等）。

- while
```js
while (condition) {
  // 当 condition 为 true 时执行
}

```
- do...while
```js
do {
  // 先执行一次代码
} while (condition);

```


 - break contine label

 break 和 continue 正常使用，如需一次跳出多层循环，可使用标签，如break[label]和continue[label]
 ```js
labelName: statement
// statement可以是`{}`代码块
// 代码中可以用break labelName之间跳出当前代码块，不需要是循环
// continue labelName在外层继续下次循环
```


## 异常处理语句

- throw
```js
//1. 抛出字符串、数字或其他值
throw "Something went wrong!";  // 抛出字符串
throw 42;                       // 抛出数字
throw { error: "Invalid input" } // 抛出对象


// 抛出Error对象
throw new Error("error message");
```
> error对象：'name'属性提供了常规的错误类，而'message'属性通常提供了上式的"error message"。

- try...catch
```js
try {
  // 可能会抛出错误的代码
} catch (error) {           //指定了一个标识符（error变量）来存放抛出语句指定的值
  // 处理错误的代码
} finally {
  // 总会执行的代码（可选）
}

```




# javascript模块

复杂的项目需要一种将 JavaScript 程序拆分为可按需导入的单独模块的机制。


**导出模块的功能**

使用`export`进行导出

```javascript
export {function_name,value_name,class_name}
```
> 能够导出函数，var，let，const,变量和类。
> export 要放在最外层；比如你不能够在函数内使用 export。


**导入模块**

使用`import`语句，然后你被花括号包围的用逗号分隔的你想导入的功能列表，然后是关键字 from，然后是模块文件的相对路径。

```javascript
iport {value1,value2...} from module_path
```





