<!-- ~/study_md/java/jsp/src/jsp.md -->

JSP and JSTL

# JSP

JSP：Java Server Page,SUN公司提供的动态网页编程技术，是Java Web服务器端的动态资源。

- 相比 html 而言，html 只能为用户提供静态数据，而 Jsp 技术允许在页面中嵌套 java 代码，为用户提供动态数据。
- 相比 servlet 而言，servlet 很难对数据进行排版，而 jsp 除了可以用 java 代码产生动态数据的同时，也很容易对数据进行排版

不管是 JSP 还是 Servlet，虽然都可以用于开发动态 web 资源。在长期的软件实践中，人们逐渐把 servlet 作为 web 应用中的控制器组件来使用， 而把 JSP 技术作为数据显示模板来使用。

其实 Jsp 就是一个 Servlet，当我们第一次访问 Jsp 的时候，Jsp 引擎都会将这个 Jsp 翻译 成一个Servlet，这个文件存放在tomcat（源码目录） 中的 work 目录中。



## scriplet脚本小程序

在 JSP 中最重要的部分就是 Scriptlet（脚本小程序），所有嵌入在 HTML 代码中的 Java 程序，都必须使用 Scriptlet 标记出来

在 JSP 中一共有三种 Scriptlet 代码

- `<% %>`：  java 脚本段，可以定义局部变量、编写语句
- `<%! %>`： 声明，可以定义全局（成员）变量、方法、类
- `<%= %>`： 表达式，数据一个变量或具体内容

## jsp的指令标签

1. include静态包含


静态包含就是将内容进行了直接的替换，就好比程序中定义的变量一样，是在 servlet 引擎转译时，就把此文件内容包含了进去（两个文件的源代码整合到一起， 全部放到_jspService 方法中）

```java 
<%@ include file="要包含的文件路径" %> <!-- 相对路径 -->
```


2. include动态包含

动态包含在代码的编译阶段，包含和被包含部分是两个独立的部分，只有当运行时，才会动态包含进来，好比方法的调用。

```html
<jsp:include page="include.jsp"></jsp:include>
```


使用动态包含还可以通过在页面之间传参。

```html
<!-- 包含的页面 -->
<jsp:include page="hello.jsp" flush="true">
    <jsp:param name="uname" value="zhangsan"/>
</jsp:include>


<!-- 被包含的页面 -->
<!-- hello.jsp -->
<!-- 接收参数 -->
<%=request.getParameter("uname")%>
```


## jsp四大域对象

在JSP中提供了四种属性的保存范围，所谓的属性保存范围，指的就是一个设置的对象，可以再多少个页面中保存并可以继续使用

### 对象


- pageContext : 只在一个页面中保存属性，跳转之后无效
- request : 只在一次请求中保存，服务器跳转后依然有效
- session : 在一次会话范围中，服务器跳转和客户端跳转都可以使用
- application : 在整个服务器上保存

### 方法

| 方法 | 描述 |
| --- | --- |
| public void seteAttribute(String name,Object o) | 设置属性的名称和内容 |
| public Object getAttribute(String name) | 根据属性名称获取属性 |
| public void removeAttrubute(String name) | 删除指定的属性 |




## EL表达式


EL（Expression Language） 
- 为了使 JSP 写起来更加简单
- 操作的都是域对象中的数据，操作不了局部变量。
    - 当需要指定从某个特定的域对象中查找数据时可以使用四个域对象对应的空间对象，分别是：pageScope, requestScope, sessionScope, applicationScope。
    - 而EL默认的查找方式为从小到大查找。当域对象全找完了还未找到则返回空字符串""

```java
${java_expression}
```


### empty

判断域对象是否为空
- 为空，返回true
- 不为空返回false；

```java
${empty variable}
```


### EL运算


1. 大小相等

比较两个值是否满足某个条件，返回true或false

- `==`/`eq`
- `>`
- `<`
- `>=`
- `<=`

2. 算数运算

- `+`
- `-`
- `*`
- `/`/`div`



# JSTL

Java Server Pages Standard Tag Libray(JSTL)：JSP 标准标签库，是一个定制标签类库的集合，用于解决一些常见的问题，例如迭代一个映射或者集合、条件测试、XML 处理，甚至数据库和访问数据库操作等。


## 介绍

我们现在只讨论 JSTL 中最重要的标签，迭代集合以及格式化数字和日期几个标签。

1. 标签库

- 核心标签库
    
    [jstl/core](http://java.sun.com/jsp/jstl/core) 
    包含 Web 应用的常见工作，比如：循环、表达式赋值、基本输入输出等。

- 格式化标签库

    [jsp/jstl/fmt](http://java.sun.com/jsp/jstl/fmt) 
    用来格式化显示数据的工作，比如：对不同区域的日期格式化等。


2. 标签库的使用

为了在 JSP 页面使用 JSTL 类库，必须以下列格式使用 taglib 指令：

```java
<%@taglib uri="" prefix="" %>

// 例如：
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
```

前缀prefix可以是任意内容，遵循规范可以使团队中由不同人员编写的代码更加相似；所以，建议使用事先设计好的前缀


此时需要导入两个jar 包
- `jstl.jar`
- `standard.jar`
[download](http://archive.apache.org/dist/jakarta/taglibs/standard/binaries/) 

下载 jakarta-taglibs-standard-1.1.2.zip 包并解压，将 jakarta-taglibs-standard-1.1.2/lib/ 下的两个 jar 文件：standard.jar 和 jstl.jar 文件拷贝到项目的指定目录下。



## 条件动作标签

条件动作指令用于处理页面的输出结果依赖于某些输入值的情况
1. if标签

- if 标签先对某个条件进行测试，如果该条件运算结果为 true, 则处理它的主体内容
- 测试结果保存在一个 Boolean 对象中，并创建一个限域变量来引用 Boolean 对象
- 可以利用 var 属性设置限域变量名，利用 scope 属性来指定其作用范围。

```html
<c:if test="<boolean>" var="<string>" scope="<string>">
    ...
</c:if>
```

if 标签的属性:
| 属性 | 描述 | 是否必要 | 默认值 |
| --- | --- | --- | --- |
| `test` | 条件 | 是 | 无 |
| `var` | 存储条件结果的变量（限域变量名） | 否 | 无 |
| `scope` | var属性的作用域（可取四大域对象） | 否 | page |


> JSTL中没有else标签，为了模拟 else 的情景，需要使用两个 if 标签，并且这两个标签为相反的条件。


示例：
```html
<%
    request.setAttribute("flag",true);
    request.setAttribute("num",1);
%>
<c:if test="${flag}">
    <p>结果为true<p>
</c:if>
<c:if test="${num > 0}">
    <p>num的值比0大<p>
</c:if>
```


2. choose,when和otherwise标签

choose 和 when 标签的作用与 Java 中的 switch 和 case 关键字相似，用于在众多选项中做出选择。也就是说：他们为相互排斥的条件式执行提供相关内容。

```html
<c:choose>

    <c:when test="<boolean>">
        ...
    </c:when>

    <c:when test="<boolean>">
        ...
    </c:when>

    ...
    ...

    <c:otherwise>
        ...
    </c:otherwise>

</c:choose>
```

- `choose`标签没有属性
- `when`标签只有一个test属性
- `otherwise`标签没有属性
- choose标签中必须有至少一个when标签，可以没有otherwise标签
- otherwise标签必须放在最后一个when标签之后
- choose标签中只能有when标签和otherwise标签，when标签和otherwise标签可以嵌套其他标签


## 循环标签

```html
<c:forEach
    items="<object>"
    begin="<int>"
    end="<int>"
    step="<int>"
    var="<string>"
    varStatus="<string>">
</c:forEach>
```

| 属性 | 描述 | 是否必要 | 默认值 |
| --- | --- | --- | --- |
| `items` | 要被循环的数据 | 否 | 无 |
| `begin` | 开始元素下标 | 否 | 0 |
| `end` | 最后一个元素下表 | 否 | Last emelent |
| `step` | 每次迭代的步长 | 否 | 1 |
| `var` | 代表当前条目的变量名称 | 否 | 无 |
| `varStatus` | 代表循环状态的变量名称 | 否 | 无 |


for forEach varStatus 属性
- index: 当前这次迭代从 0 开始的迭代索引
- count: 当前这次迭代从 1 开始的迭代计数
- first: 用来表明当前这轮迭代是否为第一次迭代的标志
- last: 用来表明当前这轮迭代是否为最后一次迭代的标志




## 格式化动作标签

JSTL 提供了格式化和解析数字和日期的标签

### formatNumber标签

formatNumber标签用于格式化数字，百分比，货币。该标签用指定的格式或精度来格式化数字。（将数值型数据转换成指定格式的字符串类型。）

```html
<fmt:formatNumber
    value="<string>"
    type="<string>"
    var="<string>"
    scope="<string>"/>
```

行数: 4
| 属性 | 描述 | 是否必要 | 默认值 |
| --- | --- | --- | --- |
| `value` | 要显示的数字 | 是 | 无 |
| `type` | NUMBER,CURRENCY,PERCENT | 否 | NUMBER |
| `var` | 存储格式化数字的变量 | 否 | Print to page |
| `scope` | var属性的作用域 | 否 | page |

- 如果设置了var属性，则格式化后的结果不会输出，需要通过el表达式获取var对应的限域变量名
- number数值型、percent百分比类型、currency货币型

### formatDate标签

formatDate标签用于使用不同的方式格式化日期。（将Date型数据转换成指定格式的字符串类型。）

```java
<fmt:formatDate
    value="<string>"
    type="<string>"
    dateStyle="<string>"
    timeStyle="<string>"
    pattern="<string>"
    timeZone="<string>"
    var="<string>"
    scope="<string>"/>
```

| 属性       | 描述                      | 是否必要 | 默认值       |
|------------|--------------|----------|-------|
| value      | 要显示的日期              | 是       | 无           |
| type       | DATE, TIME, 或 BOTH       | 否       | date         |
| dateStyle  | FULL, LONG, MEDIUM, SHORT, 或 DEFAULT | 否 | default      |
| timeStyle  | FULL, LONG, MEDIUM, SHORT, 或 DEFAULT | 否 | default      |
| pattern    | 自定义格式模式            | 否       | 无           |
| timeZone   | 显示日期的时区            | 否       | 默认时区     |
| var        | 存储格式化日期的变量名    | 否       | 显示在页面   |
| scope      | 存储格式化日志变量的范围  | 否       | 页面         |


### parseNumber标签

parseNumber标签用来解析数字，百分数，货币。（parseNumber 标签可以将数字、货币或百分比类型的字符串转换成数值型。）

```java
<fmt:parseNumber
    value="<string>"
    type="<string>"
    var="<string>"
    scope="<string>"/>
```

| 属性 | 描述 | 是否必要 | 默认值 |
| --- | --- | --- | --- |
| `value` | 要解析的数字 | 否 | Body |
| `type` | NUMBER,CURRENCY,PERCENT | 否 | number |
| `var` | 存储待解析数字的变量 | 否 | Print to page |
| `scope` | var属性的作用域 | 否 | page |


### parseDate标签

parseDate标签用于解析日期。（将指定格式的字符串转换成Date类型。）

```java
<fmt:parseDate
    value="<string>"
    type="<string>"
    dateStyle="<string>"
    timeStyle="<string>"
    pattern="<string>"
    var="<string>"
    scope="<string>"/>
```

| 属性      | 描述                      | 是否必要 | 默认值       |
|-----------|---------------------------|----------|--------------|
| value     | 要显示的日期              | 是       | 无           |
| type      | DATE, TIME, 或 BOTH       | 否       | date         |
| dateStyle | FULL, LONG, MEDIUM, SHORT, 或 DEFAULT | 否 | default      |
| timeStyle | FULL, LONG, MEDIUM, SHORT, 或 DEFAULT | 否 | default      |
| pattern   | 自定义格式模式            | 否       | 无           |
| var       | 存储格式化日期的变量名    | 否       | 显示在页面   |
| scope     | 存储格式化日志变量的范围  | 否       | 页面         |


# 过滤器和监听器

## 过滤器

### 介绍


Filter 即为过滤，用于在 Servlet 之外对 Request 或者 Response 进行修改。

它主要用于对用户请求进行预处理，也可以对 HttpServletResponse 进行后处理。

使用 Filter 的完整流程
- Filter 对用户请求进行预处理
- 接着将请求交给 Servlet 进行处理并生成响应
- 最后 Filter 再 对服务器响应进行后处理  
 在一个 web 应用中，可以开发编写多个 Filter，这些 Filter 组合 起来称之为一个 Filter 链。


若是一个过滤器链：先配置先执行(请求时的执行顺序)；响应时: 以相反的顺序执行。




### 实现

通过实现一个叫做javax.servlet.Fileter的接口来实现一个过滤器，其中定义了 三个方法，`init()`,`doFilter()`, `destroy()`分别在相应的时机执行

Filter 的实现只需要两步：
- 编写 java 类实现 Filter 接口，并实现其 doFilter 方法。
- 通过@WebFilter注解设置它所能拦截的资源。

```java
@WebFilter("/*")
public class Filter01 implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
            
    }

    @Override
    public void destroy() {

    }

}
```

Filter 接口中有一个 doFilter 方法，当开发人员编写好 Filter，并配置对哪个 web 资源进行拦截后

Web 服务器每次在调用 web 资源的 service 方法之前，都会先调用一下 filter 的 doFilter 方法

因此可以达到如下效果
- 调用目标资源之前，让一段代码执行
- 是否调用目标资源（即是否让用户访问 web 资源）。


web 服务器在调用 doFilter 方法时，会传递一个 filterChain 对象进来，filterChain 对象是 filter 接口中最重要的一个对象，它提供了一个 doFilter 方法，开发人员可以根据需求决定 是否调用此方法
- 调用该方法，则 web 服务器就会调用 web 资源的 service 方法，即 web 资源就会被访问
- 否则 web 资源不会被访问
> 本质是放行，调用doFilter方法后，即请求可以到达资源


## 监听器

web 监听器是Servlet 中一种的特殊的类，能帮助开发者监听 web 中的特定事件， 比如ServletContext，HttpSession，ServletRequest 的创建和销毁；变量的创建、销毁和修改等。 可以在某些动作前后增加处理，实现监控。

### 三种八类

实现监听器的接口有三种八类

- 监听生命周期
    - `ServletRequestListener`
    - `HttpSessionListener`
    - `ServletContextListener`
- 监听值的变化
    - `ServletRequestAttributeListener`
    - `HttpSessionAttributeListener`
    - `ServletContextAttributeListener`
- 针对session中的对象
    - 监听 session 中的 java 对象(javaBean) ，是 javaBean 直接实现监听器 的接口。


### 实现

1. 创建一个监听器，需要实现某种接口
    > 不同的接口实现了不同的方法，当监听对象发生变化时，会自动调用实现了该接口的实例的Override方法

2. 重写接口中的方法

2. 通过@WebListener注解配置该监听器

