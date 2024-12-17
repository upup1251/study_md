[toc]


# JSP标志标签库(JSTL)


Java Server Pages Standard Tag Libray(JSTL)：JSP 标准标签库，是一个定制标签类库的集合，用于解决一些常见的问题，例如迭代一个映射或者集合、条件测试、XML 处理，甚至数据库和访问数据库操作等。



根据JSTL标签所提供的功能，可以将其分为5个类别。
- 核心标签
- 格式化标签
- SQL 标签
- XML 标签
- JSTL 函数

> [!NOTE]
> 这里只做列举，各个标签的详细信息查看[菜鸟教程官网](https://www.runoob.com/jsp/jsp-jstl.html) 


## JSTL库使用


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

下载 jakarta-taglibs-standard-1.1.2.zip 包并解压，将 jakarta-taglibs-standard-1.1.2/lib/ 下的两个 jar 文件：standard.jar 和 jstl.jar 文件拷贝到项目的/WEB-INF/lib/下







## 核心标签

核心标签是最常用的 JSTL标签。引用核心标签库的语法如下：

```java
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
```

包含 Web 应用的常见工作，比如：循环、表达式赋值、基本输入输出等。

| 标签         | 描述                                                                 |
|--------------|--------------------|
| `<c:out>`    | 用于在 JSP 中显示数据，就像 `<%= ... >`                               |
| `<c:set>`    | 用于保存数据                                                        |
| `<c:remove>` | 用于删除数据                                                        |
| `<c:catch>`  | 用来处理产生错误的异常状况，并且将错误信息储存起来                   |
| `<c:if>`     | 与我们在一般程序中用的 `if` 一样                                    |
| `<c:choose>` | 本身只当做 `<c:when>` 和 `<c:otherwise>` 的父标签                    |
| `<c:when>`   | `<c:choose>` 的子标签，用来判断条件是否成立                         |
| `<c:otherwise>` | `<c:choose>` 的子标签，接在 `<c:when>` 标签后，当 `<c:when>` 标签判断为 false 时被执行 |
| `<c:import>` | 检索一个绝对或相对 URL，然后将其内容暴露给页面                      |
| `<c:forEach>` | 基础迭代标签，接受多种集合类型                                      |
| `<c:forTokens>` | 根据指定的分隔符来分隔内容并迭代输出                               |
| `<c:param>`  | 用来给包含或重定向的页面传递参数                                    |
| `<c:redirect>` | 重定向至一个新的 URL                                              |
| `<c:url>`    | 使用可选的查询参数来创造一个 URL                                    |



### 条件动作标签

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


### 循环标签

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


## 格式化标签

JSTL格式化标签提供了格式化和解析数字和日期的功能。引用格式化标签库的语法如下：
```java
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
```
| 标签                   | 描述                                                 |
|------------------------|------------------------------------------------------|
| `<fmt:formatNumber>`   | 使用指定的格式或精度格式化数字                        |
| `<fmt:parseNumber>`    | 解析一个代表着数字、货币或百分比的字符串              |
| `<fmt:formatDate>`     | 使用指定的风格或模式格式化日期和时间                  |
| `<fmt:parseDate>`      | 解析一个代表着日期或时间的字符串                      |
| `<fmt:bundle>`         | 绑定资源                                             |
| `<fmt:setLocale>`      | 指定地区                                             |
| `<fmt:setBundle>`      | 绑定资源                                             |
| `<fmt:timeZone>`       | 指定时区                                             |
| `<fmt:setTimeZone>`    | 指定时区                                             |
| `<fmt:message>`        | 显示资源配置文件信息                                 |
| `<fmt:requestEncoding>`| 设置 request 的字符编码                               |



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


## SQL标签

JSTL SQL标签库提供了与关系型数据库（Oracle，MySQL，SQL Server等等）进行交互的标签。引用SQL标签库的语法如下：
```java
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
```
| 标签                   | 描述                                                             |
|------------------------|------------------------------------------------------------------|
| `<sql:setDataSource>`  | 指定数据源                                                      |
| `<sql:query>`          | 运行 SQL 查询语句                                               |
| `<sql:update>`         | 运行 SQL 更新语句                                               |
| `<sql:param>`          | 将 SQL 语句中的参数设为指定值                                   |
| `<sql:dateParam>`      | 将 SQL 语句中的日期参数设为指定的 `java.util.Date` 对象值        |
| `<sql:transaction>`    | 在共享数据库连接中提供嵌套的数据库行为元素，将所有语句以一个事务的形式来运行 |

## XML 标签

JSTL XML标签库提供了创建和操作XML文档的标签。引用XML标签库的语法如下：
```java
<%@ taglib prefix="x" 
           uri="http://java.sun.com/jsp/jstl/xml" %>
```

在使用xml标签前，你必须将XML 和 XPath 的相关包拷贝至你的<Tomcat 安装目录>\lib下:
- [Download XercesImpl.jar](http://www.apache.org/dist/xerces/j/)
- [Doenload xanlan.jar](http://xml.apache.org/xalan-j/index.html)  


| 标签                   | 描述                                                         |
|------------------------|--------------------------------------------------------------|
| `<x:out>`              | 与 `<%= ... >` 类似，不过只用于 XPath 表达式                  |
| `<x:parse>`            | 解析 XML 数据                                                 |
| `<x:set>`              | 设置 XPath 表达式                                             |
| `<x:if>`               | 判断 XPath 表达式，若为真，则执行本体中的内容，否则跳过本体 |
| `<x:forEach>`          | 迭代 XML 文档中的节点                                         |
| `<x:choose>`           | `<x:when>` 和 `<x:otherwise>` 的父标签                        |
| `<x:when>`             | `<x:choose>` 的子标签，用来进行条件判断                       |
| `<x:otherwise>`        | `<x:choose>` 的子标签，当 `<x:when>` 判断为 false 时被执行   |
| `<x:transform>`        | 将 XSL 转换应用在 XML 文档中                                   |
| `<x:param>`            | 与 `<x:transform>` 共同使用，用于设置 XSL 样式表             |


## JSTL函数


JSTL包含一系列标准函数，大部分是通用的字符串处理函数。引用JSTL函数库的语法如下：
```java
<%@ taglib prefix="fn" 
           uri="http://java.sun.com/jsp/jstl/functions" %>
```

| 函数                     | 描述                                                         |
|--------------------------|--------------------------------------------------------------|
| `fn:contains()`           | 测试输入的字符串是否包含指定的子串                           |
| `fn:containsIgnoreCase()` | 测试输入的字符串是否包含指定的子串，大小写不敏感             |
| `fn:endsWith()`           | 测试输入的字符串是否以指定的后缀结尾                         |
| `fn:escapeXml()`          | 跳过可以作为 XML 标记的字符                                  |
| `fn:indexOf()`            | 返回指定字符串在输入字符串中出现的位置                       |
| `fn:join()`               | 将数组中的元素合成一个字符串然后输出                         |
| `fn:length()`             | 返回字符串长度                                               |
| `fn:replace()`            | 将输入字符串中指定的位置替换为指定的字符串然后返回           |
| `fn:split()`              | 将字符串用指定的分隔符分隔然后组成一个子字符串数组并返回     |
| `fn:startsWith()`         | 测试输入字符串是否以指定的前缀开始                           |
| `fn:substring()`          | 返回字符串的子集                                             |
| `fn:substringAfter()`     | 返回字符串在指定子串之后的子集                               |
| `fn:substringBefore()`    | 返回字符串在指定子串之前的子集                               |
| `fn:toLowerCase()`        | 将字符串中的字符转为小写                                     |
| `fn:toUpperCase()`        | 将字符串中的字符转为大写                                     |
| `fn:trim()`               | 移除首尾的空白符                                             |






# JavaBean

JavaBean 是特殊的 Java 类，使用 Java 语言书写，并且遵守 JavaBean API 规范。

接下来给出的是 JavaBean 与其它 Java 类相比而言独一无二的特征：
- 提供一个默认的无参构造函数
- 需要被序列化并且实现了 Serializable 接口
- 可能有一系列可读写属性
- 可能有一系列的 getter 或 setter 方法
> JavaBean对象的属性通过这两个方法来读写

## 获取JavaBean

\<jsp:useBean>标签可以在JSP中声明一个JavaBean，然后使用。
> 声明后，JavaBean 对象就成了脚本变量，可以通过脚本元素或其他自定义标签来访问。

\<jsp:useBean> 标签的语法格式如下：
```html
<jsp:useBean id="bean 的名字" class="bean 编译的类" scope="bean 的作用域" typeSpec/>
```

根据具体情况，scope 的值可以是
- page
- request
- session
- application    
id值可任意只要不和同一JSP文件中其它\<jsp:useBean>中i 值一样就行了。


## 访问 JavaBean 对象的属性

在\<jsp:useBean>标签主体中使用
- \<jsp:getProperty/>标签来调用getter方法
- 使用\<jsp:setProperty/> 标签来调用setter方法   

语法格式如下：
```html
<jsp:useBean id="id" class="bean 编译的类" scope="bean 作用域">
   <jsp:setProperty name="bean 的 id" property="属性名" value="value"/>
   <jsp:getProperty name="bean 的 id" property="属性名"/>
   ...........
</jsp:useBean>
```



# jsp自定义标签

自定义标签是用户定义的JSP语言元素。

当JSP页面包含一个自定义标签时将被转化为servlet，标签转化为对被称为tag handler的对象的操作，即当servlet执行时Web container调用那些操作。


你可以继承SimpleTagSupport类并重写的doTag()方法来开发一个最简单的自定义标签。


## 创建标签

1. 要创建自定义的JSP标签，你首先必须创建处理标签的Java类。

```java
package com.runoob;

import javax.servlet.jsp.tagext.*;
import javax.servlet.jsp.*;
import java.io.*;

public class TagName extends SimpleTagSupport {

  public void doTag() throws JspException, IOException {
    JspWriter out = getJspContext().getOut();
    out.println("Hello Custom Tag!");
  }
}




```


2. 编译以上类，并将其复制到环境变量CLASSPATH目录中
3. 最后创建如下标签库：\<Tomcat安装目录>webapps\ROOT\WEB-INF\custom.tld。

```xml
<taglib>
  <tlib-version>1.0</tlib-version>
  <jsp-version>2.0</jsp-version>
  <short-name>Example TLD</short-name>
  <tag>
    <name>标签名</name>
    <tag-class>包名.类名</tag-class>
    <body-content>empty</body-content>
  </tag>
</taglib>
```







# jsp EL表达式语言

JSP表达式语言EL(Expression Language)
- 使 JSP 写起来更加简单
- 操作的都是域对象中的数据，操作不了局部变量。
    - 当需要指定从某个特定的域对象中查找数据时可以使用四个域对象对应的空间对象，分别是：pageScope, requestScope, sessionScope, applicationScope。
    - 而EL默认的查找方式为从小到大查找。当域对象全找完了还未找到则返回空字符串""
- EL表达式支持大部分Java所提供的算术和逻辑操作符：


JSP EL允许您指定一个表达式来表示标签中的属性值，或标签的模版文本中的值

```java
${java_expression}
```

> 当JSP编译器在属性中见到"${}"格式后，它会产生代码来计算这个表达式，并且产生一个替代品来代替表达式的值

## empty


判断域对象是否为空
- 为空，返回true
- 不为空返回false；

```java
${empty variable}
```



## EL中的函数

JSP EL允许您在表达式中使用函数。这些函数必须被定义在自定义标签库中。函数的使用语法如下：
```java
${ns:func(param1, param2, ...)}
```

- ns指的是命名空间（namespace）
- func指的是函数的名称
- param1指的是第一个参数，param2指的是第二个参数...

要使用任何标签库中的函数，您需要将这些库安装在服务器中，然后使用\<taglib>标签在JSP文件中包含这些库。


## EL隐含对象

JSP EL支持下表列出的隐含对象：

| 隐含对象        | 描述                              |
|----------------|---------------------------------|
| `pageScope`    | `page` 作用域                    |
| `requestScope` | `request` 作用域                 |
| `sessionScope` | `session` 作用域                 |
| `applicationScope` | `application` 作用域         |
| `param`        | `Request` 对象的参数，字符串       |
| `paramValues`  | `Request` 对象的参数，字符串集合   |
| `header`       | HTTP 信息头，字符串                |
| `headerValues` | HTTP 信息头，字符串集合            |
| `initParam`    | 上下文初始化参数                    |
| `cookie`       | `Cookie` 值                       |
| `pageContext`  | 当前页面的 `pageContext`          |


您可以在表达式中使用这些对象，就像使用变量一样。

接下来会给出几个例子来更好的理解这个概念。

1. pageContext对象

pageContext对象是JSP中pageContext对象的引用。通过pageContext对象，您可以访问request对象。
```java
${pageContext.request.request_attritube}
```


2. Scope对象

pageScope，requestScope，sessionScope，applicationScope变量用来访问存储在各个作用域层次的变量。

举例来说，如果您需要显式访问在applicationScope层的box变量，可以这样来访问：applicationScope.box。


3. param和paramValues对象

param和paramValues对象用来访问参数值，通过使用request.getParameter方法和request.getParameterValues方法。

举例来说，访问一个名为order的参数，可以这样使用表达式：${param.order}，或者${param\["order"]}。

param对象返回单一的字符串，而paramValues对象则返回一个字符串数组。


4. header和headerValues对象

header和headerValues对象用来访问信息头，通过使用 request.getHeader方法和request.getHeaders方法。

举例来说，要访问一个名为user-agent的信息头，可以这样使用表达式：${header.user-agent}，或者${header\["user-agent"]}。

header对象返回单一值，而headerValues则返回一个字符串数组。





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

