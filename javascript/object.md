**类的格式**

```js
//定义类
class ClassName {
  constructor() { ... }     //构造函数
}

//使用类
var objName = new className();
```

- 匿名类
```js
var variable = class{
    constructor() {...}
    ...
}
```
---

**继承**

- 继承的要素
    - 使用 extends 关键字。
    - super() 方法用于调用父类的构造函数。

    

- 继承的方式
    - 使用原型链继承
    - 使用ES6类继承

---

**静态方法**

使用static修饰

> 只能通过 类名.方法名 调用静态方法。静态方法不能在对象上调用


---


**prototype**

每个 JavaScript 对象都有一个与之关联的原型对象，通过原型对象，可以实现属性和方法的共享，从而减少内存占用。所有的 JavaScript 对象都会从一个 prototype（原型对象）中继承属性和方法。

- 原型是一个对象，它是其他对象的模板或蓝图。
- 当一个对象试图访问一个属性或方法时，如果在该对象自身没有找到，JavaScript 会沿着原型链向上查找，直到找到对应的属性或方法，或者达到原型链的顶端 null 为止。

**\__proto__ 属性**

每个 JavaScript 对象（除了 null）都自动拥有一个隐藏的属性 __proto__，它指向该对象的原型对象。


```js
function Person(name) {
    this.name = name;
}

// 动态地修改对象的原型，这样可以影响到所有基于该原型创建的对象
Person.prototype.sayHello = function() {
    console.log("Hello, my name is " + this.name);
};

let alice = new Person("Alice");
alice.sayHello(); // 输出: Hello, my name is Alice
```

**Object.create方法**

Object.create 方法允许你创建一个新对象，并将其原型设置为指定的对象。

```js
let personPrototype = {
    sayHello: function() {
        console.log("Hello, my name is " + this.name);
    }
};

let alice = Object.create(personPrototype);
alice.name = "Alice";
alice.sayHello(); // 输出: Hello, my name is Alice
```


> prototype的原理：(类似于单链表)
> 1. JavaScript 对象有一个指向一个原型对象的链，即指向该对象的父类。
> 2. 继承：当试图访问一个对象的属性时，它不仅仅在该对象上搜寻，还会搜寻该对象的原型，以及该对象的原型的原型，依次层层向上搜索，直到找到一个名字匹配的属性或到达原型链的末尾。



