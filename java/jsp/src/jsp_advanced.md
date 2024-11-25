[toc]


# JSP标志标签库(JSTL)

JSP标准标签库（JSTL）是一个JSP标签集合，它封装了JSP应用的通用核心功能。


JSTL支持通用的、结构化的任务，比如迭代，条件判断，XML文档操作，国际化标签，SQL标签。 除了这些，它还提供了一个框架来使用集成JSTL的自定义标签。


根据JSTL标签所提供的功能，可以将其分为5个类别。
- 核心标签
- 格式化标签
- SQL 标签
- XML 标签
- JSTL 函数

> [!NOTE]
> 这里只做列举，各个标签的详细信息查看[菜鸟教程官网](https://www.runoob.com/jsp/jsp-jstl.html) 


## JSTL库安装

Apache Tomcat安装JSTL 库步骤如下：
- 从Apache的标准标签库中下载二进包(jakarta-taglibs-standard-current.zip)。
- 将jakarta-taglibs-standard-1.1.2/lib/下的两个jar文件：standard.jar 和 jstl.jar 文件拷贝到 /WEB-INF/lib/ 下。
- 将 tld 下的需要引入的 tld 文件复制到 WEB-INF 目录下。
- 接下来在 web.xml 文件中添加以下配置：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="2.4" 
    xmlns="http://java.sun.com/xml/ns/j2ee" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee 
        http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">
    <jsp-config>
    <taglib>
    <taglib-uri>http://java.sun.com/jsp/jstl/fmt</taglib-uri>
    <taglib-location>/WEB-INF/fmt.tld</taglib-location>
    </taglib>
    <taglib>
    <taglib-uri>http://java.sun.com/jsp/jstl/fmt-rt</taglib-uri>
    <taglib-location>/WEB-INF/fmt-rt.tld</taglib-location>
    </taglib>
    <taglib>
    <taglib-uri>http://java.sun.com/jsp/jstl/core</taglib-uri>
    <taglib-location>/WEB-INF/c.tld</taglib-location>
    </taglib>
    <taglib>
    <taglib-uri>http://java.sun.com/jsp/jstl/core-rt</taglib-uri>
    <taglib-location>/WEB-INF/c-rt.tld</taglib-location>
    </taglib>
    <taglib>
    <taglib-uri>http://java.sun.com/jsp/jstl/sql</taglib-uri>
    <taglib-location>/WEB-INF/sql.tld</taglib-location>
    </taglib>
    <taglib>
    <taglib-uri>http://java.sun.com/jsp/jstl/sql-rt</taglib-uri>
    <taglib-location>/WEB-INF/sql-rt.tld</taglib-location>
    </taglib>
    <taglib>
    <taglib-uri>http://java.sun.com/jsp/jstl/x</taglib-uri>
    <taglib-location>/WEB-INF/x.tld</taglib-location>
    </taglib>
    <taglib>
    <taglib-uri>http://java.sun.com/jsp/jstl/x-rt</taglib-uri>
    <taglib-location>/WEB-INF/x-rt.tld</taglib-location>
    </taglib>
    </jsp-config>
</web-app>
``` 
- 使用任何库，你必须在每个 JSP 文件中的头部包含 \<taglib> 标签。


## 核心标签

核心标签是最常用的 JSTL标签。引用核心标签库的语法如下：
```java
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
```
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


## 格式化标签

JSTL格式化标签用来格式化并输出文本、日期、时间、数字。引用格式化标签库的语法如下：
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







# jsp表达式语言

JSP表达式语言（EL）使得访问存储在JavaBean中的数据变得非常简单。JSP EL既可以用来创建算术表达式也可以用来创建逻辑表达式。

JSP EL允许您指定一个表达式来表示标签中的属性值，或标签的模版文本中的值

```java
${expr}
```

expr指的是表达式。在JSP EL中通用的操作符是 . 和 {} 。这两个操作符允许您通过内嵌的JSP对象访问各种各样的JavaBean属性。


当JSP编译器在属性中见到"${}"格式后，它会产生代码来计算这个表达式，并且产生一个替代品来代替表达式的值


## EL中的基础操作符

EL表达式支持大部分Java所提供的算术和逻辑操作符：


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






