Servlet 

[toc]

# HTTP协议

HTTP协议(Hypertext Transfer Protocol，超文本传输协议)
- 是一个客户端请求和响应的标准协议
- 详细规定了浏览器和万维网服务器之间互相通信的规则
    - 客户端发送给服务器的格式叫"请求协议"
    - 服务器发送给客户端的格式叫"响应协议"
- 用户输入地址和端口号之后就可以从服务器上取得所需要的网页信息。


## 特点

1. 支持客户/服务器模式
2. 简单快速: 客户端向服务端请求服务时，只需传送请求方法(`post`/`get`)和路径
3. 灵活：允许传输任意类型的数据对象，传输的类型由`Content-Type`标记
4. 无连接：每次连接只处理一个请求。服务器处理完客户的请求，并收到客户的应答后，即断开连接
> HTTP1.1 版本后支持可持续连接
5. 无状态：指协议对于事务处理没有记忆能力。缺少状态意味着如果后续处理需要前面的信息，则它必须重传


## url 

HTTP URL (URL 是一种特殊类型的 URI，包含了用于查找某个资源的足够的信息)的格式 如下：
```http 
http://host[:port]/[path]
```
- http: 表示要通过HTTP协议来定位网络资源；
- host: 表示合法的Internet主机域名或者IP 地址；
- port: 指定一个端口号，为空则使用缺省端口 80；
- path: 指定请求资源的 URI；
> 如果 URL 中没有给出 abs_path，那么当它作为请求 URI 时，必须以“/”的形式给出，通常 这个工作浏览器自动帮我们完成。


## HTTP请求


```http
请求行
请求头1
请求头2
...
请求空行
请求正文

```

1. 请求行

`Method Request-URI HTTP-Version CRLF`
- `Method`: 请求方法
    - `Get`: 没有请求体
    - `Post`
- `Request-URI`: 统一资源标识符
- `HTTP-Version`: 表示请求的HTTP协议版本 
- `CRLF`: 回车和换行

2. 请求头

请求报头允许客户端向服务器端传递请求的附加信息以及客户端自身的信息

- Refer: 该请求头指明请求从哪里来



3. 请求正文



## HTTP响应


```http
状态行
响应头1
响应头2
...
响应空行
响应正文

```

1. 状态行

2. 响应头

响应报头允许服务器传递不能放在状态行中的附加响应信息

- Location：Location响应报头域用于重定向接受者到一个新的位置
- Refresh：自动跳转（单位是秒）

3. 响应正文



# TomcaT服务器

## 概述

Tomcat 是一个符合 JavaEE WEB 标准的最小的**WEB容器**，所有的 JSP 程序一定要有 WEB 容器的支持才能运行，而且在给定的 WEB 容器里面都会支持事务处理操作。


Tomcat 简单的说就是一个运行 Java的网络服务器，底层是 Socket 的一个程序，它也是 JSP 和 Servlet 的一个容器。

实际上 Tomcat 部分是 Apache 服务器的扩展，但它是独立运行的，所以当你运行 tomcat 时，它实际上作为一个与 Apache 独立的进程单独运行的


## Tomcat目录结构

- `bin`: 存放启动和关闭Tomcat的脚本文件
- `conf`: 存放Tomcat服务器的配置文件
- `lib`: 存放Tomcat服务器的支持jar包
- `logs`: 存放Tomcat的日志文件
- `temp`: 存放Tomcat运行时产生的临时文件
- `webapps`: web应用所在的目录，即外界访问的web资源存放目录
- `work`: Tomcat的工作目录


# Servlet的实现


Servlet 是 Server 与 Applet 的缩写，是服务端小程序的意思。

Servlet 是用 Java 语言编写的服务器端程序，可以动态生成 WEB 页，Servlet 主要运行在服务器端，并由服务器调用执行， 是一种按照 Servlet标准来开发的类。

Servlet 本质上也是 Java 类，但要遵循 Servlet 规范进行编写，没有 main()方法，它的创建、使用、销毁都由 Servlet 容器进行管理(如 Tomcat)。（言外之意：写自己的类，不用写 main 方法，别人自动调用）


## Servlet实现步骤

1. 创建Web项目
2. 新建类
3. 实现Servletgv规范 
    - 继承 HttpServlet 类
    - 重写 service 方法: 用于处理请求
    - 设置注解: 特定请求对应特定资源
4. 发布项目并启动服务


```java
package com.xxxx.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ser01")
public class Servlet01 extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        System.out.println("Hello Servlet!");
        resp.getWriter().write("Hello World");
    }
}
```
- 当客户端请求访问`http://ip:port/project_name/ser01`资源时，会将该请求转到`Servlet01`进行处理
- web容器会将http请求转换为一个`HttpServletRequest`对象，传递至`service()`函数的参数`req`
- Servlet类对象对其该请求进行处理后，将设置参数中`HttpServletResponse`对象`resp`的属性
- web容器再将`resp`的值转换为http响应返回客户端

## Servlet的工作流程

1. 通过请求头获知浏览器访问的是哪个主机
2. 再通过请求行获取访问的是哪个一个web应用
3. 再通过请求行中的请求路径获知访问的是哪个资源
4. 通过获取的资源路径在配置中匹配到真实的路径，
5. 服务器会创建servlet对象，（如果是第一次访问时，创建servlet实例，并调用init方法进行初始化操作）
6. 调用service（request， response）方法来处理请求和响应的操作
7. 调用service完毕后返回服务器 由服务器讲response缓冲区的数据取出，以http响应的格式发送给浏览器



### Tomcat和Servlet的合作


接下来描述一下 Tomcat 与 Servlet 是如何工作的,看看下面的时序图：


![Tomcat work with Servlet](assets/2024-11-29-18-39-50.png)

1. Web Client 向 Servlet 容器（Tomcat）发出 Http 请求
2. Servlet 容器接收 Web Client 的请求
3. Servlet 容器创建一个 HttpServletRequest 对象，将 Web Client 请求的信息封装到这个对象中
4. Servlet 容器创建一个 HttpServletResponse 对象
5. Servlet 容器调HttpServlet 对象service 方法，把 Request 与 Response 作为参数，传给HttpServlet
6. HttpServlet 调用 HttpServletRequest 对象的有关方法，获取 Http 请求信息
7. HttpServlet 调用 HttpServletResponse 对象的有关方法，生成响应数据
8. Servlet 容器把 HttpServlet 的响应结果传给 Web Client



## Servlet的生命周期

Servlet没有 main()方法，不能独立运行，它的运行完全由 Servlet 引擎来控制和调度。

Servlet 的生命周期，简单的概括这就分为四步：servlet 类加载-->实例化-->服务-->销毁。

### 生命周期

1. 实例和初始化时机

当请求到达容器时，容器查找该 servlet 对象是否存在，如果不存在，则会创建实例并进行初始化。

2. 就绪/调用/服务阶段

有请求到达容器，容器调用 servlet 对象的 service()方法,处理请求的方法在整个生命周期中可以被多次调用；

HttpServlet 的 service()方法，会依据请求方式来调用 doGet()或者 doPost()方法。但是， 这两个 do 方法默认情况下，会抛出异常，需要子类去 override。


3. 销毁时机

当容器关闭时（应用程序停止时），会将程序中的 Servlet 实例进行销毁。


### 生命周期方法


在 Servlet 中有三个生命周期方法，不由用户手动调用，而是在特定的时机有容器自动调用，观察这三个生命周期方法 即可观察到Servlet 的生命周期。

1. init方法

在 Servlet 实例创建之后执行（证明该 Servlet 有实例创建了）

```java
public void init(ServletConfig config) throws ServletException {
    System.out.println("实例创建了...");
}
```

2. service方法

每次有请求到达某个 Servlet 方法时执行，用来处理请求（证明该Servlet 进行服务了）

```java
protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    System.out.println("服务调用了...");
}
```

3. destroy方法

Servlet 实例销毁时执行（证明该 Servlet 的实例被销毁了）

```java
public void destroy() {
    System.out.println("实例销毁了...");
}
```




# request和response对象

Web服务器收到客户端的http请求，会针对每一次请求，分别创建一个用于代表请求的 request 对象和代表响应的 response 对象。

request 和 response 对象代表请求和响应
- 获取客户端数据，需要通过 request 对象
- 向客户端输出数据，需要通过 response 对象。




## HttpServletRequest对象

主要作用是用来接收客户端发送过来的请求信息

service()方法中形参接收的是 HttpServletRequest 接口的实例化对象，表示该对象主要应用在 HTTP 协议上，该对象是由 Tomcat 封装好传递过来。

目前，HttpServletRequest是ServletRequest的唯一子接口，如果以后出现更多新的协议，若想要支持这种新协议，只需要直接继承ServletRequest接口就行。

在HttpServletRequest接口中，定义的方法很多，但都是围绕接收客户端参数的

### 方法

1. 常用方法
- `getRequstURL()`: 获取客户端发出请求时的完整URL
- `getRequstURI()`: 获取请求行中的资源部分（项目名称开始）
- `getMethod()`: 获取请求行中的参数部分
- `getProtocol()`: 获取HTTP版本号
- `getContextPath`: 获取webapp名字

2. 获取请求参数
- `getParameter(name)`: 获取指定名称的参数
- `getParameterValues(String name)`: 获取指定名称参数的所有值



### reques对象作用域

通过该对象可以在一个请求中传递数据

作用范围：在一次请求中有效，即服务器跳转有效。

```java
// 设置域对象内容
request.setAttribute(String name, String value);
// 获取域对象内容
request.getAttribute(String name);
// 删除域对象内容
request.removeAttribute(String name);
```



### 请求转发

请求转发
- 是一种服务器的行为
- 当客户端请求到达后，服务器进行转发
- 此时会将请求对象进行保存，地址栏中的 URL 地址不会改变
- 得到响应后，服务器端再将响应发送给客户端，从始至终只有一个请求发出

```java
// 实现步骤
// 通过将当前service()的request和response对象传递给下一个Servlet的service()函数
// 保证了request和response始终是同一个
request.getRequestDispatcher(url).forward(request,response);
```



### 请求乱码问题

由于request属于接收客户端的参数，有其默认的语言编码，由于在解析过程中默认使用的编码方式为 ISO-8859-1(此编码不支持中文)，所以解析时一定会出现乱码

要想解决这种乱码问题，需要设置 request 中的编码方式，告诉服务器以何种方式来解析数据。或者在接收到乱码数据以后，再通过相应的编码格式还原

```java
// 方法一
request.setCharacterEncoding("UTF-8");
// 这种方式只针对 POST 有效（必须在接收所有的数据之前设定）

// 方法二
new String(request.getParameter(name).getBytes("ISO-8859-1"),"UTF-8");
```

Tomcat8及以后的GET方式请求是不会出现乱码的。


## HttpServletResponse对象


HttpServletResponse的主要功能用于服务器对客户端的请求进行响应，将 Web 服务器处理后的结果返回给客户端。

service()方法中形参接收的是 HttpServletResponse 接口的实例化对象，这个对象中封装了向客户端发送数据、发送响应头，发送响应状态码的方法。


### 响应数据


接收到客户端请求后，可以通过 HttpServletResponse 对象直接进行响应，响应时需要获取输出流。有两种形式，不能同时使用

1. `getWriter()` 

获取字符流(只能响应回字符)

```java
// 字符输出流
PrintWriter writer = response.getWriter();
writer.write("Hello");
writer.write("<h2>Hello</h2>");
```

2. `getOutputStream()` 

获取字节流(能响应一切数据)  

```java
// 字节输出流
ServletOutputStream out = response.getOutputStream();
out.write("Hello".getBytes());
out.write("<h2>Hello</h2>".getBytes());
```


除此之外，我们还需要设置响应类型，默认是字符串
> 即`writer.write("<h2>Hello</h2>");`会原样输出，不会生成二号标题

```java
// 设置响应MIME类型
response.setHeader("content-type","text/html"); // html
```



### 重定向

重定向
- 是一种服务器指导，客户端的行为
- 客户端发出第一个请求，被服务器接收处理后，服务器会进行响应
- 在响应的同时，服务器会给客户端一个新的地址（下次请求的地址response.sendRedirect(url);）
- 当客户端接收到响应后，会立刻、马上、自动根据服务器给的新地址发起第二个请求
- 服务器接收请求并作出响应，重定向完成。

```java
// 重定向跳转到index.jsp
response.sendRedirect("index.jsp");
```


#### 请求转发和重定向的区别

`req.getRequestDispatcher().forward()` and `resp.sendRedirect()`
| 请求转发 | 重定向 |
| --- | --- |
| 一次请求，数据在`request`域中共享 | 两次请求，数据不再`request`域中共享 |
| 服务器端行为 | 客户端行为 |
| 地址栏不发生变化 | 地址了发生变化 |
| 绝对地址定位到站点后 | 绝对地址可写到http:// |

两者都可进行跳转，根据实际需求选取即可。




### 响应乱码问题

服务器端有一种编码方式，在客户端也存在一种编码方式，当两端使用的编码方式不同时则出现乱码

1. `getWriter()`的字符乱码

服务器端在进行编码时默认会使用 ISO-8859-1 格式的编码，该编码方式并不支持中文，响应中文必定出乱码


```java
// 在服务器端告知服务器使用UTF-8
response.setCharacterEncoding("UTF-8");

// 指定客户端的解码方式
response.setHeader("content-type", "text/html;charset=UTF-8");
```

以上两端编码的指定也可以使用一句替代，同时指定服务器和客户端

```java
response.setContentType("text/html;charset=UTF-8");
```

2. `getOutputStream()`字节乱码

当服务器端给的字节恰好和客户端使用的编码方式一致时则文本正确显示，否则出现乱码。

```java
// 设置客户端的编码及响应类型
response.setHeader("content-type","text/html;charset=UTF-8");

// 设置文字转换为字节时使用的编码方式
ServletOutputStream out = response.getOutputStream();
out.write("<h2>你好</h2>".getBytes("UTF-8"));
```

同样也可以使用一句替代

```java
// 设置客户端与服务端的编码
response.setContentType("text/html;charset=UTF-8");
```

总结：要想解决响应的乱码，只需要保证使用支持中文的编码格式。并且保证服务器端和客户端使用相同的编码方式即可。




# Cookie对象

Cookie是浏览器提供的一种技术

通过服务器的程序能将一些只须保存在客户端，或者在客户端进行处理的数据，放在本地的计算机上

有一个专门操作Cookie的类 javax.servlet.http.Cookie。随着服务器端的响应发送给客户端，保存在浏览器。当下次再访问服务器时把Cookie再带回服务器。

Cookie 的格式：键值对用“=”链接，多个键值对间通过“；”隔开。

## Cookie的创建和发送

1. 通过 new Cookie("key","value");来创建一个 Cookie 对象

2. 要想将 Cookie 随响应发送到客户端，需要先添加到 response 对象中，response.addCookie(cookie)

3. 此时该 cookie 对象则随着响应发送至了客户端。


```java
// 创建Cookie对象
Cookie cookie = new Cookie("uname","zhangsan");
// 发送Cookie对象
response.addCookie(cookie);
```

## Cookie的获取

在服务器端只提供了一个 getCookies()的方法用来获取客户端回传的所有 cookie 组成的一个数组
- 如果需要获取单个 cookie 则需要通过遍历
- getName()获取 Cookie 的名称
- getValue()获取 Cookie 的值。

```java
// 获取Cookie数组
Cookie[] cookies = request.getCookies();
// 判断数组是否为空
if (cookies != null && cookies.length > 0) {
    // 遍历Cookie数组
    for (Cookie cookie : cookies){
        System.out.println(cookie.getName());
        System.out.println(cookie.getValue());
    }
}
```


## Cookie设置到期时间

到期时间用来指定该 cookie 何时失效。
- 默认为当前浏览器关闭即失效。
- 通过`setMaxAge(int time)`方法手动设定cookie的最大有效时间，以秒为单位。
    - 若为负数，表示不存储该cookie，表示只在浏览器内存中存活，一旦关闭浏览器窗口，那么 cookie 就会消失
    - 若大于 0 的整数，表示存储的秒数。
    - 若为 0，表示删除该 cookie。

```java
// 创建Cookie对象
Cookie cookie = new Cookie("uname","zhangsan");
// 设置Cookie 3天后失效
cookie.setMaxAge(3 * 24 * 60 * 60);
// 发送Cookie对象
response.addCookie(cookie);
```



## Cookie的路径


Cookie的setPath设置cookie的路径，这个路径直接决定服务器的请求是否会从浏览器中加载某些cookie。


```java
/* 当前项目路径为：s01 */
Cookie cookie = new Cookie("xxx","XXX");

// 在当前服务器下任何项目都可访问到Cookie对象
cookie.setPath("/");


// 在当前项目下任何项目都可访问到Cookie对象
cookie.setPath("/s01"); // 默认情况，可不设置path的值


// 在s02项目下才可访问到Cookie对象
cookie.setPath("/s02"); // 只能在s02项目下获取Cookie，就算cookie是s01产生的，s01也不能

// 在s02/cook目录下才可访问到Cookie对象
cookie.setPath("/s01/cook");

response.addCookie(cookie);
```

当访问的路径包含了cookie的路径时，则该请求将带上该cookie；如果访问路径不包含cookie路径，则该请求不会携带该cookie。



## Cookie的注意点

1. Cookie保存在当前浏览器中

2. Cookie不能出现中文

3. 发送重复同名的Cookie会覆盖原有Cookie

4. 浏览器对Cookie的存储是有上限的



# HttpSession对象

HttpSession对象是 javax.servlet.http.HttpSession 的实例

对于服务器而言，每一个连接到它的客户端都是一个 session，servlet 容器使用此接口创建 HTTP 客户端和 HTTP 服务器之间的会话。

会话将保留指定的时间段，跨多个连接或来自用户的页面请求。

一个会话通常对应于一个用户，该用户可能多次访问一个站点。可以通过此接口查看和操作有关某个会话的信息，比如会话标识符、创建时间和最后一次访问时间。

在整个 session 中，最重要的就是属性的操作。

Session 的作用就是为了标识一次会话，或者说确认一个用户；并且在一次会话（一个用户的多次请求）期间共享数据。我们可以通过 request.getSession()方法，来获取当前会话的 session 对象。


```java
// 如果session对象存在，则获取；如果session对象不存在，则创建
HttpSession session = request.getSession();
```

## 标识符JSESSIONID


Session 既然是为了标识一次会话，每个绘画对应一个唯一的标志sessionId

每当一次请求到达服务器，如果开启了会话（访问了 session）
- 服务器第一步会查看是否从客户端回传一个名为 JSESSIONID 的 cookie
- 如果没有则认为这是一次新的会话，会创建 一个新的 session 对象，并用唯一的 sessionId 为此次会话做一个标志
- 如果有 JESSIONID 这 个cookie回传，服务器则会根据 JSESSIONID 这个值去查看是否含有id为JSESSION值的session 对象
- 如果没有则认为是一个新的会话，重新创建一个新的 session 对象，并标志此次会话
- 如果找到了相应的 session 对象，则认为是之前标志过的一次会话，返回该 session 对象，数据达到共享。


这里提到一个叫做 JSESSIONID 的 cookie，这是一个比较特殊的 cookie，当用户请求服务器时，如果访问了 session，则服务器会创建一个名为 JSESSIONID，值为获取到的 session（无论是获取到的还是新创建的）的 sessionId 的 cookie 对象，并添加到 response 对象中，响应给客户端，有效时间为关闭浏览器。

> 所以 Session 的底层依赖 Cookie 来实现。


## session域对象

Session 用来表示一次会话，在一次会话中数据是可以共享的，这时 session 作为域对象存在
- 可以通过 setAttribute(name,value) 方法向域对象中添加数据
- 通过 getAttribute(name) 从域对象中获取数据
- 通过 removeAttribute(name) 从域对象中移除数据。

```java
// 获取session对象
HttpSession session = request.getSession();
// 设置session域对象
session.setAttribute("uname","admin");
// 获取指定名称的session域对象
String uname = (String) request.getAttribute("uname");
// 移除指定名称的session域对象
session.removeAttribute("uname");
```


## session对象的销毁

### 默认时间到期

当客户端第一次请求 servlet 并且操作 session 时，session 对象生成

Tomcat 中 session 默认的存活时间为 30min，即你不操作界面的时间，一旦有操作，session 会重新计时。

session的默认时机可以在 Tomcat 中的 conf 目录下的 web.xml 文件中进行修改

### 自己设定到期时间

通过session.setMaxInactiveInterval(int) 来设定 session 的最大不活动时间，单位为秒。

```java
// 获取session对象
HttpSession session = request.getSession();
// 设置session的最大不活动时间
session.setMaxInactiveInterval(15); // 15秒
```

也可以通过 getMaxInactiveInterval() 方法来查看当前 Session 对象的最大不活动时间。

```java     
// 获取session的最大不活动时间
int time = session.getMaxInactiveInterval();
```


### 立即失效

通过 session.invalidate() 方法让 session 立刻失效
```java
// 销毁session对象
session.invalidate();
```

### 关闭浏览器

从前面的 JESSIONID 可知道，session 的底层依赖 cookie 实现，并且该 cookie 的有效时间为关闭浏览器，从而 session 在浏览器关闭时也相当于失效了（因为没有 JSESSION 再与之对应）。

### 关闭服务器

当关闭服务器时，session 销毁。

# ServletContext对象

每一个 web 应用都有且仅有一个ServletContext 对象，又称 Application 对象，在 WEB 容器启动的时候，会为每一个 WEB 应用程序创建一个对应的
ServletContext 对象。

该对象有两大作用
- 第一、作为域对象用来共享数据，此时数据在整个应用程序中共享
- 第二、该对象中保存了当前应用程序相关信息


## ServletContext对象的获取

```java
// 1. 通过 request 对象获取
ServletContext servletContext = request.getServletContext();


// 2. 通过 session 对象获取
ServletContext servletContext = request.getSession().getServletContext();

// 3. 通过 servletConfig 对象获取，在 Servlet 标准中提供了 ServletConfig 方法
ServletConfig servletConfig = getServletConfig();
ServletContext servletContext = servletConfig.getServletContext();

// 4. 直接获取，Servlet 类中提供了直接获取 ServletContext 对象的方法
ServletContext servletContext = getServletContext();
```

## 常用方法

ServletContext 也可当做域对象来使用，通过向 ServletContext 中存取数据，可以使得整个应用程序共享某些数据。

当然不建议存放过多数据，因为 ServletContext 中的数据一旦存储进去没有手动移除将会一直保存。

```java
// 获取ServletContext对象
ServletContext servletContext = request.getServletContext();
// 设置域对象
servletContext.setAttribute("name","zhangsan");
// 获取域对象
String name = (String) servletContext.getAttribute("name");
// 移除域对象
servletContext.removeAttribute("name");
```


## 总结

Servlet的三大域对象
1. request域对象: 在一次请求中有效。请求转发有效，重定向失效。
2. session域对象: 在一次会话中有效。请求转发和重定向都有效，session销毁后失效。
3. servletContext域对象: 在整个应用程序中有效。服务器关闭后失效。



