**函数代码格式**
```js
function functionName(parameters) {
  执行的代码
}
```
---

**arguments对象**

arguments对象包含了函数调用的参数数组。    

--- 

**函数是对象**

JavaScript函数有属性和方法。

```js
function myFunction(a, b) {
    return arguments.length;    //arguments.length 属性返回函数调用过程接收到的参数个数
}

var txt = myFunction.toString();    //toString() 方法将函数作为一个字符串返回
```

> 函数名只是一个指针，可以用`=`进行赋值


---

**函数自我调用**

在定义函数的同时立即执行它。

```js
(function() {
  // 函数体
})();
```

---

**function()构造函数**

```js
//以下两者相等
var myFunction = new Function("a", "b", "return a * b");
var x = myFunction(4, 3);

var myFunction = function (a, b) {return a * b};
var x = myFunction(4, 3);
```
---


**箭头函数**

```js
(参数1, 参数2, …, 参数N) => { 函数声明 }

const x = (x, y) => x * y;
```

---

**闭包**

闭包是指一个函数可以记住并访问它所在的词法作用域

```js
var add = (function () {
    var counter = 0;
    return function () {return counter += 1;}
})();
 
add();
add();
add();
// 计数器为 3
```



**异步编程**

- 异步

同步按你的代码顺序执行，异步不按照代码顺序执行，异步的执行效率更高。

- 回调函数

回调函数就是一个函数，它是在我们启动一个异步任务的时候就告诉它：等你完成了这个任务之后要干什么。，调用相对应的回调函数，这样一来主线程几乎不用关心异步任务的状态了，他自己会善始善终。



**计时函数**

- setInterval() ： 间隔指定的毫秒数不停地执行指定的代码。
- setTimeout() ： 在指定的毫秒数后执行指定代码。

