模块是一个`python文件`，由python语言编写的源文件  

- 导入模块
```python
import module_name                      # 导入整个模块
from module_name import name1, name2    # 导入模块某个部分
import module_name as alias             # 导入模块并取别名
from module_name import name1 as alias1, name2 as alias2
from module_name import *               # 导入模块全部
```

- __main__
__name__ 是一个特殊的内置变量，用于表示当前模块的名称。  
> 当模块被导入到其他模块中时：__name__ 的值被设置为模块的实际名称  
> if __name__ == "__main__"，被用于测试是否被其他模块引用


- __all__
它是一个列表，写在module.py中，表示哪些名称（如函数、类、变量）应该被导入。




# 包
即文件夹，将所有有联系的模块组织到一起，放到以一个文件夹里面

