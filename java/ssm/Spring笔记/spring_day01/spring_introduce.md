
[toc]

# 1. spring介绍


## 1.1 Spring家族


Spring并不是单一的一个技术，而是一个大家族，可以从官网的`Projects`中查看其包含的所有技术。
![spring大家族](assets/image-20210729171850181.png)

* Spring Framework:Spring框架，是Spring中最早最核心的技术，也是所有其他技术的基础。
* SpringBoot:Spring是来简化开发，而SpringBoot是来帮助Spring在简化的基础上能更快速进行开发。
* SpringCloud:这个是用来做分布式之微服务架构的相关开发。

我们今天所学习的Spring其实指的是**Spring Framework**


## 1.2 了解Spring发展史


![image-20210729171926576](assets/image-20210729171926576.png)


* IBM提出了EJB思想,早期的JAVAEE开发大都基于该思想。
* Rod Johnson出版`Expert One-on-One J2EE Design and Development`,书中阐述在开发中使用EJB该如何做。
* Rod Johnson出版`Expert One-on-One J2EE Development without EJB`,书中提出了比EJB思想更高效的实现方案，并且在同年将方案进行了具体的落地实现，这个实现就是Spring1.0。
* 随着时间推移，版本不断更新维护，目前最新的是Spring5
  * Spring1.0是纯配置文件开发
  * Spring2.0为了简化开发引入了注解开发，此时是配置文件加注解的开发方式
  * Spring3.0已经可以进行纯注解开发，使开发效率大幅提升，我们的课程会以注解开发为主
  * Spring4.0根据JDK的版本升级对个别API进行了调整
  * Spring5.0已经全面支持JDK8，现在Spring最新的是5系列所以建议大家把JDK安装成1.8版


# 2. spring framework

Spring框架主要的优势是在`简化开发`和`框架整合`上，至于如何实现就是咱们要学习Spring框架的主要内容:

* 简化开发: Spring框架中提供了两个大的核心技术，分别是:

  * `IOC`
  * `AOP`
    * `事务处理`

* 框架整合: Spring在框架整合这块已经做到了极致，它可以整合市面上几乎所有主流框架


## 2.1 Spring系统架构

spring framework包含的内容如下图所示

![spring framework架构图](assets/1629720945720.png)

1. 核心层

* Core Container:核心容器，这个模块是Spring最核心的模块，其他的都需要依赖该模块

2. AOP层

* AOP:面向切面编程，它依赖核心层容器，目的是==在不改变原有代码的前提下对其进行功能增强==
* Aspects:AOP是思想,Aspects是对AOP思想的具体实现

3. 数据层

* Data Access:数据访问，Spring全家桶中有对数据访问的具体实现技术
* Data Integration:数据集成，Spring支持整合其他的数据层解决方案，比如Mybatis
* Transactions:事务，Spring中事务管理是Spring AOP的一个具体实现，也是后期学习的重点内容

4. Web层

* 这一层的内容将在SpringMVC框架具体学习

5. Test层

* Spring主要整合了Junit来完成单元测试和集成测试




## 2.2 Spring核心概念


### 2.2.1 目前项目中的问题


![java原生代码出现的问题](assets/1629723232339.png)

(1)业务层需要调用数据层的方法，就需要在业务层new数据层的对象

(2)如果数据层的实现类发生变化，那么业务层的代码也需要跟着改变，发生变更后，都需要进行编译打包和重部署

(3)所以，现在代码在编写的过程中存在的问题是：**耦合度偏高**


### 2.2.2 IOC和Bean

1. IOC（Inversion of Control）控制反转

使用对象时，由主动new产生对象转换为由==外部==提供对象，此过程中对象创建控制权由程序转移到外部，此思想称为控制反转。

2. Spring和IOC之间的关系是什么呢?

* Spring技术对IOC思想进行了实现
* Spring提供了一个容器，称为==IOC容器==，用来充当IOC思想中的"外部"

3. IOC容器的作用以及内部存放的是什么?

* IOC容器负责对象的创建、初始化等一系列工作
* 被创建或被管理的对象在IOC容器中统称为==Bean==

### 2.2.3 DI

DI（Dependency Injection）依赖注入

在容器中建立bean与bean之间的依赖关系的整个过程，称为依赖注入

![1629735078619](assets/1629735078619.png)


* 业务层要用数据层的类对象，以前是自己`new`的
* 现在自己不new了，靠`别人[外部其实指的就是IOC容器]`来给注入进来
* 这种思想就是依赖注入


### 2.2.4 小结

介绍完Spring的IOC和DI的概念后，我们会发现这两个概念的最终目标就是:**充分解耦**，具体实现靠:
* 使用IOC容器管理bean（IOC)
* 在IOC容器内将有依赖关系的bean进行关系绑定（DI）
* 最终结果为:使用对象时不仅可以直接从IOC容器中获取，并且获取到的bean已经绑定了所有的依赖关系.


1. 什么IOC/DI思想?

* IOC:控制反转，控制反转的是对象的创建权
* DI:依赖注入，绑定对象与对象之间的依赖关系

2. 什么是IOC容器?

Spring创建了一个容器用来存放所创建的对象，这个容器就叫IOC容器

3. 什么是Bean?

容器中所存放的一个个对象就叫Bean或Bean对象
