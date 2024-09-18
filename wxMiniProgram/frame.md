小程序框架系统分为两部分：
- 逻辑层：javascript
- 视图层：wxml,wxss

# 介绍

- 数据绑定

框架将逻辑层数据(.js)中的 name 与视图层(.wxml)的 name 进行了绑定，这两个值会会同步变化

- 双向数据绑定

```js
//属性前添加 model: 前缀
<input model:value="{{value}}" />
```


> 使用setData()对数据进行改变

```html
<!-- This is our View -->
<view> Hello {{name}}! </view>
<button bindtap="changeName"> Click me! </button>

```

```js
// This is our App Service.
// This is our data.
var helloData = {
  name: 'Weixin'
}

// Register a Page.
Page({
  data: helloData,
  changeName: function(e) {
    // sent data change to view
    this.setData({
      name: 'MINA'
    })
  }
})
```

- 场景值

场景值用来描述用户进入小程序的路径。  

    - 对于小程序，可以在 App 的 onLaunch 和 onShow，或wx.getLaunchOptionsSync 中获取上述场景值。
    - 对于小游戏，可以在 wx.getLaunchOptionsSync 和 wx.onShow 中获取上述场景值


# 逻辑层

小程序开发框架的逻辑层使用 JavaScript 引擎为小程序提供开发 JavaScript 代码的运行环境以及微信小程序的特有功能。再javascript基础上新增以下功能：

- 增加 App 和 Page 方法，进行程序注册和页面注册。
- 增加 getApp 和 getCurrentPages 方法，分别用来获取 App 实例和当前页面栈。
- 提供丰富的 API，如微信用户数据，扫一扫，支付等微信特有能力。
- 提供模块化能力，每个页面有独立的作用域。

> 小程序框架的逻辑层并非运行在浏览器中，因此 JavaScript 在 web 中一些能力都无法使用，如 window，document 等。


## 启动小程序

每个小程序都需要在 app.js 中调用`App()构造方法`注册小程序实例，绑定生命周期回调函数、错误监听和页面不存在监听函数等。

- app()构造器
```js
// app.js
//调用app()构造器，创建app实例对象
App({
  onLaunch (options) {
    // Do something initial when launch.
  },
  onShow (options) {
    // Do something when show.
  },
  onHide () {
    // Do something when hide.
  },
  onError (msg) {
    console.log(msg)
  },
  globalData: 'I am global data'
})
```
> 全局函数`getApp()`可以获取全局的应用实例，如果需要全局的数据可以在 App()中设置



```js
// xxx.js
// 开发者可以通过 getApp 方法获取到全局唯一的 App 实例，获取App上的数据或调用开发者注册在 App 上的函数。
const appInstance = getApp()
console.log(appInstance.globalData) // I am global data
```

## 注册页面

小程序中的每个页面，都需要在页面对应的 js 文件中进行注册，指定页面的初始数据、生命周期回调、事件处理函数等。


- page()构造器

```js
//index.js
//调用page()构造器
Page({
  data: {
    text: "This is page data."
  },
  onLoad: function(options) {
    // 页面创建时执行
  },
  onShow: function() {
    // 页面出现在前台时执行
  },
  onReady: function() {
    // 页面首次渲染完毕时执行
  },
  onHide: function() {
    // 页面从前台变为后台时执行
  },
  onUnload: function() {
    // 页面销毁时执行
  },
  onPullDownRefresh: function() {
    // 触发下拉刷新时执行
  },
  onReachBottom: function() {
    // 页面触底时执行
  },
  onShareAppMessage: function () {
    // 页面被用户分享时执行
  },
  onPageScroll: function() {
    // 页面滚动时执行
  },
  onResize: function() {
    // 页面尺寸变化时执行
  },
  onTabItemTap(item) {
    // tab 点击时执行
    console.log(item.index)
    console.log(item.pagePath)
    console.log(item.text)
  },
  // 事件响应函数
  viewTap: function() {
    this.setData({
      text: 'Set some data for updating view.'
    }, function() {
      // this is setData callback
    })
  },
  // 自由数据
  customData: {
    hi: 'MINA'
  }
})
```

- 在页面中使用behaviors

behaviors 可以用来让多个页面有相同的数据字段和方法。

```js
// my-behavior.js
module.exports = Behavior({
  data: {
    sharedText: 'This is a piece of data shared between pages.'
  },
  methods: {
    sharedMethod: function() {
      this.data.sharedText === 'This is a piece of data shared between pages.'
    }
  }
})
```
```js
// page-a.js
var myBehavior = require('./my-behavior.js')
Page({
  behaviors: [myBehavior],
  onLoad: function() {
    this.data.sharedText === 'This is a piece of data shared between pages.'
  }
})
```

- Component构造器

Page 构造器适用于简单的页面。但对于复杂的页面， Page 构造器可能并不好用。Component 构造器的主要区别是：方法需要放在 methods: { } 里面。

```js
Component({
  data: {
    text: "This is page data."
  },
  methods: {
    onLoad: function(options) {
      // 页面创建时执行
    },
    onPullDownRefresh: function() {
      // 下拉刷新时执行
    },
    // 事件响应函数
    viewTap: function() {
      // ...
    }
  }
})
```

## 生命周期

![pagelif](https://res.wx.qq.com/wxdoc/dist/assets/img/page-lifecycle.2e646c86.png)


## 页面路由

所有页面的创建、销毁及状态转换都由页面路由来表达和进行控制。

- 路由的时机
    - 由用户的操作（如按下返回按钮）发起
    - 由开发者通过API（如wx.navigateTo）或组件（如navigator）发起
    > 会触发success和fail回调函数


## 页面栈

小程序的页面会被组织为一个页面栈加若干不在栈中的悬垂页面的组合形式。页面栈按顺序存放了通过跳转依次打开的页面。

```js
getCurrentPages //获得当前页面栈
```

> 当前已经创建但非活跃的 tabBar 页面及处于画中画模式（如 video、live-player 等）中的页面将以`悬垂页面`的形式存在。

## 路由类型

**1 小程序启动**
- openType:`applaunch`  
> 小程序启动路由 appLaunch 表示一个新的小程序启动，并加载第一个页面。

**触发方式**  
appLaunch 仅能由小程序冷启动被动触发

**页面栈和生命周期**  
作为启动的第一个路由，此时页面栈为空。applaunch会创建路由世界指定的页面，并将其推入页面栈作为栈中唯一的页面。在这个过程中，这个页面的 onLoad, onShow 两个生命周期将依次被触发。


**2. 打开新页面**
- openType:`navigateTo`

打开新页面路由 navigateTo 表示打开一个新的页面，并将其推入页面栈。

**触发方式**  
1. 调用API`wx.navigateTo` `Router.navigateTo`
2. 调用组件`<navigator open-type='navigateTo"/>`
3. 用户点击一个视频小窗（如vedio）  

> navigateTo 的目标必须是非tabBar页面

**页面栈及生命周期**  

页面栈当前的栈顶页面`onHide`将首先被隐藏；之后框架将创建路由事件指定的新页面，触发`onLoad` `onShow`，并将其推入页面栈作为新的栈顶。

**3. 页面重定向**
- openType:`redirecTo`  

页面重定向路由 redirectTo 表示将页面栈当前的栈顶页面`替换`为一个新的页面。

**触发方式**
1. 调用API`wx.redirectTo` `Router.redirectTo`
2. 使用组件`<navigator open-type="redirectTo"/>`

> redirectTo 的目标必须为非 tabBar 页面。

**页面栈及生命周期处理**  
页面栈当前的栈顶页面将首先被弹出并**销毁**，触发`onUnload`；之后框架将创建路由事件指定的页面，触发`onLoad` `onShow`，并将其推入页面栈作为新的栈顶。

**4. 页面返回**
- openType: `navigateBack`  

页面返回路由 navigateBack 表示将页面栈当前的栈顶的若干个页面依次弹出并销毁。

**触发方式**
1. 调用API`wx.navigateBack` `Router.navigateBack`
2. 使用组件`<navigator open-type="navigateBack"/>`
3. 用户按左上角返回按钮，或触发操作系统返回的动作（如按下系统返回键、屏幕边缘向内滑动等）
4. 用户点击一个视频小窗（如 video）  

如果页面栈中当前只有一个页面，navigateBack 调用请求将失败（无论指定的 delta 是多少）；

如果页面栈中当前的页面数量少于调用时指定的 delta + 1（即调用后页面数量将少于一个），navigateBack 将弹出到只剩页面栈当前的页面栈底的页面为止（即至少保留一个页面）。

**页面栈及生命周期处理**

页面栈当前的栈顶页面将被弹出并销毁，触发这个页面的`onUnload`生命周期；以上操作将被重复执行多次，直到弹出的页面数量等于指定的页面数量，或当前页面栈中只剩下一个页面。之后，页面栈新的栈顶页面的`onShow`生命周期将被触发。

一种特殊情况是，如果 navigateBack 发生时，页面栈当前的栈顶页面满足小窗模式逻辑，或事件由用户点击视频小窗发起，那么页面栈及生命周期的的处理会有所不同。

**5. Tab 切换**
- openType: `switchTab`  

Tab 切换路由 switchTab 表示切换到指定的 tab 页面。

**触发方式**

1. 调用 `API wx.switchTab` `Router.switchTab`
2. 使用组件 `<navigator open-type="switchTab"/>` 
3. 用户点击 Tab Bar 中的 Tab 按钮

> switchTab 的目标必须为 tabBar 页面。

**页面栈及生命周期处理**

由于 navigateTo 和 redirectTo 不能指定 tabBar 页面作为目标，因此当一个 tabBar 页面出现在页面栈中时，它必定为页面栈的第一个页面（即栈底页面）；同时，框架会保证任一 tabBar 页面在小程序中最多同时存在一个页面实例。switchTab 的行为主要基于这两点进行。

switchTab 事件发生时，如果当前页面栈中存在多于一个页面，页面栈当前的栈顶页面将被弹出并**销毁**，并触发这个页面的 onUnload 生命周期；以上操作将被重复执行多次，直到页面栈中只剩下一个页面。之后，根据页面栈中仅剩的页面进行不同的处理：

如果这个页面即为目标 tabBar 页面：
如果路由事件开始时页面栈中存在多于一个页面（即目标 tabBar 页面不是栈顶页面），触发目标 tabBar 页面的 onShow 生命周期；
否则（路由事件开始时目标 tabBar 页面是栈顶页面），不触发任何生命周期，直接结束；
否则（该页面不为目标 tabBar 页面时）：
将这个页面从页面栈中弹出；
如果这个页面为其他 tabBar 页面，该页面成为悬垂页面，并：
如果路由事件开始时页面栈中只有一个页面（即该 tabBar 页面是栈顶页面），触发它的 onHide 生命周期；
否则（路由事件开始时该 tabBar 页面不是栈顶页面），不触发它的任何生命周期；
否则（这个页面为非 tabBar 页面时），销毁该页面，触发 onUnload 生命周期；
如果目标 tabBar 页之前已经被创建过（现在是一个悬垂页面），将其推入页面栈，触发 onShow 生命周期；
否则（目标 tabBar 页不存在实例），创建目标 tabBar 页并推入页面栈，依次触发 onLoad, onShow 生命周期。

**6. 重加载**

- openType: `reLaunch` `autoReLaunch`

重加载路由 reLaunch 或 autoReLaunch 表示销毁当前所有的页面，并载入一个新页面，并不等于小程序重启

> 重加载路由的两种 openType 的区别主要为是否由开发者主动触发（或是由用户触发），这两种 openType 的路由逻辑基本一致。

**触发方式**

1. （reLaunch）调用 API `wx.reLaunch` `Router.reLaunch`
2. （reLaunch）使用组件 `<navigator open-type="reLaunch"/>`
3. （autoReLaunch）小程序处于后台时，用户从扫码或分享等场景重新进入小程序

> reLaunch 可以指定任意页面作为目标页面，无论它是否是小程序的首页或是否 tabBar 页。


**页面栈及生命周期处理**

页面栈中的所有页面将由顶至底依次被弹出并销毁，触发`onUnload`生命周期；之后所有悬垂页面将以不确定的顺序逐个被销毁，触发`onUnload`生命周期。所有页面都被销毁后，目标页面将被创建，触发`onLoad` `onShow`并推入页面栈成为栈中唯一的页面

**7. 关闭小窗页面**
- openType: `dismissPip`

关闭小窗页面路由 dismissPip 表示关闭一个正处于小窗模式的页面。


### 页面路由监听

当某个页面的某个生命周期被触发时，小程序往往比较难判断它被触发的原因，从而难以做出一些针对路由（而非针对页面）的响应。页面路由监听函数可以帮助处理这样的场景


| 页面路由监听 | 触发时机 | 每次路由的触发次数 |
| --- | --- | --- |
| wx.onBeforeAppRoute | 路由事件下发到基础库，基础库执行路由逻辑前触发 | 一次 |
| wx.onAppRoute | 路由事件下发到基础库，基础库执行路由逻辑后触发 | 一次 |
| wx.onPaaRouteDone | 路由对应的动画（页面推入、推出等）完成时触发 | 一次 |
| wx.onBeforePageLoad | 路由引发的页面创建之前触发 | 不限 |
| wx.onAfterPageLoad | 路由引发的页面创建完成后触发 | 不限 |
| wx.onBeforePageUnload | 路由引发的页面销毁之前触发 | 不限 |
| wx.onAfterPageUnload | 路由引发的页面销毁完成后触发 | 不限 |




### 模块化

将一些公共的代码抽离成为一个单独的 js 文件，作为一个模块。模块只有通过 module.exports 或者 exports 才能对外暴露接口。

```js
//common.js
function sayHello(name) {
  console.log(`Hello ${name} !`)
}

module.exports.sayHello = sayHello  //进行暴露，才可被require引入


```
var common = require('common.js')   //引入被export的变量
```


### API 

小程序开发框架提供丰富的微信原生 API，可以方便的调起微信提供的能力，如获取用户信息，本地存储，支付功能等。

**事件监听API**

以`on`开头的API用来监听某个事件是否触发，这类 API 接受一个回调函数作为参数，当事件触发时会调用这个回调函数，并将相关数据以参数形式传入。



**同步API**

以`Sync`结尾的API都是同步API，同步 API 的执行结果可以通过函数返回值直接获取，如果执行出错会抛出异常。


**异步API**

大多数 API 都是异步 API，如 wx.request，wx.login 等。这类 API 接口通常都接受一个`Object`类型的参数，这个参数都支持按需指定以下字段来接收接口调用结果

- Object参数说明

| 参数名 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| success | function | no | 接口调用成功的回调函数 |
| fail | function | no | 接口调用失败的回调函数 |
| complete | function | no | 接口调用结束的回调函数（调用成功、失败都会执行） |
| 其他 | Any | - | 其他参数 |


- 回调函数参数说明

success，fail，complete 函数调用时会传入一个 Object 类型参数，包含以下字段：

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| errMsg | string | 错误信息，如果调用成功返回`${apiName}:ok` |
| errCode | number | 错误码，成功时为0 |
| 其他 | Any | 其他数据 |


异步 API 的执行结果需要通过 Object 类型的参数中传入的对应回调函数获取。

```js
//res是用于接收Object的形参
wx.login({
  success(res) {
    console.log(res.code)
  }
})
```

- 异步API返回Promise

异步 API 支持 callback & promise 两种调用方式。当接口参数 Object 对象中不包含 success/fail/complete 时将默认返回 promise，否则仍按回调方式执行，无返回值。


```js
// callback 形式调用
wx.chooseImage({
  success(res) {
    console.log('res:', res)
  }
})

// promise 形式调用
wx.chooseImage().then(res => console.log('res: ', res))

---

// 调用方式
request({ url: 'https://example.com/data' })
    // then用于处理success,javascript中的箭头函数
  .then((res) => {
    console.log(res.data);
  })
    // catch用于处理fial
  .catch((err) => {
    console.error('Request failed:', err);
  });
```









---








# 视图层view

**介绍**

- 框架的视图层由 WXML 与 WXSS 编写，由组件来进行展示。
- WXML(WeiXin Markup language) 用于描述页面的结构。
- WXSS(WeiXin Style Sheet) 用于描述页面的样式。
- 组件(Component)是视图的基本组成单元。
- WXS(WeiXin Script) 是小程序的一套脚本语言，结合 WXML，可以构建出页面的结构。
- 将逻辑层的数据反映成视图，同时将视图层的事件发送给逻辑层。


## 事件系统

### 介绍

**事件的使用方式**

- 在组件中绑定一个事件处理函数

> 在标签属性中添加`事件名=函数名`的格式进行处理

```js
//如bindtap，当用户点击该组件的时候会在该页面对应的Page中找到相应的事件处理函数tapName()。
<view bindtap="tapName"> Click me! </view>


//相应的Page定义中写上相应的事件处理函数，参数是event，是该事件的对象，记录了该事物的属性
Page({
  tapName: function(event) {
    console.log(event)
  }
})
```

>   事件绑定函数可以是一个数据绑定，如`bindtap="{{ handlerName }}"`，此时，页面的 this.data.handlerName 必须是一个字符串，指定事件处理函数名；可用于改变处理的函数



### 事件详解

**事件分类**

- `冒泡事件bind`：当一个组件上的事件被触发后，该事件会向父节点传递。
- `非冒泡事件catch`：当一个组件上的事件被触发后，该事件不会向父节点传递。
> 用`catch`来绑定事件(如`catch:eventname`)。与`bind`不同(如`bind:eventname`)，`catch`会阻止事件向上冒泡。

- `互斥事件mut-bind`：一个 mut-bind 触发后，如果事件冒泡到其他节点上，其他节点上的 mut-bind 绑定函数不会被触发，但 bind 绑定函数和 catch 绑定函数依旧会被触发。即所有 mut-bind 是“互斥”的



**事件的捕获阶段**

捕获阶段位于冒泡阶段之前，且在捕获阶段中，事件到达节点的顺序与冒泡阶段恰好相反。

需要在捕获阶段监听事件时，可以采用capture-bind、capture-catch关键字，后者将中断捕获阶段和取消冒泡阶段。

```js
//点击 inner view 会先后调用handleTap2、handleTap4、handleTap3、handleTap1。
<view id="outer" bind:touchstart="handleTap1" capture-bind:touchstart="handleTap2">
  outer view
  <view id="inner" bind:touchstart="handleTap3" capture-bind:touchstart="handleTap4">
    inner view
  </view>
</view>
```


**事件对象**

如无特殊说明，当组件触发事件时，逻辑层绑定该事件的`处理函数`会收到一个`事件对象`。

*BaseEvent基础事件对象属性列表*

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| type | string | 事件类型 |
| timeStrp | int | 页面打开到触发事件所经过的毫秒数 |
| target | Object | 触发事件的源组件的一些属性值集合 |
| currentTarget | Object | 事情绑定的当前组件的一些属性值集合 |
| mark | Object | 事件标记数据 |

 - 介绍BaseEvent

    - target：触发事件的源组件

    | 属性 | 类型 | 说明 |
    | --- | --- | --- |
    | id | string | 事件源组件的id |
    | dataset | Object | 事件源组件上由`data-`开头的自定义属性组成的集合 |

    - currentTarget：事件绑定的当前组件

    | 属性 | 类型 | 说明 |
    | --- | --- | --- |
    | id | string | 当前组件的id |
    | dataset | Object | 当前组件上由data-开头的自定义属性组成的集合 |

    > 由于事件具有冒泡传递性，所以一个事件具有源组件和当前组件两种target

    - dataset
    组件节点属性中可以加一些自定义数据。这样，在事件中可以获取这些自定义的节点数据，用于事件的逻辑处理。
    ```js
    //示例
    //这些自定义数据以 data- 开头，多个单词由连字符 - 连接
    <view data-alpha-beta="1" data-alphaBeta="2" bindtap="bindViewTap"> DataSet Test </view>

    Page({
        bindViewTap:function(event){
        event.currentTarget.dataset.alphaBeta === 1 // - 会转为驼峰写法
        event.currentTarget.dataset.alphabeta === 2 // 大写会转为小写
    }
    })
    ```

*CustomEvent 自定义事件对象属性列表（继承 BaseEvent）*

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| detail | Object | 额外的信息，自定义事件所携带的数据 |


*TouchEvent 触摸事件对象属性列表（继承 BaseEvent）*


| 属性 | 类型 | 说明 |
| --- | --- | --- |
| touches | array | 触摸事件，当前停留在屏幕中的触摸点信息的数组 |
| changedTouches | array | 触摸事件，当前变化的触摸点信息的数组|

touches 是一个数组，每个元素为一个 Touch 对象

- Touch对象


| 属性 | 类型 | 说明 |
| --- | --- | --- |
| identifier | number | 触摸点的标识符 |
| pageX, pageY | number | 距离文档左上角的距离，文档的左上角为原点 ，横向为X轴，纵向为Y轴 |
| clientX, clientY | number | 距离页面可显示区域（屏幕除去导航条）左上角距离 |









## 基础组件

什么是组件？
- 组件是视图层的基本组成单元。
- 组件自带一些功能与微信风格一致的样式。
- 一个组件通常包括`开始标签`和`结束标签`，`属性`用来修饰这个组件，`内容`在两个标签之内。

```js
<tagname property="value">
Content goes here ...
</tagname>
```

- 公共属性

| 属性名 | 类型 | 描述 | 注解 |
| --- | --- | --- | --- |
| id | string | 组件的唯一标示 | 保持整个页面唯一 |
| class | string | 组件的样式类 | 在对应的 WXSS 中定义的样式类 |
| style | string | 组件的内联样式 | 可以动态设置的内联样式 |
| hidden | boolean | 组件是否显示 | 组件是否显示 |
| data-* | Ant | 自定义属性 | 组件上触发的事件时，会发送给事件处理函数 |
| bind* / catch* | EventHandlerFunction | 组件的事件 |  |
