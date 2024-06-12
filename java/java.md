[toc]


# 第一章、java入门

## java中的保留字

- 访问控制修饰符  
public,private,protected  

- 基本类型  
boolean,byte,char,short,int,long,float,double

- 类修饰符  
class interface abstract implements extends new 

- 方法、属性、变量修饰符  
final static native(由宿主系统实现的方法) this super(超类对象或构造函数) synchronized(线程同步) volatile(确保一个字段可以由多个线程访问) transient(标志非永久的数据) strictfp(对浮点数计算使用严格的规则) void enum default instanceof

- 异常处理修饰符  
tyr catch finally throw throws

- 程序控制语句  
if else for break continue while do switch case return  

- 包相关  
package import  

- 标识符  
null(空引用) true false  

- 断言  
assert(用来查找内部程序错误) 

- 保留字  
const(保留字，未使用) goto 

# 第二章、基本数据类型与数组

# 第三章、运算符、表达式和语句

# 第四章、类与对象

## 对象的内存模型

1. 声明对象时的内存模型

`dujiawen ouyangzhuo`

此时对象ouyangzhuo是一个空对象，没有分配实体

2. 为对象分配变量后的内存模型

`ouyangzhuo = new dujiawen()`

接下来会干两件事
- 为成员变量分配空间，执行构造方法。
- new运算符在分配内存后，计算出一个称为引用的值（包含代表这些成员变量内存位置及相关的重要信息）

> 对象的引用在栈中，对象的实体（分配各对象的变量）在堆中  
> new dujiawen()已经是引用值，可以称之为一个匿名对象


## 参数传值

1. 传值机制

java中所有方法的参数都是“传值”的，也就是说参数变量的值是调用指定值的拷贝。
> 对于引用型变量，传递的是实体的引用，可对实体进行修改。

2. 可变参数

指声明方法时不给出参数列表中从某项开始直至最后一项参数的名字和个数，但这些参数的类型必须相同。

```java
public void fun(double a,int ... x);
//x称为方法f的参数列表中可变参数的“参数代表”,可用x[i]表示参数列表中第i个参数。
```

## 实例成员和类成员

```java
class dog {
    float x;      //实例变量
    static int y; //类变量

    float max(float x,float y){ //实例方
        ...
    }
    static float min(float x,float y){ //类方法
        ...
    }
}
```

## 包

1. 包语句
```java
package 包名;
//如果省略了package语句，默认为无名包的一部分，只要这些类的字节码存放在相同目录就属于同一个包
```

2. 有包名的类的存储目录

如果一个类有包名，那么就不能在任意位置存放它，否则jvm无法加载这样的类  
如果使用了包名`package dujiawen.ouyangzhuo;`，那么将字节码文件保存在目录"xxx/dujiawen/ouyangzhuo/"中（源文件随意）


3. 运行有包名的主类

```java
java 包名.主类名
```

4. import语句

如果一个类想使用的类和他不再一个包中，则需要import语句进行导入。

## 访问权限

所谓访问权限，是指对象是否可以通过“.“运算符操作自己的变量或调用类中的方法

|  | 同一个类 | 同一个包 | 不同包的子类 | 不同包的非子类 |
| --------------- | --------------- | --------------- | --------------- | --------------- |
| public | ✅ | ✅ | ✅ | ✅ |
| protected | ✅ | ✅ | ✅ | ❌ |
| 默认(default) | ✅ | ✅ | ❌ | ❌ |
| private | ✅ | ❌ | ❌ | ❌ |


# 第五章、子类与继承

java不支持多继承，即一个子类只能有一个父类。

## 继承

```java
//声明
class 子类名 extends 父类名 {
    ...
}
```
> 如果一个类的声明中没有使用extends关键字，则默认为Object的子类。

## 子类的继承性

| 子类和父类 | 继承性 |
| -------------- | --------------- |
| 在同一包中 | 继承父类中不是private的成员变量和方法 |
| 不在同一包中 | 只继承protected和public访问权限的方法 |

> 创建子类对象时，父类的成员变量也都分配了空间，但只将其中的一部分（子类继承的那一部分），作为分配给子类对象的变量。  
> 从父类继承来的那一部分方法可以操控这部分未继承的变量。

## super关键字

子类一旦隐藏了继承的成员变量，那么子类创建的对象就不再拥有该变量，该变量有关键字super所拥有，方法重写相同。

如果子类的构造方法中，没有显示的写出super关键字来调用父类的某个构造方法，那么会默认的调用super();

## final关键字

final可以修饰
- 类 -> final类不能被继承  
- 成员变量 -> 常量，不能被修改  
- 方法 -> final方法不允许子类重写


## 上转型对象

当用子类创建一个对象A,并把这个对象的引用放到父类的对象中，此时称对象A是对象B的上转型对象。

> 上转型对象会失去子类“新增的方法和变量”，得到“隐藏的变量”。  
> 上转型对象可以调用子类继承的方法或子类重写的实例方法（静态方法是调用父类的）。


## 继承与多态 

多态性就是父类的某个方法被其子类重写时，子类对象可以各自产生自己的功能行为。

## abstract类和abstract方法

```java
//用abstract修饰的类成为abstract类（抽象类）
abstract class A {
    ...
}

//抽象方法
abstract int fun(int x,int y);
```

## 理解抽象类
1. 抽象类可以抽象出重要的行为标准
2. 抽象类声明的对象可以成为其子类的上装型对象，调用子类重写的方法





# 第六章、接口与实现

## 接口实现

```java
//接口定义
interface inter_name {
    public static final 常量s;
                +
    public abstract 抽象方法s;
}

//类实现接口
class A implements inter_name {
    重写接口中的方法 //显式的添加public前缀
} 
```

## 接口回调

用接口声明的变量成为接口变量，可以存放实现该接口的类的实例的引用，即存放对象的引用。
通过该接口变量可以调用被类实现的接口方法。

> 接口无法调用类中的其他非接口方法。
> 接口调用类似于上转型对象调用子类重写的方法。

## 理解接口
1. 接口可以抽象出重要的行为准则；
2. 接口在要求一些类有相同名称的方法时，并不强迫这些类具有相同的父类。


# 第七章、内部类与异常类

## 内部类

类的成员：成员变量+成员方法+内部类

内部类和外嵌类的关系：
1. 部内类可访问外嵌类的成员变量和方法
2. 内部类不可声明类变量和类方法
3. 内部类仅供它的外嵌类，其他类不可以用某个类的内部类声明对象

> java生成的内部类的字节码文件为“外部类$内部类.class”.

内部类可被修饰为static内部类，之后程序可在其他类中使用static内部类创建对象，但是static内部类不能操作外嵌类中的实例成员变量。

## 匿名类

1. 和子类有关的匿名类

```java
//假设Objectname是一个类，那么下列代码将返回Objectname类一个子类对象
new Objectname() {
    匿名类的类体 //可在此继承或重写父类的方法
}
```

2. 和接口有关的匿名类

```java
//假设Computable是一个接口，那么下列代码将返回实现了Computable接口的类对象
new Computable(){
    实现接口的匿名类的类体
}
```


## 异常类

1. 输出异常对象的错误信息
```java
public String getMessage();
public void printStackTrace();
public String toString();
```

2. try-catch语句
```java 
try{
    包含可能发生异常的语句
}
catch(ExceptionSubClass1 e){
    ...
}
catch(ExceptionSubClass2 e){
    ...
}
...
```

3. 自定义异常类

继承Exceptions类


## 断言









# 第八章、常用实用类

# 第九章、组件及事件处理

# 第十章、输入输出流

输入流的指向称为它的源，程序通过输入流读取源中的数据；
输出流的指向称为他的目的地，程序通过输出流把数据送到目的地。

## File类

File类的对象主要用来获取文件本身的一些信息，例如文件所在的目录、文件的长度或读取权限等，不涉及对问价你的读写操作。

```java
//创建一个File对象的构造方法：
File(String filename);
File(String directoryPath,String filename);
File(File dir,String filename);
```

1. 文件属性
```java
getName();
canRead();
canWrite();
exists();
length();
getAbsolutePath();
getParent();
isFile();
isDirectory();
isHidden();
lastModified();
```

2. 目录
```java
mkdir();
list();
listFiles();
list(FilenameFilter obj);
listFiles(FilenameFilter obj);
```

3. 文件的创建与删除
```java
public boolen createNewFile();

delete();
```

4. 运行可执行文件
```java
Runtime ec;
ec = Runtime.getRuntime();
ec.exec(String command); //调用可执行文件
```


## 文件字节输入流

基本步骤：
1. 设定输入流的源；
2. 创建指向源的数据流；
3. 让输入流读取源中的数据；
4. 关闭输入流。

```java 
FileInputStream(String filename) throws IOException; //文件不存在
FileInputStream(File file) throws IOException;

//使用输入流读取字节
int read(); //读取单个字节，返回其ASCII码值，若到文件末尾则返回-1
int read(byte b[]); //读取b.length个字节到数组b中，返回实际读取到的字节数目,到文件末尾则返回-1
int read(byte b[],int off,int len); //从偏移量off开始读取len个字节到数组B中，返回值同上

//关闭流
void close();
```

## 文件字节输出流

基本步骤：
1. 给出输出流的目的地；
2. 创建指向目的地的输出流；
3. 让输出流把数据写入到目的地；
4. 关闭输出流。

```java 
//append默认为false,此时将刷新（清空）该文件。否则为追加
FileOutputStream(String filename,boolean append) throws IOException; //文件存在不允许的操作或其他限制
FileOutputStream(File file,boolean append) throws IOException;

//使用输入流读取字节
void write(int c); //写入单个字节
void read(byte b[]); //写入一个字节数组
void read(byte b[],int off,int len); //从偏移量off开始读取数组B的len个字节到目的地

//关闭流同时flush()保存
void close();
```


## 文件字符输入、输出流

字节流以字节为单位，不能很好的处理Unicode字符，例如一个汉字占两个字节，存取不当会出现乱码，字符流不会

字节流与字符流对应关系：
- FileInputStream -> FileReader
- FileOutputStream -> FileWriterj

> 使用方法类似


## 缓冲流

> 可以增强读写的能力，例如每次读取一行，使用FileReader流很难完成这样的任务，因为我们不知道一行有多少字符

BufferedReader流和BufferedWriter流二者的目的地必须是字符输入流和字符输出流。

```java
//构造方法
BuffferedReader(Reader in);
BufferedWriter(Writer out);

//缓冲流对象读取一行
bufferReaderObject.readLine();

//写入回车
bufferWriterObject.newLine();
```



## 随机流

既可以读文件也能写文件的流。

```java
//构造方法
//参数mode可取r（只读）或rw（可读写），默认append追加模式
RandomAccessFile(String filename,String mode);
RandomAccessFile(File file,String mode);
```

## 数组流

使用字节数组作为流的源和目的地

1. 字节数组流
```java
//字节数组输入流
//构造函数
ByteArrayInputStream(byte[] buf);
ByteArrayInputStream(byte[] buf,int offset,int length);

public int read();
public int read(byte[] b,int off,int len);

//字节数组输出流
ByteArrayOutputStream();

public void write(int b);
public void write(byte[] b,int off,int len);
```
2. 字符数组流

字节数组流和字符数组流的对应关系：
- ByteArrayInputStream -> CharArrayReader;
- ByteArrayOutputStream -> CharArraywriter;

## 数据流

语序程序按着机器无关的风格读取**java原始数据**(write or read int,char,String...)。

```java
DataInputStream(InputStream in);
DataOutputStream(OutputStream out);
```


## 对象流

1. 序列化对象

一个类如果实现了Serializable接口，那么这个类创建的对象就是可序列化的，这是前提。

> 想快速得到一个对象的克隆，可将序列化对象写入内存中然后在读出。

2. 流
```java
//创建对象输入流并读取一个对象
ObjectInputStream ois = ObjectInputStream(InputStream in);
ois.readObject(Object obj);

//创建对象输出流并写入一个对象
ObjectOutputStream oos = ObjectOutputStream(OutputStream out);
oos.writerObject(Object obj);
```

## 使用Scanner解析文件





# 第十一章、JDBC和MySQL数据库

# 第十二章、Java多线程

操作系统可以同时管理计算机系统中的多个进程轮流使用CPU资源，一个进程可以产生多个线程，线程是运行在进程中的“小进程”。

## java中的线程

1. 主线程

JVM加载代码，发现main方法后就启动一个线程，称为main线程，在main方法中创建的线程称为其他线程。

2. 线程的状态与生命周期
    1. 新建：已经有了相应的内存空间和其他资源；
    2. 运行：添加到JVM的线程队列中等待切换；
    3. 中断：JVM把CPU让给其他资源线程；sleep()进入休眠状态；wait()进入等待状态；操作进入阻塞状态；
    4. 死亡：不具备运行的能力。

3. 线程调度和优先级

java虚拟机中的线程调度器负责管理类就绪队列中的线程，优先级在常数1-10之间，即Thread.MIN_PRIORITY和Thread_MAX_PRIORITY之间，默认为5,Thread.NORM_PRIORITY

```java
//调整线程优先级
setPriority(int grade);

//获得线程优先级
getPriority();
```

## Thread类与线程的创建

1. 继承Thread类

需要重写Thread父类的run()方法，以规定线程启动后的具体操作。

2. 实现Runnable接口


```java 
//用Thrad类直接创建线程对象，该构造函数接受一个实现了Runnbale接口类的实例，当该线程对象Thrad调用start()后，会自动执行target中的run()方法。
Thread thread = Thread(Runnable target);
```


3. 目标对象与线程的关系
    1. 目标对象和线程完全解耦
    2. 目标对象组合线程（若耦合）


## 线程的常用方法

```java
//启动线程，使之从新建状态进入就绪队列排队
//多次调用start -> illegalThreadStateException异常
object.start();


//定义线程对象被调度之后所执行的操作，run方法执行完毕，线程进入死亡状态
run();

//优先级高的线程可以在run()方法中调用sleep方法来放弃CPU资源
//被打断 -> InterruptedException异常
sleep(in tmillsecond);

//一个占有CPU的资源可以让休眠的进程调用interrupt方法吵醒“自己”，导致InterruptedException异常，结束休眠
object.interrupt();

//线程start后到死亡前都返回true
object.isAlive();

//返回当前正在使用CPU资源的进程
Thread.currentThread();
```


## 线程同步

线程同步机制：当一个线程A使用synchronized修饰的方法时，其他线程想使用这个synchronized方法时就必须等待线程A使用完synchronized方法。

## 协调同步的线程

当一个线程使用的同步方法中用到某个变量，而此变量又需要其他线程修改后才能符合本线程的需求，此时可以在同步方法中使用wait()方法，其他线程如果再使用这个同步方法中不需要等待，应当调用notifyAll()方法通知处于等待的线程。如果用notify()方法，只通知其中的一个线程。

## 线程联合

```java
//在A线程中调用B线程与本线程联合
B.join();
```

如果线程A在占有CPU资源期间一旦联合B线程，那么A线程立刻中断，知道B执行完毕，A线程再次排队等待调度。

> 如果A准备联合的B线程已经结束，那么B.join()不会产生任何影响。


## 守护线程

当程序中的所有非守护线程（用户线程）都运行结束，即使守护线程的run()方法中还有需要执行的语句，守护线程也会立刻结束运行。

```Java
//一个线程可设置自己为守护线程(Daemon)
setDaemon(boolean on);
```








# 第十三章、Java网络编程

# 第十四章、图形、图像与音频

# 第十五章、泛与集合框架

## 泛型
主要目的是可以建立具有类型安全的**基本框架**,如链表、散列映射等数据结构。

1. 泛型类声明

```java 
class People<E>{
    body;
}
//People是泛型类的名称，E是其中的泛型，可以是任何对象或接口，但不能是基本数据类型。
//泛型类的类体和普通类的类体完全相似。
```

2. 泛型类声明对象

```java
Cone<Circle> conOne;
conOne = new Con<Circle>(new Circle());
//使用泛型类声明和创建对象时，类名后多了一对“<>”，而且必须要用具体的类型代替“<>”中的泛型。
```


## 数据结构
1. 链表

特点：可动态的减少或增加数据项。

2. LinkedList<E>泛型类

```java
//创建链表,其中使用String代替E
LinkedList<String> mylist = new LinkedList<String>();
```

3. 使用迭代器遍历链表

```java
//使用iterator()方法获取一个Iterator对象
Iterator<String> iter = mylist.iterator();
while(iter.hasNext()){
    String te = iter.next();
}
```

4. 堆栈

```java
//创建堆栈
Stack<String> stack = new Stack<String>;
```

5. 散列映射

```java
//创建HashMap<k,v>泛型类对象
HashMap<String,Student> hashtable = HashSet<String,Student>;
```

6. 树集

特点：树集用树结构来存储数据，树结点中的数据会按存放的数据的“大小”（实现Comparable接口类创建的对象可以调用compareTO(Object str)方法和参数制定的对象比较大小关系）顺序一层一层排序，同一层中从左到右按字典顺序从小到达递增，下一层的都比上一层小。

```java
TreeSet<String> mytree = new TreeSet<String>();
```

7. 树映射

特点：树映射中的结点不仅存储数据value,也存储与其关联的关键字key,树映射按照结点中的关键字升序排列。

```java
TreeMap<k,v> mytreemap = new TreeMap<k,v>();
```

## 自动装箱与拆箱

JDK1.5后支持把一个基本数据类型加入到类似于链表等数据结构中，系统会自动完成基本类型（int）到相应对象（Integer）的转换（自动装箱）。从数据结构中获取对象时，如果该对象是基本数据的封装对象，那么系统会自动完成对象（Integer）到基本类型（int）的转换（自动拆箱）。


