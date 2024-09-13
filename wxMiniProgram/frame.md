小程序框架系统分为两部分：
- 逻辑层：javascript
- 视图层：wxml,wxss

# 介绍

- 数据绑定

框架将逻辑层数据(.js)中的 name 与视图层(.wxml)的 name 进行了绑定，这两个值会会同步变化

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


## 页面栈

小程序的页面会被组织为一个页面栈加若干不在栈中的悬垂页面的组合形式。页面栈按顺序存放了通过跳转依次打开的页面。

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
> 打开新页面路由 navigateTo 表示打开一个新的页面，并将其推入页面栈。

**触发方式**  
1. 调用API`wx.navigateTo` `Router.navigateTo`
2. 调用组件`<navigator open-type='navigateTo"/>`
3. 用户点击一个视频小窗（如vedio）  

navigateTo 的目标必须是非tabBar页面

**页面栈及生命周期**  
navigateTo 事件发生时，页面栈当前的栈顶页面将首先被隐藏，触发 onHide 生命周期；之后框架将创建路由事件指定的页面，并将其推入页面栈作为新的栈顶。在这个过程中，这个新页面的 onLoad, onShow 两个生命周期将依次被触发。

**3. 页面重定向**
- openType:`redirecTo`  

页面重定向路由 redirectTo 表示将页面栈当前的栈顶页面替换为一个新的页面。

**触发方式**
1. 调用API`wx.redirectTo` `Router.redirectTo`
2. 使用组件`<navigator open-type="redirectTo"/>`
> redirectTo 的目标必须为非 tabBar 页面。

**页面栈及生命周期处理**  
redirectTo 事件发生时，页面栈当前的栈顶页面将首先被弹出并**销毁**，在此过程中，这个栈顶页面的 onUnload 生命周期将被触发；之后框架将创建路由事件指定的页面，并将其推入页面栈作为新的栈顶。在这个过程中，这个新页面的 onLoad, onShow 两个生命周期将依次被触发。

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

navigateBack 事件发生时，页面栈当前的栈顶页面将被弹出并销毁，并触发这个页面的 onUnload 生命周期；以上操作将被重复执行多次，直到弹出的页面数量等于指定的页面数量，或当前页面栈中只剩下一个页面。之后，页面栈新的栈顶页面的 onShow 生命周期将被触发。

一种特殊情况是，如果 navigateBack 发生时，页面栈当前的栈顶页面满足小窗模式逻辑，或事件由用户点击视频小窗发起，那么页面栈及生命周期的的处理会有所不同。

**5. Tab 切换**
- openType: `switchTab`  

Tab 切换路由 switchTab 表示切换到指定的 tab 页面。

**触发方式**

1. 调用 `API wx.switchTab` `Router.switchTab`
2. 使用组件 `<navigator open-type="switchTab"/>` 
3. 用户点击 Tab Bar 中的 Tab 按钮
switchTab 的目标必须为 tabBar 页面。

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

重加载路由 reLaunch 或 autoReLaunch 表示销毁当前所有的页面，并载入一个新页面。  
重加载路由的两种 openType 的区别主要为是否由开发者主动触发（或是由用户触发），这两种 openType 的路由逻辑基本一致。

**触发方式**

1. （reLaunch）调用 API `wx.reLaunch` `Router.reLaunch`
2. （reLaunch）使用组件 `<navigator open-type="reLaunch"/>`
3. （autoReLaunch）小程序处于后台时，用户从扫码或分享等场景重新进入小程序
reLaunch 可以指定任意页面作为目标页面，无论它是否是小程序的首页或是否 tabBar 页。

请注意：reLaunch 及 autoReLaunch 仅代表一种路由，并不等于小程序重启，小程序会在当前的 AppService 上继续运行，既不会重新启动 AppService 的 JavaScript 运行环境，也不会重新注入小程序代码或触发 App.onLaunch 生命周期，各种 JS 的全局变量或全局状态也不会被重置。

**页面栈及生命周期处理**

reLaunch 或 autoReLaunch 事件发生时，页面栈中的所有页面将由顶至底依次被弹出并销毁，触发 onUnload 生命周期；之后所有悬垂页面将以不确定的顺序逐个被销毁，触发 onUnload 生命周期。所有页面都被销毁后，目标页面将被创建，并推入页面栈成为栈中唯一的页面，依次触发 onLoad 和 onShow 两个生命周期。

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

