# 小程序代码构成

## json配置文件

JSON 是一种数据格式，并不是编程语言，在小程序中，JSON扮演的静态配置的角色。

- 小程序配置 app.json
app.json 是当前小程序的全局配置，包括了小程序的所有页面路径、界面表现、网络超时时间、底部 tab 等。

```js
{
  "pages":[                 // 描述当前小程序所有页面路径
    "pages/index/index",
    "pages/logs/logs"
  ],
  "window":{                // 定义小程序所有页面的顶部背景颜色，文字颜色定义等
    "backgroundTextStyle":"light",
    "navigationBarBackgroundColor": "#fff",
    "navigationBarTitleText": "Weixin",
    "navigationBarTextStyle":"black"
  }
}
```
- 页面配置page.json
pages/logs 目录下的 logs.json 这类和小程序页面相关的配置。  
可以独立定义每个页面的一些属性，例如刚刚说的顶部颜色、是否允许下拉刷新等等。

- 工程项目project.config.json
针对每个项目喜好做一些个性化配置，例如界面颜色、编译配置等等


## wxml模板文件

### 具有的能力

- 数据绑定
```js
<!--wxml-->
<view> {{message}} </view>

// page.js
Page({
  data: {
    message: 'Hello MINA!'
  }
})
```

- 列表渲染
```js
<!--wxml-->
<view wx:for="{{array}}"> {{item}} </view>

// page.js
Page({
  data: {
    array: [1, 2, 3, 4, 5]
  }
})
```

- 条件渲染
```js
<!--wxml-->
<view wx:if="{{view == 'WEBVIEW'}}"> WEBVIEW </view>
<view wx:elif="{{view == 'APP'}}"> APP </view>
<view wx:else="{{view == 'MINA'}}"> MINA </view>

// page.js
Page({
  data: {
    view: 'MINA'
  }
})
```

- 模板
```js
<!--wxml-->
<template name="staffName">
  <view>
    FirstName: {{firstName}}, LastName: {{lastName}}
  </view>
</template>

<template is="staffName" data="{{...staffA}}"></template>
<template is="staffName" data="{{...staffB}}"></template>
<template is="staffName" data="{{...staffC}}"></template>


// page.js
Page({
  data: {
    staffA: {firstName: 'Hulk', lastName: 'Hu'},
    staffB: {firstName: 'Shang', lastName: 'You'},
    staffC: {firstName: 'Gideon', lastName: 'Lin'}
  }
})
```




## wxss样式文件

## js脚本逻辑文件



## WXS
> wx中的javascript

WXS 代码可以编写在 wxml 文件中的 <wxs> 标签内，或以 .wxs 为后缀名的文件内。


