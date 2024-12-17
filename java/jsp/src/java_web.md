
# JavaEE的介绍


我们前面介绍的所有基于标准JDK的开发都是JavaSE，即Java Platform Standard Edition

Java Web开发正式进入到JavaEE的领域，JavaEE
- 是Java Platform Enterprise Edition的缩写，即Java企业平台
- 实际上是完全基于JavaSE，只是多了一大堆服务器相关的库以及API接口
> 所有的JavaEE程序，仍然是运行在标准的JavaSE的虚拟机上的。
- JavaEE并不是一个软件产品，它更多的是一种软件架构和设计思想。我们可以把JavaEE看作是在JavaSE的基础上，开发的一系列基于服务器的组件、API标准和通用架构。
- JavaEE最核心的组件就是基于Servlet标准的Web服务器，开发者编写的应用程序是基于Servlet API并运行在Web服务器内部的：


此外，还有一个小众不太常用的JavaME：Java Platform Micro Edition，是Java移动开发平台（非Android）

它们三者关系如下：

┌────────────────┐
│     JavaEE     │
│┌──────────────┐│
││    JavaSE    ││
││┌────────────┐││
│││   JavaME   │││
││└────────────┘││
│└──────────────┘│
└────────────────┘


# 编写简单的HTTP Server

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


# servlet入门

上一节中可以看到，编写HTTP服务器其实是非常简单的，只需要先编写基于多线程的TCP服务，然后在一个TCP连接中读取HTTP请求，发送HTTP响应即可。

但是，要编写一个完善的HTTP服务器，需要考虑的很多，需要耗费大量的时间，并且经过长期测试才能稳定运行。

因此，在JavaEE平台上，处理TCP连接，解析HTTP协议这些底层工作统统扔给现成的Web服务器去做，我们只需要把自己的应用程序跑在Web服务器上。为了实现这一目的，JavaEE提供了Servlet API，我们使用Servlet API编写自己的Servlet来处理HTTP请求，Web服务器实现Servlet API接口，实现底层功能:
                 ┌───────────┐
                 │My Servlet │
                 ├───────────┤
                 │Servlet API│
┌───────┐  HTTP  ├───────────┤
│Browser│◀──────▶│Web Server │
└───────┘        └───────────┘



一个Servlet总是继承自HttpServlet，然后覆写doGet()或doPost()方法。
- 注意到doGet()方法传入了HttpServletRequest和HttpServletResponse两个对象，分别代表HTTP请求和响应。
- 我们使用Servlet API时，并不直接与底层TCP交互，也不需要解析HTTP协议，因为HttpServletRequest和HttpServletResponse就已经封装好了请求和响应。
- 以发送响应为例，我们只需要设置正确的响应类型，然后获取PrintWriter，写入响应即可。



## 项目目录

web-servlet-hello/
├── pom.xml
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── itranswarp/
        │           └── learnjava/
        │               └── servlet/
        │                   └── HelloServlet.java
        ├── resources/
        └── webapp/


- 目录webapp目前为空，如果我们需要存放一些资源文件，则需要放入该目录
- webapp目录下是否需要一个/WEB-INF/web.xml配置文件？这个配置文件是低版本Servlet必须的，但是高版本Servlet已不再需要，所以无需该配置文件


## 运行web应用

1. 获得war文件

- 运行Maven命令mvn clean package
- 在target目录下得到一个hello.war文件，即编译打包后的Web应用程序(类似于jar包)。


2. 运行war文件

普通的Java程序是通过启动JVM，然后执行main()方法开始运行。但是Web应用程序有所不同，我们无法直接运行war文件

必须先启动Web服务器，再由Web服务器加载我们编写的HelloServlet，这样就可以让HelloServlet处理浏览器发送的请求

要运行我们的hello.war
- 首先要下载Tomcat服务器
- 把hello.war复制到Tomcat的webapps目录下
- 然后切换到bin目录，执行startup.sh或startup.bat启动Tomcat服务器
- 在浏览器输入http://localhost:8080/hello/即可看到HelloServlet的输出



实际上，类似Tomcat这样的服务器也是Java编写的，启动Tomcat服务器实际上是
- 启动Java虚拟机
- 执行Tomcat的main()方法
- 由Tomcat负责加载我们的.war文件
- 并创建一个HelloServlet实例，最后以多线程的模式来处理HTTP请求

因为我们编写的Servlet并不是直接运行，而是由Web服务器加载后创建实例运行，所以，类似Tomcat这样的Web服务器也称为Servlet容器。



# servlet开发

在上一节中，我们看到，一个完整的Web应用程序的开发流程如下：

1. 编写Servlet；
2. 打包为war文件；
3. 复制到Tomcat的webapps目录下；
4. 启动Tomcat。


这个过程是不是很繁琐？如果我们想在IDE中断点调试，还需要打开Tomcat的远程调试端口并且连接上去。


直接在IDE中启动并调试webapp的方法: 因为Tomcat实际上也是一个Java程序，我们看看Tomcat的启动流程：
1. 启动JVM并执行Tomcat的main()方法；
2. 加载war并初始化Servlet；
3. 正常服务。

启动Tomcat无非就是设置好classpath并执行Tomcat某个jar包的main()方法

我们完全可以把Tomcat的jar包全部引入进来，然后自己编写一个main()方法，先启动Tomcat，然后让它加载我们的webapp就行。
> 此时，不必引入Servlet API，因为引入Tomcat依赖后自动引入了Servlet API

```java
public class Main {
    public static void main(String[] args) throws Exception {
        // 启动Tomcat:
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(Integer.getInteger("port", 8080));
        tomcat.getConnector();
        // 创建webapp:
        Context ctx = tomcat.addWebapp("", new File("src/main/webapp").getAbsolutePath());
        WebResourceRoot resources = new StandardRoot(ctx);
        resources.addPreResources(
                new DirResourceSet(resources, "/WEB-INF/classes", new File("target/classes").getAbsolutePath(), "/"));
        ctx.setResources(resources);
        tomcat.start();
        tomcat.getServer().await();
    }
}
```
- 运行main()方法，即可启动嵌入式Tomcat服务器
- 然后，通过预设的tomcat.addWebapp("", new File("src/main/webapp")，Tomcat会自动加载当前工程作为根webapp
- 可直接在浏览器访问http://localhost:8080/
















