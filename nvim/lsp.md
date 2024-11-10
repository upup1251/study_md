N
im support the Language Sever Protocol(LSP),which means it acts as a client to LSP servers and includes a Lua framework vim.lsp for building enhanced LSP tools.

To get LSP features,follow these steps:
1. install language servers using package manager or Neovim plugin Mason
2. use `vim.lsp.start()` to start the LSP server 
3. use `:checkhealth lsp` to check the buffer is attached to the server
4. confifure keymaps and autocommands to use LSP feature


