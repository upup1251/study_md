[toc]

# 1. 简介


JSP(Java Server Page): SUN公司提供的动态网页开发技术，是Java Web服务器端的动态资源。

- 相比html
    - html只能为用户提供静态数据
    - Jsp技术允许在页面中嵌套java代码，为用户提供动态数据
- 相比servlet
    - servlet很难对数据进行排版
    - jsp除了可以用java代码产生动态数据的同时，也很容易对数据进行排版

在长期的软件实践中，人们逐渐
- 把servlet作为web应用中的控制器组件来使用
- 把JSP技术作为数据显示模板来使用

Jsp本质上就是一个 Servlet
- 当我们第一次访问Jsp的时候，Jsp引擎都会将这个Jsp翻译成一个Servlet
- 这个文件存放在tomcat（源码目录）中的work目录中。



## 1.1 开发环境搭建

1. 配置Java开发环境(JDK)

- Java JDK的下载
- PATH环境变量的配置。

2. 配置Web服务器：Tomcat

> 目前，市场上有很多支持 JSP 和 Servlets 开发的 Web 服务器。他们中的一些可以免费下载和使用，Tomcat 就是其中之一。

- 下载最新版本的[Tomcat](http://tomcat.apache.org/)
- 创建环境变量指向tomcat目录
- 通过`bin`目录下的脚步启动Tomcat

3. 设置classpath变量

由于servlets不是Java SE的一部分，所以您必须标示出servlet类的编译器。

- 配置环境变量`classpath`+=`jsp-api.jar`



# 2. 结构

## 2.1 容器结构

网络服务器需要一个JSP引擎，也就是一个容器来处理JSP页面。容器负责截获，处理和传递对JSP页面的请求。

JSP容器与Web服务器协同合作，为JSP的正常运行提供必要的运行环境和其他服务，并且能够正确识别专属于 JSP 网页的特殊元素。

下图显示了 JSP 容器和 JSP 文件在 Web 应用中所处的位置。

![JSP容器和SJP文件在WEB引用中所处的位置](assets/jspstruct.png)

## 2.2 JSP处理过程

1. 就像其他普通的网页一样，浏览器发送一个HTTP请求给服务器。
2. Web服务器识别出这是一个对JSP网页的请求，并且将该请求传递给JSP引擎。通过使用URL或者.jsp文件来完成。
3. JSP 引擎从磁盘中载入 JSP 文件，然后将它们转化为 Servlet。
    > 这种转化只是简单地将所有模板文本改用 println() 语句，并且将所有的 JSP 元素转化成 Java 代码。
4. JSP 引擎将 Servlet 编译成可执行类，并且将原始请求传递给 Servlet 引擎。
5. Web 服务器的某组件将会调用 Servlet 引擎，然后载入并执行 Servlet 类。在执行过程中，Servlet 产生 HTML 格式的输出并将其内嵌于 HTTP response 中上交给 Web 服务器。
6. Web 服务器以静态 HTML 网页的形式将 HTTP response 返回到您的浏览器中。
7. 最终，Web 浏览器处理 HTTP response 中动态产生的HTML网页，就好像在处理静态网页一样。
![处理过程图解](assets/jspway.png)


# 3. 生命周期

JSP生命周期就是从创建到销毁的整个过程
- 类似于servlet生命周期
- 区别在于JSP生命周期还包括将JSP文件编译成servlet

![JSP生命周期图示](assets/jsplifetime.png)

1.  编译阶段


当浏览器请求JSP页面时
- JSP引擎会首先去检查是否需要编译这个文件
- 如果这个文件没有被编译过，或者在上次编译后被更改过，则编译这个JSP文件。
    - 解析JSP文件
    - 将JSP文件转为servlet入文件(xxx.java)
    - 编译servlet形成类文件(xxx.class)


2. 初始化阶段

容器载入jsp文件后
- 加载与JSP对应的servlet类
- 创建其实例
- 并调用它的初始化方法`jspInit()`
```java
public void jspInit(){
    //初始化代码
}
```

3. 执行阶段

当JSP网页完成初始化后
- 调用与JSP对应的servlet实例的服务方法`_jspService()`
```java
void _jspService(HttpServletRequest request,HttpServletResponse response){
   // 服务端处理代码
}
```
- 在每个request中被调用一次并且负责产生与之相对应的response
- 并且它还负责产生所有7个HTTP方法的回应，比如GET、POST、DELETE等等。


4. 销毁阶段

调用与JSP对应的servlet实例的销毁方法，然后销毁servlet实例


- 销毁阶段描述了当一个JSP网页从容器中被移除时所发生的一切
- jspDestroy()方法在JSP中等价于servlet中的销毁方法
- 当您需要执行任何清理工作时复写jspDestroy()方法，比如释放数据库连接或者关闭文件夹等等。

```java
public void jspDestroy(){
    //清理代码
}
```

