
[toc]

# 客户端响应

当浏览器请求一个网页时，它会向网络服务器发送一系列不能被直接读取的信息，因为这些信息是作为HTTP信息头的一部分来传送的。

## 浏览器信息头部

下表列出了浏览器端信息头的一些重要内容，在以后的网络编程中将会经常见到这些信息：
- `Accept`: 指定浏览器或其他客户端可以处理的MIME类型。它的值通常为 image/png 或 image/jpeg
> MIME类型（Multipurpose Internet Mail Extensions，通用互联网邮件扩展）是一种标准，用于指示文件的性质和格式。它允许客户端（如Web浏览器）知道如何处理不同类型的文件。  
> MIME类型通常由两部分组成，格式为 类型/子类型

- `Accept-Charset`: 指定浏览器要使用的字符集。比如 ISO-8859-1
- `Accept-Encoding`: 指定编码类型。它的值通常为 gzip 或compress
- `Accept-Language`: 指定客户端首选语言，servlet会优先返回以当前语言构成的结果集，如果servlet支持这种语言的话。比如 en，en-us，ru等等
- `Authorization`: 在访问受密码保护的网页时识别不同的用户

- `Connection`: 表明客户端是否可以处理HTTP持久连接。
> 持久连接允许客户端或浏览器在一个请求中获取多个文件。Keep-Alive 表示启用持久连接
- `Content-Length`: 仅适用于POST请求，表示 POST 数据的字节数
- `Cookie`: 返回先前发送给浏览器的cookies至服务器
- `Host`: 指出原始URL中的主机名和端口号
- `If-Modified-Since`: 表明只有当网页在指定的日期被修改后客户端才需要这个网页。 服务器发送304码给客户端，表示没有更新的资源
- `If-Unmodified-Since`: 与If-Modified-Since相反， 只有文档在指定日期后仍未被修改过，操作才会成功
- `Referer`: 标志着所引用页面的URL。比如，如果你在页面1，然后点了个链接至页面2，那么页面1的URL就会包含在浏览器请求页面2的信息头中
- `User-Agent`: 用来区分不同浏览器或客户端发送的请求，并对不同类型的浏览器返回不同的内容


## `HttpServletRequest`类

request对象是javax.servlet.http.HttpServletRequest类的实例。每当客户端请求一个页面时，JSP引擎就会产生一个新的对象来代表这个请求。

request对象提供了一系列方法来获取HTTP信息头，包括表单数据，cookies，HTTP方法等等。

接下来将会介绍一些在JSP编程中常用的获取HTTP信息头的方法。详细内容请见下表：

- `Cookie[] getCookies()`: 返回客户端所有的Cookie的数组
- `Enumeration getAttributeNames()`: 返回request对象的所有属性名称的集合
- `Enumeration getHeaderNames()`: 返回所有HTTP头的名称集合
- `Enumeration getParameterNames()`: 返回请求中所有参数的集合
- `HttpSession getSession()`: 返回request对应的session对象，如果没有，则创建一个
- `HttpSession getSession(boolean create)`: 返回request对应的session对象，如果没有并且参数create为true，则返回一个新的session对象
- `Locale getLocale()`: 返回当前页的Locale对象，可以在response中设置
- `Object getAttribute(String name)`: 返回名称为name的属性值，如果不存在则返回null。
- `ServletInputStream getInputStream()`: 返回请求的输入流
- `String getAuthType()`: 返回认证方案的名称，用来保护servlet，比如 "BASIC" 或者 "SSL" 或 null 如果 JSP没设置保护措施
- `String getCharacterEncoding()`: 返回request的字符编码集名称
- `String getContentType()`: 返回request主体的MIME类型，若未知则返回null
- `String getContextPath()`: 返回request URI中指明的上下文路径
- `String getHeader(String name)`: 返回name指定的信息头
- `String getMethod()`: 返回此request中的HTTP方法，比如 GET,，POST，或PUT
- `String getParameter(String name)`: 返回此request中name指定的参数，若不存在则返回null
- `String getPathInfo()`: 返回任何额外的与此request URL相关的路径
- `String getProtocol()`: 返回此request所使用的协议名和版本
- `String getQueryString()`: 返回此 request URL包含的查询字符串
- `String getRemoteAddr()`: 返回客户端的IP地址
- `String getRemoteHost()`: 返回客户端的完整名称
- `tring getRemoteUser()`: 返回客户端通过登录认证的用户，若用户未认证则返回null
- `String getRequestURI()`: 返回request的URI
- `String getRequestedSessionId()`: 返回request指定的session ID
- `String getServletPath()`: 返回所请求的servlet路径
- `String[] getParameterValues(String name)`: 返回指定名称的参数的所有值，若不存在则返回null
- `boolean isSecure()`: 返回request是否使用了加密通道，比如HTTPS
- `int getContentLength()`: 返回request主体所包含的字节数，若未知的返回-1
- `int getIntHeader(String name)`: 返回指定名称的request信息头的值
- `int getServerPort()`: 返回服务器端口号


# 服务器响应

Response响应对象主要将JSP容器处理后的结果传回到客户端。可以通过response变量设置HTTP的状态和向客户端发送数据，如Cookie、HTTP文件头信息等。



## HTTP1.1响应头

HTTP1.1响应头中最有用的部分，在网络编程中您将会经常见到它们:
- `Allow`: 指定服务器支持的request方法（GET，POST等等）
- `Cache-Control`: 指定响应文档能够被安全缓存的情况。通常取值为 public，private 或no-cache 等等。
> Public意味着文档可缓存，Private意味着文档只为单用户服务并且只能使用私有缓存。No-cache 意味着文档不被缓存。
- `Connection`: 命令浏览器是否要使用持久的HTTP连接。
> close值 命令浏览器不使用持久HTTP连接，而keep-alive 意味着使用持久化连接。
- `Content-Disposition`: 让浏览器要求用户将响应以给定的名称存储在磁盘中
- `Content-Encoding`: 指定传输时页面的编码规则
- `Content-Language`: 表述文档所使用的语言，比如en， en-us,，ru等等
- `Content-Length`: 表明响应的字节数。只有在浏览器使用持久化 (keep-alive) HTTP 连接时才有用
- `Content-Type`: 表明文档使用的MIME类型
- `Expires`: 指明啥时候过期并从缓存中移除
- `Last-Modified`: 指明文档最后修改时间。客户端可以 缓存文档并且在后续的请求中提供一个 If-Modified-Since请求头
- `Location`: 在300秒内，包含所有的有一个状态码的响应地址，浏览器会自动重连然后检索新文档
- `Refresh`: 指明浏览器每隔多久请求更新一次页面。
- `Retry-After`: 与503 (Service Unavailable)一起使用来告诉用户多久后请求将会得到响应
- `Set-Cookie`: 指明当前页面对应的cookie


## `HttpServletResponse`类

response 对象是 javax.servlet.http.HttpServletResponse 类的一个实例。就像服务器会创建request对象一样，它也会创建一个客户端响应。

response对象定义了处理创建HTTP信息头的接口。通过使用这个对象，开发者们可以添加新的cookie或时间戳，还有HTTP状态码等等。

下表列出了用来设置HTTP响应头的方法，这些方法由HttpServletResponse 类提供：
- `String encodeRedirectURL(String url)`: 对sendRedirect()方法使用的URL进行编码
- `String encodeURL(String url)`: 将URL编码，回传包含Session ID的URL
- `boolean containsHeader(String name)`: 返回指定的响应头是否存在
- `boolean isCommitted()`: 返回响应是否已经提交到客户端
- `void addCookie(Cookie cookie)`: 添加指定的cookie至响应中
- `void addDateHeader(String name, long date)`: 添加指定名称的响应头和日期值
- `void addHeader(String name, String value)`: 添加指定名称的响应头和值
- `void addIntHeader(String name, int value)`: 添加指定名称的响应头和int值
- `void flushBuffer()`: 将任何缓存中的内容写入客户端
- `void reset()`: 清除任何缓存中的任何数据，包括状态码和各种响应头
- `void resetBuffer()`: 清除基本的缓存数据，不包括响应头和状态码
- `void sendError(int sc)`: 使用指定的状态码向客户端发送一个出错响应，然后清除缓存
- `void sendError(int sc, String msg)`: 使用指定的状态码和消息向客户端发送一个出错响应
- `void sendRedirect(String location)`: 使用指定的URL向客户端发送一个临时的间接响应
- `void setBufferSize(int size)`: 设置响应体的缓存区大小
- `void setCharacterEncoding(String charset)`: 指定响应的编码集（MIME字符集），例如UTF-8
- `void setContentLength(int len)`: 指定HTTP servlets中响应的内容的长度，此方法用来设置 HTTP Content-Length 信息头
- `void setContentType(String type)`: 设置响应的内容的类型，如果响应还未被提交的话
- `void setDateHeader(String name, long date)`: 使用指定名称和日期设置响应头的名称和日期
- `void setHeader(String name, String value)`: 使用指定名称和值设置响应头的名称和内容
- `void setIntHeader(String name, int value)`: 指定 int 类型的值到 name 标头
- `void setLocale(Locale loc)`: 设置响应的语言环境，如果响应尚未被提交的话
- `void setStatus(int sc)`: 设置响应的状态码



# HTTP状态码

HTTP请求与HTTP响应的格式相近，都有着如下结构：
- 以状态行+CRLF（回车换行）开始
- 零行或多行头模块+CRLF
- 一个空行，比如CRLF
- 可选的消息体比如文件，查询数据，查询输出


## 状态码

状态行包含HTTP版本，一个状态码，和状态码相对应的短消息。
|状态码 |	消息 |	描述 |
|--- | --- | --- |
| 100 |	Continue	| 只有一部分请求被服务器接收，但只要没被服务器拒绝，客户端就会延续这个请求 |
| 101 |	Switching Protocols	| 服务器交换机协议 |
| 200 |	OK	| 请求被确认 |
| 201 |	Created	| 请求时完整的，新的资源被创建 |
| 202 |	Accepted	| 请求被接受，但未处理完 |
| 203 |	Non-authoritative  Information |	  |
| 204 |	No  Content	 | |
| 205 |	Reset  Content|	  |
| 206 |	Partial  Content|	  |
| 300 |	Multiple Choices	| 一个超链接表，用户可以选择一个超链接并访问，最大支持5个超链接 |
| 301 |	Moved Permanently	| 被请求的页面已经移动到了新的URL下 |
| 302 |	Found	| 被请求的页面暂时性地移动到了新的URL下 |
| 303 |	See Other	| 被请求的页面可以在一个不同的URL下找到 |
| 304 |	Not  Modified|	  |
| 305 |	Use  Proxy|	  |
| 306 |	Unused	| 已经不再使用此状态码，但状态码被保留 |
| 307 |	Temporary Redirect	| 被请求的页面暂时性地移动到了新的URL下 |
| 400 |	Bad Request	| 服务器无法识别请求 |
| 401 |	Unauthorized	| 被请求的页面需要用户名和密码 |
| 402 |	Payment Required	| 目前还不能使用此状态码 |
| 403 |	Forbidden	| 禁止访问所请求的页面 |
| 404 |	Not Found	| 服务器无法找到所请求的页面 |
| 405 |	Method Not Allowed	| 请求中所指定的方法不被允许 |
| 406 |	Not Acceptable	| 服务器只能创建一个客户端无法接受的响应 |
| 407 |	Proxy Authentication Required	| 在请求被服务前必须认证一个代理服务器 |
| 408 |	Request Timeout	| 请求时间超过了服务器所能等待的时间，连接被断开 |
| 409 |	Conflict	| 请求有矛盾的地方 |
| 410 |	Gone	| 被请求的页面不再可用 |
| 411 |	Length Required	| "Content-Length"没有被定义，服务器拒绝接受请求 |
| 412 |	Precondition Failed	| 请求的前提条件被服务器评估为false |
| 413 |	Request Entity Too Large	| 因为请求的实体太大，服务器拒绝接受请求 |
| 414 |	Request-url Too Long	| 服务器拒绝接受请求，因为URL太长。多出现在把"POST"请求转换为"GET"请求时所附带的大量查询信息 |
| 415 |	Unsupported Media Type	| 服务器拒绝接受请求，因为媒体类型不被支持 |
| 417 |	Expectation  Failed|	  |
| 500 |	Internal Server Error	| 请求不完整，服务器遇见了出乎意料的状况 |
| 501 |	Not Implemented	| 请求不完整，服务器不提供所需要的功能 |
| 502 |	Bad Gateway	| 请求不完整，服务器从上游服务器接受了一个无效的响应 |
| 503 |	Service Unavailable	| 请求不完整，服务器暂时重启或关闭 |
| 504 |	Gateway Timeout	| 网关超时 |
| 505 |	HTTP Version Not Supported	| 服务器不支持所指定的HTTP版本 |

## 设置状态码


- `public void setStatus ( int statusCode )`: 此方法可以设置任意的状态码。如果您的响应包含一个特殊的状态码和一个文档，请确保在用PrintWriter返回任何内容前调用setStatus方法
- `public void sendRedirect(String url)`: 此方法产生302响应，同时产生一个 Location 头告诉URL 一个新的文档
- `public void sendError(int code, String message)`: 此方法将一个状态码(通常为 404)和一个短消息，自动插入HTML文档中并发回给客户端


# 表单处理

我们在浏览网页的时候，经常需要向服务器提交信息，并让后台程序处理。浏览器中使用 GET 和 POST 方法向服务器提交数据。


## `GET`方法



GET方法将请求的编码信息添加在网址后面，网址与编码信息通过"?"号分隔。如下所示：
```
http://www.runoob.com/hello?key1=value1&key2=value2
```
- GET方法是浏览器默认传递参数的方法，一些敏感信息，如密码等建议不使用GET方法。
- 用get时，传输数据的大小有限制 （注意不是参数的个数有限制），最大为1024字节。


## `POST`方法

一些敏感信息，如密码等我们可以通过POST方法传递，POST提交数据是隐式的。

POST提交数据是不可见的，GET是通过在url里面传递的（可以看一下你浏览器的地址栏）。

JSP使用getParameter()来获得传递的参数，getInputStream()方法用来处理客户端的二进制数据流的请求。

## `JPS`读取表单数据

- `getParameter():`: 使用 request.getParameter() 方法来获取表单参数的值。
- `getParameterValues()`: 获得如checkbox类（名字相同，但值有多个）的数据。 接收数组变量 ，如checkbox类型
- `getParameterNames()`:该方法可以取得所有变量的名称，该方法返回一个 Enumeration。
- `getInputStream()`:调用此方法来读取来自客户端的二进制数据流。





# 过滤器

# Cookie处理

# Session

# 文件上传

# 日期处理

# 点击量统计

# 自动刷新

# 发送邮件
