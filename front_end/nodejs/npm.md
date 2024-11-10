<!-- npm.md -->



# npm


NPM（Node Package Manager）是一个 JavaScript 包管理工具，也是 Node.js 的默认包管理器。


##  安装模块
```bash
npm install <Module Name>
```
> 目标模块放在了工程目录下的 node_modules 目录中，因此在代码中只需要通过 require('express') 的方式就好，无需指定第三方包路径。


- 全局安装[-g]
    - 将安装包放在 ./node_modules 下（运行 npm 命令时所在的目录）
    - 通过 require("xxx") 来引入本地安装的包。

- 本地安装
    - 将安装包放在 /usr/local 下或者你 node 的安装目录。
    - 可以直接在命令行里使用。



## 常用命令

```bash
npm init                    # npm install <package>：安装某个包并将其添加到项目的依赖中。
npm search <package>        #搜索模块
npm install <package> [-g]  #安装 package.json 文件中定义的所有依赖。
npm uninstall <package>     #卸载某个包并从依赖中移除。
npm list -g                 # 查看所有全局安装的模块
npm list <Module Name>      # 查看某个模块的版本号
npm update <package>        #更新项目中所有的依赖包到最新版本。
npm run <script>            #运行在 package.json 中定义的脚本。初始化一个新的 Node.js 项目，生成 package.json 文件。
```

## 版本号

语义版本号分为 X.Y.Z 三位，分别代表主版本号、次版本号和补丁版本号，当代码变更时，版本号按以下原则更新。

- 如果只是修复 bug，需要更新 Z 位。
- 如果是新增了功能，但是向下兼容，需要更新 Y 位。
- 如果有大变动，向下不兼容，需要更新 X 位



## 使用package.json


package.json 位于模块的目录下，用于定义包的属性。

- name - 包名。
- version - 包的版本号。
- description - 包的描述。
- homepage - 包的官网 url 。
- author - 包的作者姓名。
- contributors - 包的其他贡献者姓名。
- dependencies - 依赖包列表。如果依赖包没有安装，npm 会自动将依赖包安装在 node_module 目录下。
- repository - 包代码存放的地方的类型，可以是 git 或 svn，git 可在 Github 上。
- main - main 字段指定了程序的主入口文件，require('moduleName') 就会加载这个文件。这个字段的默认值是模块根目录下面的 index.js。
- keywords - 关键字

