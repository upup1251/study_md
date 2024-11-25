线性模型（linear model）试图学得一个通过属性的线性组合来进行预测的函数

# 单元线性回归

$$f(x) = w_1x_1 + w_2x_2 + ... + w_dx_d + b$$
向量形式:
$$f(x) = w^Tx + b$$
目标：
$$f(x_i) \approx y_i $$
令均方误差最小化，有
$$(w^*,b^*) = \arg \min_{(w,b)}\sum^m_{i=1}(f(x_i)-y_i)^2 = \arg \min_{(w,b)} \sum^m_{i=1}(y_i -w x_i -b )^2$$

对$E_{(w,b)} = \sum_{i=1}^m (y_i -wx_i -b )^2$进行最小二乘参数估计，分别对$w$和$b$求导


$$\frac{\partial E(w, b)}{\partial w} = 2 \left( w \sum_{i=1}^{m} x_i^2 - \sum_{i=1}^{m} (y_i - b) x_i \right)$$
$$\frac{\partial E(w, b)}{\partial b} = 2 \left( m b - \sum_{i=1}^{m} (y_i - w x_i) \right)$$

令导数为0，得到闭式解（closed-form）解

$$w = \frac{\sum_{i=1}^{m} y_i (x_i - \bar{x})}{\sum_{i=1}^{m} x_i^2 - \frac{1}{m} \left( \sum_{i=1}^{m} x_i \right)^2}$$

$$b = \frac{1}{m} \sum_{i=1}^{m} (y_i - w x_i)$$



# 多元线性回归


向量形式:
$$f(x) = w^Tx_i + b,x_i = (x_{i1};x_{i2};...;x_{id}) , y_i \in R$$

将$x$和$b$用一个向量$\overline{w} = (w,b)$表示，此时数据集可表示为
$$
X = 
\left[
\begin{matrix}
x_{11}&x_{12}&...&x_{1d}&1\\
x_{21}&x_{22}&...&x_{2d}&1\\
.&.&.&.&1\\
x_{m1}&x_{m2}&...&x_{md}&1 
\end{matrix}
\right]=
\left[
\begin{matrix}
x_1^t&1\\
x_2^t&1\\
.&.\\
x_m^t&1\\
\end{matrix}
\right],
Y = (y_1;y_2;..;y_m)
$$

目标：
$$f(x_i) \approx y_i $$

同样使用最小二乘法求解，有
$$\overline{w} = \arg \min_{\overline{w}}(y - X \overline{w})^T(y - X \overline{w})$$

令$E_{\overline{w}} = (y-X\overline{w})^T(y-X\overline{w})$对$\overline{w}$求导
$$\frac{\partial E_{\overline{w}}}{\partial \overline{w}} = 2 X^T(X \overline{w} - y)$$

令其等于0，可有

- 若$X^TX$满秩或正定，则$\overline{w} = (X^TX)^{-1}X^Ty$
- 若$X^TX$不满秩，可解除多个$\overline{w}$，此时需要借助归纳偏好或引入正则化




# 二分类任务

将获得的y再当作自变量投入单位阶越函数中，得到的z只能有两个取值

但是单位阶越函数性质不好，通常使用对数几率函数$y = \frac{1}{1+e^{-z}}$代替，其
- 单调可微
- 任意阶可导



# 广义线性模型

一般形式：
$$y = g^{-1}(w^Tx +b )$$

其中$g^{-1}$为单调可微的联系函数（link function），$w^Tx +b $为自变量取值

# 线性模型做“分类”

模型的上方为一类，下方为另一类


# 多分类学习

拆解法：将一个多分类任务拆分为若干个二分类任务进行任务求解







