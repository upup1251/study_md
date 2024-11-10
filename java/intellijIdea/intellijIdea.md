#create java application

## create a package and a class 

package are used for grouping classes that belong to the same category or provide similar functionality
```markdown
`java class filw` saved in `src` folder

in the Name field,package name + class name is Ok(the IDE will inserted the package statement and the class declaration automatically(the IDE will inserted the package statement and the class declaration automatically))

```

## wirte the code 
> `shift`+`enter` will start a new line without change current line

- live templates 
Live templates are code snippets that you can insert into your code
> `ctrl`+`j` will show you list of live templates you can choose
> `ctrl`+`space` will show you list of completion templates you can choose


## build and run the application
1. when you click the `run`,idea will compiles the source code into `jvm bytecode`  
2. then will place the `jvm bytecode` to the `out` directory
3. the the `jvm` runs the bytecode


## package the application in a jar
> `java archive(jar)` is called an artifact（工件）
1. create an artifact configuration for the jar
File -> project structure -> artifacts -> + -> jar  
or `ctl`+`alt`+`shift`+`s`

2. build the jar artifact
menu -> build -> build artifacts  
then the jar will appear in out/artifacts directory

## run the packaged application
> `ctrl`+`shift`+`A`:search for actions and setting across the entire IDE

1. create a run configuration for the packaged application  
`ctrl`+`shift`+`A` -> input 'edit configuration' -> + jar application -> input 'name','path to the jar ','before launch build artifact'  
then the jar is built automatically when you execute the run configuration


# write the source code 

## lines of code 
`shift`+`enter`=`o`  
`shift`+`alt`+`enter`=`O`  
`ctrl+D`：复制一行  
`ctrl+Y`：删除一行  
`alt+shift+⬆️/⬇️`：将本行向上或向下移动一行  



<!-- TODO:stop at project configuration; -->

