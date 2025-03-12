本节主要设计Java及web端的知识

[toc]

# 1. Java版本

$$JavaME \subset JavaSE \subset JavaEE$$

1. JavaME(Java Platform Micro Edition)
- Java移动开发平台（非Android）
- 小众不太常用

1. JavaSE(Java Platform Standard Edition) 

- 基于标准JDK的开发

3. JavaEE(Java Platform Enterprise Edition)
Java Web开发正式进入到JavaEE的领域
- Java企业平台
- 在JavaSE基础上添加了一大堆服务器相关的库以及API接口
    > 所有的JavaEE程序，仍然是运行在标准的JavaSE的虚拟机上的。
- JavaEE最核心的组件就是基于Servlet标准的Web服务器，开发者编写的应用程序是基于Servlet API并运行在Web服务器内部的



# 2. 简单的HTTP Server

一个HTTP Server本质上是一个TCP服务器，我们先用TCP编程的多线程实现的服务器端框架: 
> 我去，不就和我之前实现的owo通信软件一样的，使用socket套接字进行通信。本质上使用socket进行通信的连接，使用连接对象socket的输入和输出流实现客户端和服务器间请求`request`的发送和响应`response`的回传

执行流程
1. 启动服务器：

- main()方法中创建一个ServerSocket对象并绑定到端口8080，开始监听客户端连接。

2. 等待客户端连接：

- for无限循环调用ss.accept()，等待客户端连接。
- 一旦有客户端连接成功，返回一个Socket对象代表与该客户端的连接。

3. 处理客户端连接：

- 为每个客户端连接创建一个新的线程（Handler）。
- 调用Thread.start()方法，自动调用动该线程的run()方法。

4. 客户端请求处理：

- 在 Handler.run() 方法中：
- 使用Socket.getInputStream()和Socket.getOutputStream()获取输入和输出流。
- 调用handle()方法处理输入输出数据。

5. 读取并解析客户端请求：

- 在 handle() 方法中：
- 用BufferedReader从输入流中逐行读取客户端请求。
- 第一行解析：检查是否为GET/HTTP/1.x格式的请求。
- 如果是，标记请求为有效。
- 如果不是，标记请求为无效。
- 请求头解析：逐行读取请求头，并在控制台打印，直到读取到空行（HTTP请求头结束标志）。

6. 生成并发送响应：

- 根据请求是否有效生成不同的HTTP响应：
- 无效请求：发送 404 Not Found 响应，响应体为空。
- 有效请求：构造简单的HTML响应内容 `<html><body><h1>Hello, world!</h1></body></html>`。
- 设置响应头包括状态码 200 OK、内容类型text/html、以及内容长度。
- 发送响应头和HTML内容。
- 刷新输出流确保数据发送到客户端。

7. 关闭连接：

- 在Handler.run()的finally 块中，关闭Socket，释放资源。
- 输出“client disconnected.” 提示客户端连接已关闭。


```java
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;

public class Server {
    public static void main(String[] args) throws IOException {
        // 创建一个ServerSocket实例，监听8080端口
        ServerSocket ss = new ServerSocket(8080);
        System.out.println("server is running...");

        // 无限循环，持续监听客户端连接
        for (;;) {
            // 接受客户端连接，返回Socket对象
            Socket sock = ss.accept();
            System.out.println("connected from " + sock.getRemoteSocketAddress());

            // 为每个客户端连接创建一个新的线程
            Thread t = new Handler(sock);
            t.start(); // 启动线程，会自动调用该线程的run方法
        }
    }
}

class Handler extends Thread {
    // 用于与客户端通信的Socket
    Socket sock;

    // 构造方法，初始化Socket
    public Handler(Socket sock) {
        this.sock = sock;
    }

    @Override
    public void run() {
        try (InputStream input = this.sock.getInputStream()) { // 获取输入流
            try (OutputStream output = this.sock.getOutputStream()) { // 获取输出流

                handle(input, output); // 调用处理方法

            }
        } catch (Exception e) {
            // 捕获异常，防止线程中断
            e.printStackTrace();
        } finally {
            try {
                this.sock.close(); // 确保Socket在使用后关闭
            } catch (IOException ioe) {
                ioe.printStackTrace();
            }
            System.out.println("client disconnected."); // 打印客户端断开连接的消息
        }
    }

    private void handle(InputStream input, OutputStream output) throws IOException {
        // 将输入流转换为BufferedReader以逐行读取数据
        var reader = new BufferedReader(new InputStreamReader(input, StandardCharsets.UTF_8));
        // 将输出流转换为BufferedWriter以逐行写入数据
        var writer = new BufferedWriter(new OutputStreamWriter(output, StandardCharsets.UTF_8));

        // 利用对象对客户端发来的请求进行逐行读取，处理
        // 读取HTTP请求:
        boolean requestOk = false;  // 标记请求是否有效
        String first = reader.readLine();  // 读取请求的第一行
        if (first.startsWith("GET / HTTP/1.")) {  // 检查请求是否为GET请求且版本为HTTP/1.x
            requestOk = true;  // 如果是GET请求，则标记为有效
        }
        // 读取HTTP请求头部:
        for (;;) {
            String header = reader.readLine();  // 逐行读取请求头
            if (header.isEmpty()) {  // 如果读取到空行，则说明HTTP头部已经结束
                break;
            }
            System.out.println(header);  // 打印请求头
        }

        // 根据请求有效性打印响应
        System.out.println(requestOk ? "Response OK" : "Response Error");
        if (!requestOk) {  // 如果请求无效
            // 发送错误响应:
            writer.write("HTTP/1.0 404 Not Found\r\n");  // 设置HTTP响应状态为404 Not Found
            writer.write("Content-Length: 0\r\n");  // 设置响应体为空
            writer.write("\r\n");  // 空行，标识响应头和响应体的分隔
            writer.flush();  // 刷新输出流，将响应发送给客户端
        } else {  // 如果请求有效
            // 发送成功响应:
            String data = "<html><body><h1>Hello, world!</h1></body></html>";  // 设置响应的HTML内容
            int length = data.getBytes(StandardCharsets.UTF_8).length;  // 计算响应体的字节长度
            writer.write("HTTP/1.0 200 OK\r\n");  // 设置HTTP响应状态为200 OK
            writer.write("Connection: close\r\n");  // 设置连接关闭
            writer.write("Content-Type: text/html\r\n");  // 设置响应内容类型为HTML
            writer.write("Content-Length: " + length + "\r\n");  // 设置响应体的字节长度
            writer.write("\r\n");  // 空行，标识响应头和响应体的分隔
            writer.write(data);  // 发送HTML数据
            writer.flush();  // 刷新输出流，将响应发送给客户端
        }
    }
}
```



# 3. 运行web应用

将写好的Servlet项目运行的过程即为运行web应用

1. 获得war文件

- 运行Maven命令mvn clean package
- 在target目录下得到一个hello.war文件，即编译打包后的Web应用程序(类似于jar包)。


2. 运行war文件

普通的Java程序是通过启动JVM，然后执行main()方法开始运行。但是Web应用程序有所不同，我们无法直接运行war文件

要运行我们的war文件
- 首先要下载Tomcat服务器
- 把hello.war文件复制到Tomcat的webapps目录下
- 切换到bin目录，执行startup.sh启动Tomcat服务器
    类似Tomcat这样的服务器也是Java编写的，启动Tomcat服务器实际上是
    - 启动Java虚拟机
    - 执行Tomcat的main()方法
    - 由Tomcat负责加载我们的.war文件
    - 并创建一个HelloServlet实例，最后以多线程的模式来处理HTTP请求
- 在浏览器输入http://localhost:8080/hello/即可看到Servlet的的响应


因为我们编写的Servlet并不是直接运行，而是由Web服务器加载后创建实例运行，所以，类似Tomcat这样的Web服务器也称为Servlet容器。



# 4. TomcaT服务器


Tomcat 是一个符合 JavaEE WEB 标准的最小的**WEB容器**，所有的 JSP 程序一定要有 WEB 容器的支持才能运行，而且在给定的 WEB 容器里面都会支持事务处理操作。


Tomcat简单的说就是一个运行Java的网络服务器，底层是Socket的一个程序，它也是JSP和Servlet 的一个容器。

实际上 Tomcat 部分是 Apache 服务器的扩展，但它是独立运行的，所以当你运行tomcat时，它实际上作为一个与 Apache 独立的进程单独运行的


## Tomcat目录结构

- `bin`: 存放启动和关闭Tomcat的脚本文件
- `conf`: 存放Tomcat服务器的配置文件
- `lib`: 存放Tomcat服务器的支持jar包
- `logs`: 存放Tomcat的日志文件
- `temp`: 存放Tomcat运行时产生的临时文件
- `webapps`: web应用所在的目录，即外界访问的web资源存放目录
- `work`: Tomcat的工作目录



# 5. HTTP协议

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

1. 请求行: `Method Request-URI HTTP-Version CRLF`
- `Method`: 请求方法
    - `Get`: 没有请求体
    - `Post`
- `Request-URI`: 统一资源标识符
- `HTTP-Version`: 表示请求的HTTP协议版本 
- `CRLF`: 回车和换行

2. 请求头: 请求报头允许客户端向服务器端传递请求的附加信息以及客户端自身的信息

3. 请求正文


### 请求方法

在浏览网页的时候，经常需要向服务器提交信息，并让后台程序处理。浏览器中使用 GET 和 POST 方法向服务器提交数据。

1. `GET`方法

GET方法将请求的编码信息添加在网址后面，网址与编码信息通过"?"号分隔。如下所示：
```
http://www.runoob.com/hello?key1=value1&key2=value2
```
- GET方法是浏览器默认传递参数的方法，一些敏感信息，如密码等建议不使用GET方法。
- 用get时，传输数据的大小有限制 （注意不是参数的个数有限制），最大为1024字节。


2. `POST`方法

一些敏感信息，如密码等我们可以通过POST方法传递，POST提交数据是隐式的。

不同于GET，POST提交数据是不可见的

JSP使用getParameter()来获得传递的参数，getInputStream()方法用来处理客户端的二进制数据流的请求。


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

2. 响应头: 响应报头允许服务器传递不能放在状态行中的附加响应信息
- Location：Location响应报头域用于重定向接受者到一个新的位置
- Refresh：自动跳转（单位是秒）

3. 响应正文


