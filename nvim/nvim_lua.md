# vim命名空间

Neovim 会暴露一个全局的 vim 变量来作为 Lua 调用 Vim 的 APIs 的入口。它还提供给用户一些额外的函数和子模块“标准库”

一些比较实用的函数和子模块如下：
- `vim.inspect`: 把 Lua 对象以更易读的方式打印（在打印 Lua table 时会很有用）
- `vim.regex`: 在 Lua 中使用 Vim 正则表达式
- `vim.api`: vim 暴露的 API (:h API) 模块（别的远程调用也是调用同样的 API)
- `vim.ui`: 可被插件覆写的 UI 相关函数
- `vim.loop`: Neovim 的 event loop 模块（使用 LibUV)
- `vim.lsp`: 控制内置 LSP 客户端的模块
- `vim.treesitter`: 暴露 tree-sitter 库中一些实用函数的模块

