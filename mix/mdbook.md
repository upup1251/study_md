
**mdbook** is a cli tools to create book with markdown file.based on rust 


# command line tool 

## init 

```bash
mdboow init

# follows file will be added
book-test/
├── book
└── src
    ├── chapter_1.md
    └── SUMMARY.md
```

- `src`: the book in markdown.contains all the source files,configuration files,etc.
- `book`: where the book is rendered.
- `SUMMARY.md`: the skeletion(骨架) of your book

> if the `SUMMARY.md` already exists when run `mdbook init`,then mdbook will automatic generate the file `SUMMARY.md` need

foloows are some options
```bash
mdbook init path/to/book
# will init a in specific dir

mkbook init --theme
# the default theme will be copied to your `src` dir,you can edit it in `src/theme` dir

mkbook init --title="xxx"
# specify a title for the book 

mkbook init --ignore
# create `.gitignore` file to ignore the `book` directory

mdbook init --force
# skip the prompts for .gitignore and title
```


## build

the build command is used to render your book

it will try to parse(解析) your `SUMMARY.md` file to understand the structure of your book and fetch the corresponding files.(the lose file will generate)

follows are some options
```bash
mdbook build path/to/book
# specify the dir of the book's root ,otherwise is current dir

mdbook build --open 
# open in browser fater build

mdbook build --dest-dir(-d)
# change the output dir for the book
```
> build command will copy all the file (expect *.md) under `src` to `build`


## watch

with watch command run,when the file changed,the web will change automaticly

follows are options 
```bash
mdbook watch path/to/book

mdbook watch --open 

mdbook --dest-dir xxx
# the render output will overwrite all the dest-dir
```

## serve

used to preview a book by serving it via http at localhost:3000

the serve will watches the `src` dir automaticly

follows are options 
```bash
mdbook serve path/to/book

mdbook serve path/to/book -p 8000 -n 127.0.0.1 

--open 

--dest-dir 

--watcher 
```

## test 

can only test the codeblock of rust 


## clean 

delete the generated book and any other build artifacts


# format


## SUMMARY.md

let mdbook know the chapter included,the order and structure

1. Title 

optional,start with `#`,is comment of `SUMMARY.md`

2. Prefix Chapter

start without `-`,for introduction,which not be numbered

```text
[A Prefix Chapter](relative/path/to/markdown.md)

- [First Chapter](relative/path/to/markdown2.md)
```



# 插件


- installation

```sh 
cargo install mdbook-toc
```


Add it as a preprocessor to your book.toml


```toml
[preprocessor.toc]
command = "mdbook-toc"  
renderer = ["html"]
marker = "[toc]"  # 目录占位符
```


