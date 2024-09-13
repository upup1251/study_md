**javascript数据类型**
- 值类型（基本类型）：字符串string，数字number，布尔boolean，空null，未定义undefine,symbol
- 引用数据类型（对象类型）：对象object，数据array，函数funciton，正则regexp，日期date

> Symbol 是 ES6 引入了一种新的原始数据类型，表示独一无二的值。

**动态变量类型**

JavaScript 拥有动态类型。这意味着相同的变量可用作不同的类型：

> 可用 `typeof vriable`操作符来查看变量的数据类型


# 数据类型

##  字符串

- 可以使用单引号或双引号
- 可以使用索引位置来访问字符串中的每个字符
- 字符串可以是对象
```js
var x = "John";
var y = new String("John");
typeof x // 返回 String
typeof y // 返回 Object
```

- 对于字符串变量（不是对象），存在一些属性和方法用于操作字符串。

- 字符串模板
字符串模板使用反引号（\` \`）而不是常规的单引号（' '）或双引号（" "）。可以在字符串中嵌入变量或表达式，嵌入的部分使用 ${} 包裹。
```js
let name = "Jimmy";
let greeting = `Hello, ${name}!`;
console.log(greeting); // 输出: "Hello, Jimmy!"

let a = 10;
let b = 20;
let result = `The sum of a and b is ${a + b}.`;
console.log(result); // 输出: "The sum of a and b is 30."
```


## javascript数组

```js
//构造函数
var cars=new Array();
var cars=new Array("Saab","Volvo","BMW");

//字面量赋值
var cars=["Saab","Volvo","BMW"];
```


## javascript对象

对象由花括号分隔。在括号内部，对象的属性以名称和值对的形式 (name : value) 来定义，属性由逗号分隔

```js
//赋值
var person={firstname:"John", lastname:"Doe", id:5566};

//访问方式
name=person.lastname;
name=person["lastname"];
```





# 类型转换

- 通过使用javascript函数
- 通过javascript自身自动转换




# 运算符

- 算数运算符：= + - * / % ++ --
> `+`用于字符串相加时，他们会连接起来

- 赋值运算符：= += -= *= /= %=

- 比较和逻辑运算符：== === != > < >= <= && || !
> ===：绝对相等：值和类型均相等


# 程序控制语句

## 条件语句

- if语句

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
    break;
  case value2:
    // 如果 expression === value2，执行这段代码
    break;
  default:
    // 如果以上都不匹配，执行这段代码
}

```


## 循环语句

- for
```js
for (initialization; condition; increment) {
  // 循环执行的代码
}

```
- for...in   
循环遍历对象的属性
```js
for (variable in object) {
  // 每次迭代，variable 都会是对象中的一个属性名
  // 在循环体中可以使用 object[variable] 来获取属性值
}

```

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

 break 和 continue 正常使用，如需一次跳出多层循环，可使用标签
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


- try...catch
```js
try {
  // 可能会抛出错误的代码
} catch (error) {
  // 处理错误的代码
} finally {
  // 总会执行的代码（可选）
}

```
