-- 数据库
return {
    -- {
    --     'tpope/vim-dadbod'
    -- },
    --
    -- {
    --     'kristijanhusak/vim-dadbod-ui',
    --     dependencies = {
    --         { 'tpope/vim-dadbod',                     lazy = true },
    --         { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    --     },
    --     cmd = {
    --         'DBUI',
    --         'DBUIToggle',
    --         'DBUIAddConnection',
    --         'DBUIFindBuffer',
    --     },
    --     keys = {
    --         "<leader>su",
    --     },
    --     init = function()
    --         -- Your DBUI configuration
    --         -- the file  save in the ~/.local/share/db_ui
    --         vim.g.db_ui_use_nerd_fonts = 1
    --         vim.g.db_ui_show_help = 0
    --         vim.g.db_ui_winwidth = 30
    --     end,
    --     config = function()
    --         vim.keymap.set({ "n" }, "<leader>su", "<cmd>DBUI<CR>")
    --         vim.keymap.set({ "n" }, "gt", "<cmd>DBUIToggle<CR>")
    --     end
    -- },
    -- url for mysql
    -- mysql://<username>:<password>@<host>:<port>/<db_name>
    --
    {
        "kndndrj/nvim-dbee",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        build = function()
            require("dbee").install()
        end,

        keys = {
            { "<leader>db", "<cmd>Dbee toggle<cr>", desc = "toggle Dbee ui" },
        },
        config = function()
            require("dbee").setup({
                sources = {
                    -- 通过
                    require("dbee.sources").MemorySource:new({
                        {
                            name = "Hospital",
                            url = "mysql://upupup:tianqi985@tcp(127.0.0.1:06)/hospital",
                            type = "mysql"
                        }
                    }),
                    -- 通过环境变量添加源
                    -- require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
                    -- 通过json文件
                    require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
                }
            })
        end,
    },
}
