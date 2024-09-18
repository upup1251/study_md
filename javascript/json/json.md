`json`:javascript object notation(javascript对象表示法)
> JSON 文本格式在语法上与创建 JavaScript 对象的代码相同。


**json语法**

JSON 语法是 JavaScript 语法的子集。

- 大括号`{}`保存对象
- 数据在`键值对`中
```json
"key" = "value"     //key一定要加引号
```
- 中括号`[]`保存数组，数组可以包含多个对象
- 数据由逗号`,` 分隔

---

**对象**

- 对象语法

    - JSON 对象使用在大括号 {...} 中书写。
    - 对象可以包含多个 key/value（键/值）对。
    - key 必须是字符串，value 可以是合法的 JSON 数据类型（字符串, 数字, 对象, 数组, 布尔值或 null）。
    - key 和 value 中使用冒号 : 分割。
    - 每个 key/value 对使用逗号 , 分割。

- 访问对象

    - 使用`.`：myObj.name;
    - 使用`[]`：myObj["name"];

> 访问的同时可用赋值操作`=`对其值进行修改

- 删除对象属性

```js
delete myObj.attribute;
```
> 不是置空

- 循环对象

```js
//x会一次取对象中的每一个key进行遍历，使用myObj.x获得相对应的value
for (x in myObj){
    pass
}
```



**数组**

中括号`[]`保存的数组是值（value）的有序集合，值之间使用逗号`,`分隔。

- 访问数组：下标array[i]
> 访问时可用赋值操作`=`进行修改

- 删除数组元素：delete array[i]

- 循环数组

```js
//for-in循环
for (i in array){
    array[i]...
}

//for循环
for(i=0;i<array.length;i++){
    array[i]...
}
```
---

**json.parse()**

```js
//将json字符串转换为javascript对象
JSON.parse(text[, reviver])
```

- text：一个有效的json字符串
- reviver：可选，将为目标对象的每个键值对调用此函数。



**json.stringify()**

```js
//将JavaScript对象转换为字符串。
JSON.stringify(value[, replacer[, space]])
```

- value：要转换的javascript值（常为对象或数组）
- replacer：用于转换结果的函数或数组。
- space：文本添加缩进、空格和换行符

**eval()**

将传入的字符串当作 JavaScript 代码来执行。

> 安全性和性能不足，不建议使用
