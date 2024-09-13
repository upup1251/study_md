浏览器对象模型（Browser Object Model (BOM)） 使 JavaScript 有能力与浏览器"对话"

**window对象**

所有浏览器都支持 window 对象。它表示浏览器窗口。所有 JavaScript 全局对象、函数以及变量均自动成为 window 对象的成员。甚至 HTML DOM 的 document 也是 window 对象的属性之一。

```js
//DOM对象是BOM对象的属性
window.document.getElementById("header");

//相比之下的DOM对象
document.getElementById("header");
```

> 许多`window.xxx`对象在编写时可不使用window这个前缀。

---


**弹窗**

- 警告窗

```js
window.alert("text")
```

- 确认窗

当你点击 "确认", 确认框返回 true， 如果点击 "取消", 确认框返回 false。

```js
window.confirm("text")
```

- 提示框

如果用户点击确认，那么返回值为输入的值。如果用户点击取消，那么返回值为 null。

```js
window.prompt("sometext","defaultvalue");
```

> 弹窗使用`\n` 来设置换行。

---

**window location**

window.location 对象用于获得当前页面的地址 (URL)，并把浏览器重定向到新的页面。

```js
location.hostname   //返回 web 主机的域名
location.pathname   //返回当前页面的路径和文件名
location.port       //返回 web 主机的端口
location.protocol   //返回所使用的 web 协议
location.href       //返回当前页面的 URL

location.assign(url)    //加载新的文档/url
```
---

**window history**
```
history.back()      //类似于浏览器点击后退按钮
history.forward()   //类似浏览器中点击向前按钮
```
---


**window screen属性**

```js
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


