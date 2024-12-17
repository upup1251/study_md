# javascript与浏览器

1. javascript在html中的使用


HTML中的javascript代码必须位于`<script>`和`</script>`标签之间

> javascript语句会在页面加载时执行

外部js文件中通过`<script src="myScript.js"></script>`引入


2. 输出

- `windows.alert()`：弹出警告框
- `document.write()`：将内容写到HTML文档中
- `innerHTML`：写入到HTML元素
- `console.log()`：写入到浏览器的控制台




# BOM浏览器对象


浏览器对象模型（Browser Object Model (BOM)） 使 JavaScript 有能力与浏览器"对话"

1. window对象

表示浏览器窗口。所有JavaScript全局对象、函数以及变量均自动成为 window 对象的成员。甚至HTML DOM的document也是window对象的属性之一。

```js
//DOM对象是BOM对象的属性
window.document.getElementById("header");

//相比之下的DOM对象
document.getElementById("header");
```

> 许多`window.xxx`对象在编写时可不使用window这个前缀。



2. 弹窗


```js
// 警告窗
window.alert("text")


// 确认窗
// 当你点击 "确认", 确认框返回 true， 如果点击 "取消", 确认框返回 false。
window.confirm("text")

// 提示框
// 如果用户点击确认，那么返回值为输入的值。如果用户点击取消，那么返回值为 null。
window.prompt("sometext","defaultvalue");
```
> 弹窗使用`\n` 来设置换行。


3. window location

window.location对象用于获得当前页面的地址 (URL)，并把浏览器重定向到新的页面。
```js
location.hostname   //返回 web 主机的域名
location.pathname   //返回当前页面的路径和文件名
location.port       //返回 web 主机的端口
location.protocol   //返回所使用的 web 协议
location.href       //返回当前页面的 URL

location.assign(url)    //加载新的文档/url
```
4. window history

```javascript
history.back()      //类似于浏览器点击后退按钮
history.forward()   //类似浏览器中点击向前按钮
```


5. window screen

```javascript
screen.availWidth   //可用的屏幕宽度
screen.availHerght  //可用的屏幕高度
```
---


**cookie**

Cookie 是一些数据, 存储于你电脑上的文本文件中。

当 web 服务器向浏览器发送 web 页面时，在连接关闭后，服务端不会记录用户的信息。

Cookie 的作用就是用于解决 "如何记录客户端的用户信息":

> 当浏览器从服务器上请求 web 页面时， 属于该页面的 cookie 会被添加到该请求中。服务端通过这种方式来获取用户的信息。


- 创建cookie
```js
document.cookie="key1=value1;key2=value2..."

```

> Cookie 以名/值对形式存储，如:username=dujiawen

- 读取Cookie
```js
var x = document.cookie;    //返回一个字符串
```

---


**window navigator**

包含有关访问者浏览器的信息。

> 来自 navigator 对象的信息具有误导性






# DOM文档对象模型


当网页被加载时，浏览器会创建页面的文档对象模型（Document Object Model）。HTML DOM 模型被构造为对象的树。

> DOM(Document Object Model)：HTML DOM 是一个接口，用于表示和操作 HTML 文档的结构。`document.xxx`中的document就是其中的D


## 查找HTML元素


```js
// 以下代码选取了文档中所有的 <p> 节点：
var myNodeList = document.querySelectorAll("p");
```

> HTMLCollection 元素可以通过 name，id 或索引来获取。  
> NodeList 只能通过索引来获取。



```js
// 通过id
// 如果找到该元素，则该方法将以对象的形式返回该元素。
// 如果未找到该元素，则返回null。
var x=document.getElementById("id");

// 标签名
// 本例查找 id="main" 的元素，然后查找 id="main" 元素中的所有 <p> 元素
// 集合中的元素可以通过索引(以 0 为起始位置)来访问
var y=getElementsByTagName("p");


// 类名
// 来查找 class="intro" 的元素
var x=document.getElementsByClassName("intro");

```



## 改变DOM元素

```js
// 改变html内容
document.getElementById(id).innerHTML=新的元素内容

// 改变html属性
document.getElementById(id).属性名=新属性值

// 改变CSS 
document.getElementById(id).style.property=新样式
```


## 添加DOM元素

- appendChild：添加新元素到末尾
- insertBeofre：插入新元素到开头

```js
//创建 <p> 元素
var para = document.createElement("p");

//创建一个新的文本节点
var node = document.createTextNode("这是一个新的段落。");

//文本节点添加到 <p> 元素中
para.appendChild(node);

//在一个已存在的元素中添加 p 元素
document.getElementById("div1").appendChild(para);
```


## 删除和替换DOM元素

删除和替换DOM元素都需要先获取目标元素和其父元素

```js
// 获取父元素和目标元素(child)
var parent = document.getElementById("div1");
var child = document.getElementById("p1");


// 删除元素
parent.removeChild(child);
// 通过子元素，查找父元素后再删除
child.parentNode.removeChild(child);



// 替换元素
parent.replaceChild(new_chile, old_child);
```



## 添加事物


javascript事件：html事件是发生在html元素上的事情，可使用javascript处理这些事件

1. 使用事件属性

事件属性所对应的值是一个函数

```javascript
element.onclick=function(){
    ...
};
```


2. 使用事物监听函数

事件监听函数`addEventListener()`方法添加的事件句柄不会覆盖已存在的事件句柄
```js
// 添加事件监听
element.addEventListener(event, function, useCapture);
// event:事件类型（如click）
// 事件触发后调用的函数
// 布尔值，选择描述事件是冒泡还是捕获，默认为false，冒泡

// 删除事物监听
element.removeEventListener("mousemove", myFunction);
```


3. 事件传递属性

如果你将 \<p> 元素插入到 \<div> 元素中，用户点击 \<p> 元素, 哪个元素的 "click" 事件先被触发呢？    

冒泡和捕获定义了元素事件触发的顺序  
- 冒泡：内部元素的事件会先被触发，然后再触发外部元素
- 捕获：外部元素的事件会先被触发，然后才会触发内部元素的事件


