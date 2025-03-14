
[toc]


# 函数定义


编程语言中的第一类值 (First-Class Values)  
在编程语言中，第一类值指的是可以作为参数传递、作为返回值返回或赋值给变量的实体。


1. 函数声明

```js
function functionName(parameters) {
  执行的代码
}
```


2. 函数表达式

可通过`myFunction()`调用下列函数表达式
> javascript中函数是第一类值

```javascript
//匿名函数表达式
const myFunction = function(){...}

// 命名函数表达式
const myFunction = function myName(){...}
// 名称myName只能在函数内部使用（递归)，外部不能通过该名称调用函数。

// 立即执行函数表达式(IIFE)
(function(){...})()
// 函数表达式还可以立即执行
```


> 函数提升适用于函数声明，不适用与函数表达式



# 函数参数

1. arguments对象

函数的实际参数会被保存在一个类似数组的 arguments 对象中。

2. 特殊参数

- 默认参数：函数声明时在参数列表对目标参数显式的赋值
```javascript
function myFunction(param0,param1 = 'defaultValue') {
    ...
}
```

- 剩余参数：将不确定数量的参数表示为数组

```javascript
function myFunction(param0,...restParams) {
    console.log(restParams); // restParams 是一个数组
}

```





# 嵌套函数和闭包


1. 函数作用域

- 函数内定义的变量不能在函数之外的任何地方访问，因为变量仅仅在该函数的作用域内定义。
- 一个函数可以访问定义在其范围内的任何变量和函数。

2. 嵌套函数的关系

- 可以在一个函数里面嵌套另外一个函数，内部函数只可以在外部函数中访问
- 内部函数形成了一个闭包：它可以访问外部函数的参数和变量，但是外部函数却不能使用它的参数和变量。

3. 闭包保存变量

**闭包是指`函数与其词法环境的组合`。**  
换句话说，当一个函数能够记住并访问它所在的词法作用域（定义时的作用域），即使在这个函数被外部调用时，它仍然可以访问该作用域的变量，这种现象就是闭包。

```js
function outside(x) {
  function inside(y) {
    return x + y;
  }
  return inside;        //这里将内部函数名（指向内部函数体的变量）返回
}

const fnInside = outside(3); // 可以这样想：给我一个可以将提供的值加上 3 的函数
console.log(fnInside(5)); // 8  ，在外部调用outside函数的内部函数
console.log(outside(3)(5)); // 8
```



4. 闭包的使用


- 实用的闭包

闭包很有用，因为它允许将函数与其所操作的某些数据（环境）关联起来。这显然类似于面向对象编程。

>  通常你使用只有一个方法的对象的地方，都可以使用闭包。

- 模拟私有方法

```javascript
function Counter() {
  // 私有变量
  let count = 0;

  // 私有方法
  function increment() {
    count++;
  }

  // 公开的方法
  return {
    // 公开的接口可以通过闭包访问私有变量和方法
    getCount: function() {
      return count;
    },
    increase: function() {
      increment();
    }
  };
}

const counter = Counter();
console.log(counter.getCount()); // 输出 0
counter.increase();
console.log(counter.getCount()); // 输出 1
```




# 箭头函数



```js
const func = (param1, param2) => {
    // 函数体
};
```

- 不需要function关键字
- 如果只有一个参数，可以省略括号
- 如果只有一个return表达式，可以省略大括号和return
- 没有自己的this: 它的this值会继承自定义箭头函数时所在的作用域，称为词法作用域（lexical this）。


