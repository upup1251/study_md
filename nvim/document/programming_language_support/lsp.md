nvim supports the Language Server Protocol(LSP),which means it  acts as a client to LSP server and includes a Lua framework `vim.lsp` for building enhanced(增强型) LSP tools


# quickstart


## lsp-quickstart


nvim provides an LSP client(LPS客户端),but the server are provided by third parties(第三方).Follow these steps to get LSP work:

1.  install **Language servier** 
- using your package manager
- or by following the upstream install instruction(使用说明)
> find Language server by [Language server list](https://microsoft.github.io/language-server-protocol/implementors/servers/)


2. use `vim.lsp.start()` to start the LSP server,example:

```lua
-- Create an event handler for the FileType autocommand
vim.api.nvim_create_autocmd('FileType', {
  -- This handler will fire when the buffer's 'filetype' is "python"
  pattern = 'python',
  callback = function(args)
    vim.lsp.start({
      name = 'my-server-name',
      cmd = {'name-of-language-server-executable', '--option', 'arg1', 'arg2'},
      -- Set the "root directory" to the parent directory of the file in the
      -- current buffer (`args.buf`) that contains either a "setup.py" or a
      -- "pyproject.toml" file. Files that share a root directory will reuse
      -- the connection to the same LSP server.
      root_dir = vim.fs.root(args.buf, {'setup.py', 'pyproject.toml'}),
    })
  end,
})
```

3. check wheater the buffer is attached to the server
```lua
:checkhealth lsp
```

4. (optional) configure keymaps and autocommands to use LSP 





## lsp-default


1. default: options and keymap

when the NVIM LSP client(nvim lsp客户端) starts,it enables diagnostics `vim.diagnostic`.

Below list the default ***options***:

- `omnifuc`:`vim.lsp.omnifuc()`,use keymap `i_CTRL-X_CTRL-O` to trigger **coompletion**
- `tagfunc`:`vim.lsp.tagfunc()`,use keymap `k`
- `formatexpr`: `vim.lsp.formatexpr()`,can format lines via `gq` if the language server supports it.
- `K`: in Normal mode to `vim.lsp.buf.hover()` unless `keywordprg` is customized or Lspattach 

<!-- TODO: many `options` need to know  -->

some ***keymaps*** are created unconditionally(无条件的) when nvim starts:
- `grn`: in Normal mode to `vim.lsp.buf.rename()`
- `gra`: in Normal mode to `vim.lsp.buf.code_action()`
- `grr`: in Normal mode to`references()`
- `gri`: in Normal mode to `vim.lsp.implementation()`
- `CTRL-S`: in Insert mode to `vim.lsp.buf.signature.help()`


2. way to unset default

to override or delete the default options or 


```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Unset 'formatexpr'
    vim.bo[args.buf].formatexpr = nil
    -- Unset 'omnifunc'
    vim.bo[args.buf].omnifunc = nil
    -- Unmap K
    vim.keymap.del('n', 'K', { buffer = args.buf })
  end,
})
```




