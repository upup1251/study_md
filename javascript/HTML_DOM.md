**HTML DOM(文档对象模型)**

当网页被加载时，浏览器会创建页面的文档对象模型（Document Object Model）。HTML DOM 模型被构造为对象的树。

> DOM(Document Object Model)：HTML DOM 是一个接口，用于表示和操作 HTML 文档的结构。`document.xxx`中的document就是其中的D

---

**查找HTML元素**

- id
```js
var x=document.getElementById("intro");
// 如果找到该元素，则该方法将以对象（在 x 中）的形式返回该元素。
// 如果未找到该元素，则 x 将包含 null。
```
- 标签名
```js
// 本例查找 id="main" 的元素，然后查找 id="main" 元素中的所有 <p> 元素
var x=document.getElementById("main");
var y=x.getElementsByTagName("p");

```
- 类名
```js
// 来查找 class="intro" 的元素
var x=document.getElementsByClassName("intro");
```

**改变html**

- 改变html内容
```js
document.getElementById(id).innerHTML=新的 HTML
```
- 改变html属性
```js
document.getElementById(id).属性名=新属性值
```
- 改变CSS 
```js
document.getElementById(id).style.property=新样式
```
---

**事物属性**
```js
// 向 button 元素分配 onclick 事件，onclick称为事物属性
<button onclick="displayDate()">点这里</button>
```
- 使用HTML DOM来分配事物属性
```js
// 可在script中分配事物属性
<script>
document.getElementById("myBtn").onclick=function(){displayDate()};
</script>
```

> javascript事件：html事件是发生在html元素上的事情，在html页面中使用javascript时，javascript可以处理这些事件


**EventListener**

- 增加事物监听

```js
element.addEventListener(event, function, useCapture);
// event:事件类型（如click）
// 事件触发后调用的函数
// 布尔值，选择描述事件是冒泡还是捕获，默认为false，冒泡

// addEventListener() 方法添加的事件句柄不会覆盖已存在的事件句柄。
```
> 如果你将 \<p> 元素插入到 \<div> 元素中，用户点击 \<p> 元素, 哪个元素的 "click" 事件先被触发呢？  
> 冒泡和捕获定义了元素事件触发的顺序  
> - 冒泡：内部元素的事件会先被触发，然后再触发外部元素
> - 捕获：外部元素的事件会先被触发，然后才会触发内部元素的事件


- 删除事物监听

```js
element.removeEventListener("mousemove", myFunction);
```
---



**DOM元素**

- 创建HTML元素(节点)
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

- 移除已存在的元素

要移除一个元素，你需要知道该元素的父元素。

```js
<script>
var parent = document.getElementById("div1");
var child = document.getElementById("p1");
parent.removeChild(child);
</script>


// 通过子元素，查找父元素后再删除
var child = document.getElementById("p1");
child.parentNode.removeChild(child);
```

- 替换HTML元素

```js
parent.replaceChild(new_chile, old_child);
```


**DOM集合**

```js
// 以下代码获取文档所有的 <p> 元素，集合中的元素可以通过索引(以 0 为起始位置)来访问。
var x = document.getElementsByTagName("p");
```

> HTMLCollection 看起来可能是一个数组，但其实不是，其无法使用数组的方法： valueOf(), pop(), push(), 或 join() 。


**DOM节点列表**

```js
// 以下代码选取了文档中所有的 <p> 节点：
var myNodeList = document.querySelectorAll("p");
```

> HTMLCollection 元素可以通过 name，id 或索引来获取。  
> NodeList 只能通过索引来获取。

