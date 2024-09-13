**javascript的使用**

HTML中的javascript代码必须位于`<script>`和`</script>`标签之间


> javascript语句会在页面加载时执行，我们可以通过把javascript代码放入函数中控制调用的时机

javascript函数可以放在\<head>，\<body>，外部js文件中通过`<script src="myScript.js"></script>`引入

---

**输出**

- windows.alert()：弹出警告框
- document.write()：将内容写到HTML文档中
- innerHTML：写入到HTML元素
- console.log()：写入到浏览器的控制台

---

**语句**

javascript语句用于向浏览器分出命令，使用`;`进行分隔

> 在 JavaScript 中，用分号来结束语句是可选的。

---

**注释**

```
// pass

/*
pass
*/
```

---

**变量**

使用关键字`var`来定义变量，使用等号来为变量赋值

> 未赋值的变量，其值是 undefined。

- let：let 声明的变量只在 let 命令所在的代码块内有效。
- const：const 声明一个只读的常量，一旦声明，常量的值就不能改变。


```js
var var1 = 1; // 不可配置全局属性
var2 = 2; // 没有使用 var 声明，可配置全局属性

// 在函数外声明的变量是全局变量，全局变量都属于window对象
console.log(window.var1); // 1
console.log(window.vari2); //2 

delete var1; // false 无法删除
delete var2; //true 可删除
```

---

**json字符串转换为javascript对象**
```js
var obj = JSON.parse(text.json);
```



todo:constructor
