
![hoembrew_loge](assets/homebrew.png)



1. synopsis(概要)

```bash

brew --version 
brew command [--verbose|-v] [options] [formula]
```


2. description


homebrew is the easiest and flexible way to install the UNIX tools Apple didn't include with macOS.Also install software not packaged for your Linux distinbution without requiring `sudo`


[toc]


# terminology(术语)

- homebrew package definition: 软件包的描述文件，常以ruby编写，包含该软件包的信息，如包名、版本、依赖性、安装步骤等

- `formula`(配方): homebrew package definition(builds from upstream sources)
> 像酿酒的配方一样，定义了制作（或安装）一个软件包的步骤和依赖，就像酿酒师需要知道如何酿造酒。

- `keg`(桶): installation destion directory of given formula version
> 指安装的某个特定版本的目录，就像每批酒酿好后会装进不同的桶，Homebrew 也将不同版本的软件存储在独立的 keg 中。

- `rack`(架子): directory containing **kegs** with different versions
> 存放多个 keg 的地方，用于组织不同版本的 keg，类似酒架上会有各种各样的酒桶。

- `Cellar`(地窖): directory contains **racks** 
> 存放所有 rack 的目录，相当于 Homebrew 的“酒窖”，用于统一保存所有 keg 的目录。

- `bottle`(瓶子): pre-built **keg** poured into a **rack** of the **Cellar** instead of building from upstream sources
> 预先构建的 keg，用户可以直接倒入 rack 而无需重新“酿造”，就像直接从酿酒厂带回来的瓶装酒，省去了本地安装的编译步骤。

- `cask`(木桶): homebrew package definition(to install macOS native app)
> 在 Homebrew 里表示 macOS 应用程序的安装单元，相当于一个成品容器——就像用来存放酿好的酒的酒桶。

- `Caskroom`(木桶间): directory containing **casks**
> 存放 cask 的地方，相当于专门存放酒桶的桶室。

- `prefix`(前缀): path in which homebrew is installed
> 表示 Homebrew 的“酿酒厂”位置，所有的公式、酒桶和工具都在这里进行安装。

- `keg-only`: a formula is not symlinked into Hmoebrew's prefix
> keg-only 公式不会创建到前缀目录的符号链接，而是保持在 rack 中存放，避免它们和系统的库冲突。

- `opt-prefix`: a symlink to active version of a **keg**
> 指向活跃版本 keg 的符号链接，就像展示架上的精选酒瓶，指向最新版本。

- `external command`: brew subcommand defined outside of the homebrew offcia
> 外部添加的 brew 子命令，可以理解为酿酒厂之外的额外“工具”。

- `tap`(水龙头): directory(usually git repository) of **formula,cask** and/or **external command**
> 表示一个特定的软件包源（通常是 Git 仓库），用户可以从中获取额外的配方或工具，类似于酒桶上的龙头，用于引入新的酒或酿造材料。


# command

```fish
brew command [--verbose|-v] [options] [formula]
```

with `--verbose` or `-debug`,many command print extra debugging information.
> note these option should only appear after a command

some command behaviour can be customised with environment variables.

## essential command

```sh
# <formula> is usually the name of the formula to install 
brew install <formula>
brew uninstall <formula>

# list all installed formula
brew list

# perform(进行) a substring(子串) search of cask tokens and formula names for text
# with "/text/", perform a regular express search
brew search [text|/text/]
```


## all command 

### `brew analytics [subcommand]`

控制homebrew的匿名聚合用户行为分析,就是收集我们操作中的各种信息，但是我们是匿名的

### `developer [subcommand]`

control homebrew's developer mode

brew update will update Homebrew to the latest commit on the master branch for developer to test

### `brew autoremove`

Uninstall formula that were only install as a dependency of another fourmula and now are no longer needed.

- `brew autoremove`

delte such formula

- `-n,--dry-run`

only list such formula


### `brew cask`

list all locally installable casks including short name


### `brew cleanup [options] [formula|cask...]`


remove the old version package which homebrew don't need forever

Remove 
- stale lock files and outdate downloads for all formula and casks,and 
- old versions of install formula.
- all downloads more than 120 days old.
- if <formula> or <cask> is given,only do this for it

options:
- `--prune=days`: remove all cache files older than specified days
- `-n,--dry-run`: list all but not do remove
- `-s,--scrub`: scrub(清理) all the cache
- `--prune-prefix`: only prune(删除) the symmlinks but no file moved 


### ` brew commands`

show lists of built-in and external commands

- `--include-aliases`: include the aliases of internal commands

<!-- TODO: command command [...] -->

### `completions [subcommand]`

control whether the command from the tap repository can get completion with <TAB> in command-line



### `config,--config`

show homebrew and system configuration info useful for debugging

### `deps [options] [formula|cask...]`

show dependencies for [formula]


- `-n,--topological`: sort dependencies in topological order(拓扑顺序)
- `--tree`: show dependencies as a tree
- `--graph`: Show dependencies as a directed graph.
- `--dot`: Show text-based graph description in DOT format.
- `--annotate`: mark the kind of each dependencies in the output

- `--installed`: List dependencies for formulae that are currently installed.
- `--missing`: Show only missing dependencies.


- `-1,--direct`: only show the direct dependencies(直接依赖项) declared in the formula

- `--full-name`: list dependencies with wheir full name

- `--union`: Show the union(并集$\cup$) of dependencies for multiple formula


- `--include-build`/`--include-optional`/`--include-test`/`--include-requirements`: include dependencies that is  bulit/optional/test/requirements to [formula]
- `--skip-recommended`: skip the recommended dependencies


### `desc [options] formula|cask`

Display formula’s name and one-line description.


### `docs`

Open Homebrew’s online documentation at https://docs.brew.sh in a browser.

### `fetch [options] formula|cask [...]`

download a "bottle" (if avariable) or source package for formula or binaries for casks

- `--os`: Download for the given operating system. 

- `--arch`: Download for the given CPU architecture. 

### `formula`

list all locally installabel formula

### `home,homepage[--formula][--cask][formula|cask]`

Open a formula or cask’s homepage in a browser, or open Homebrew’s own homepage if no argument is provided.


### `info, abv [options] [formula|cask …]`

show brief message for your homebrew installation


### `install [options] formula|cask [...]`

install a formula or cask


- `-d,--debug`: if brewing fails,open a interactive debugging sessio

- `-f,--force`: force install,no matter there whether a old one

- `-v,--verbose`: print the verification and steps that after install

- `-n,--dry-run`: show what will installed,but nothing done

- `--only-dependencies`: only install dependencies

- `-cc` attempt to compile using the specified complier

- `s,--build-from-source`: compile formla from source.dependencies not affect

### `leaves [--install-on-request][--installed-as-dependency]`

list installed formulae that are not a dependencies of another formula or cask



### `link,ln[options]installed_formula[...]`

symlink(符号链接) all of formula's install filed into homebrew prefix

- `overwrite`: delete files already exist

- `-n,--dry-run`: list files will be linked or delete

- `-f,--force`: allow keg-only formula to be linked

### `list,ls[options][installed_formula|installed_cask...]`

list all installed formula and casks

### `log [options][formula|caks]`

show the git log for formula or cask

### `migrate [options] installed_formula|installed_cask [...]`

migrate(迁移) renamed packages to new names

### `missing [--hide=][formula...]`

check the given formula kegs for missing dependencies


### `nodenv-sync`

create symlinks for homebrew's installed NodeJS version in ~/.nodenv/versions

### `pyenv-sync`

create symlinks for homebrew's installed python version in ~/.pyenv/versions

### `rbenv-sync`

create symlinks for homebrew's installed python version in ~/.rbenv/versions


### `options [options][formula...]`

show install options specified to formula


### `outdated [options][formula|cask...]`

list installed cask and formula that have an updated version available


### `pin installed_formula[...]`

Pin the specified formula,preventing(阻止) them being upgraded when use command "brew upgrade formula"

### `postinstall,pos_install installed_formula [...]`

rerun the steps after installed 

### `readall [options][tap]`

import all items from the sepcified tap,or from all installed taps if none is provided

### `reinstall [options] formula|cask [...]`

Uninstall and then reinstall a formula or cask using the same options it was originally installed with

### `search,-S [options] text|/regex/ [...]`

perform a substring search of given target



### `tab [options] installed_formula|installed_cask [...]`

edit tab information for installed formula or cask

- `--install-on-request`: mark target as installed
- `--no-install-on-request`: markd target as uninstalled


### `tab [options] [user/repo] [URL]`

tap a formula repository,if no arg provided,list all installed taps

### `tab-info [-installed] [--json]` [tap...]

show detailed information about one or more taps 

### `uninstall,remove,rm[options]`

uninstall a formula or cask 

- `-f,--force`: delete all installed version formula

- `--zap`: remove all files associated with a cask


### `unlink [--dry-run] installed_formula`

remove symlinks for formula from homebrew's prefix


### `unpin installed_formula[...]`

Unpin formula,allow upgrade


### `untap [--force] tab [...]`

remove a tapped formula repository


### `update,up[options]`

fetch the newest version homebrew and all formula from github and perform any nessary migrations(迁移)

### `upgrade [options] [installed_formula|installed_cask...]`

Upgrade outdated casks and outdated,unpinned formulae using the same options they were originally install with


### `uses [options] formula [...]`

show formulae and casks that own formula as a dependency

### `--cache [options] [formula|cask...]`

show homebrew download cache

### `--caskroom [cask...]`

show homebrew's caskroom path 


### `--cellar [formula...]`

show homebrew's Cellar path

### `--env,environment [--ehll-][--plain=][formula...]`

who homebrew's build environment as a plain list

### `--prefix [--unbrewed][--installed][formula...]`

show homebrew's install path

### `--repository,--repo[tap...]`

show where homebrew's git repository is located



## developer command

### audit [options] [formula|cask...]`

check the formula for homebrew coding style violations(违反)


### `bottle [options] installed_formula|file [...]`

generate a bottle(binary package) from a installed formula


### `bump [options] [formula|cask...]`

show out-of-date package and the latest version available

> many bump-subcommand,don't want to list


### `cat [--formula][--cask] formula|cask [...]`

show the source of a formula of cask

### `create [options] URL`

generate a formula or ,with --cask,a cask for the downloadable file at URL and open it in the editor

### `debugger [--open] command [...]`

run the command in debug mode

<!-- NOTE: to many developer command to list,leave out(省略) -->


## OFFICIAL EXTERNAL commands

### `alias [alias ...| alias=command]`

who exitsing aliases.


- `--edit`: edit aliases in a text editor

### `unalias alias[...]`

remove aliases



### `bundle [subcommand]`

bundler(捆绑器) for non-Ruby dependencies from homebrew,homebrew cask,mac Appstore

### `services [subcommand]`

manage background services with macOS'launchctl daemon(后台驻留程序) manager or Linux's systemctl service manager

if "sudo" is passed,operate on /Library/LaunchDaemons/ or /usr/lib/system/system(start at boot);  
otherwise,opeerate on ~/Library/LaunchAgents or ~/.config/systemd/user(start at login)

- `brew services [list]`

list information about all managed services for current user

- `brew services info (formula|--all)`

list all managed services for current usr


- `brew services run (formula|--all)`

run the services formula without registering to launch at login

- `brew services start (formula|-all)`

start the services formula immediately and register it to launch to launch at login

- `brew services stop (formula|--all)`

stop the services formula immediately and ungister it from launching at login

- `brew services kill (formula|--all)`

stop the services formula immediately but keep it registered to launch at login

- `brew services restart (formula|--all)`

stop(if necessagy) and start the services formual immediately and register it to launch at login

- `brew services cleanup`

remove all unused services


### `test-bot [options][formula]`

tests the full lifecycle of a homebrew change to a tap(Git repository)


### `which-formula[--explain] command [...]`

show which formula provides the given command



## custom external commands

instructions for creating your own commands can be found in [custom external commands](link)
