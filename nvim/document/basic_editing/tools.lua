--tools.lua
return {
    { --this is the dir tree tool
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = true,
        keys = {
            { "gt", mode = "n" }
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            --这里是键位映射
            vim.keymap.set('n', 'gt', ":NvimTreeFocus<CR>")
            vim.keymap.set('n', 'gT', ":NvimTreeClose<CR>")
            local function my_on_attach(bufnr)
                local api = require('nvim-tree.api')
                local function opts(desc)
                    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end
                vim.keymap.set('n', 'l', api.tree.change_root_to_node, opts('CD'))
                vim.keymap.set('n', 'h', api.tree.change_root_to_parent, opts('Up'))
                vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
                vim.keymap.set('n', 'a', api.fs.create, opts('Create File Or Directory'))
                vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
                vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
                vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
                vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
                vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
                vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
                -- vim.keymap.set('n', 's', api.tree.search_node, opts('Search'))
                -- vim.keymap.set('n', 's', function()
                --   -- 检查当前 buffer 是否是 nvim-tree
                --   if vim.bo.filetype == 'NvimTree' then
                --     -- 递归展开所有目录
                --     require 'nvim-tree.api'.tree.expand_all()
                --     -- 调用 Vim 自带的搜索模式
                --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("/", true, false, true), 'n', false)
                --   end
                -- end, { desc = 'Expand all directories and start search in nvim-tree' })
            end
            -- 这里是config
            -- disable netrw at the very start of your init.lua
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- optionally enable 24-bit colour
            vim.opt.termguicolors = true

            -- empty setup using defaults
            require("nvim-tree").setup({
                on_attach = my_on_attach,
                view = {
                    width = 25
                }
            })
        end,
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                --关闭f、t的增强
                char = { enabled = false }
            }

        },
        -- stylua: ignore
        keys = {
            { "S", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
            --{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
            -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },

    { -- file find tool
        'nvim-telescope/telescope.nvim',
        lazy = true,
        -- start by dashboard now
        -- keys = {
        --     "<leader>ff", "<leader>fg", "<leader>fb", "<leader>fk", "<leader>fm", "<leader>fc"
        -- },
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            "debugloop/telescope-undo.nvim",
        },
        config = function()
            require("telescope").setup ({
                vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {}),
                vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {}),
                vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {}),
                -- vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {}),
                vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, {}),
                vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, {}),
                -- 使用 <leader>j 快速查看跳转历史
                vim.keymap.set('n', '<leader>fj', require('telescope.builtin').jumplist, {}),
                vim.keymap.set('n', '<leader>fl', require('telescope.builtin').diagnostics, {}),
                vim.keymap.set('n', '<leader>fs', require('telescope.builtin').colorscheme, {}),
                vim.keymap.set('n', '<leader>fr', require('telescope.builtin').registers, {}),


                -- 查询当前目录下的todo，可添加
                -- :TodoTelescope cwd=~/projects/foobar
                -- :TodoTelescope keywords=TODO,FIX
                vim.keymap.set('n', '<leader>ft', ":TodoTelescope<CR>", {}),

                -- 对指定目录进行搜索，这里是我的~/study_md/目录（markwodn笔记目录）
                -- vim.keymap.set('n', '<leader>fm', function()
                --   require('telescope.builtin').find_files({ search_dirs = {  "~/study_md" } })
                -- end, { noremap = true, silent = true }),
                vim.keymap.set('n', '<leader>fm', function()
                    require('telescope.builtin').live_grep({ search_dirs = { "~/study_md" } })
                end, { noremap = true, silent = true }),
                vim.keymap.set('n', '<leader>fc', function()
                    require('telescope.builtin').live_grep({ search_dirs = { "~/.config" } })
                end, { noremap = true, silent = true }),

                defaults = {
                    mappings = {
                        i = {
                            ["<C-c>"] = require "telescope.actions".close,
                        },
                        n = {
                            ["<esc>"] = require "telescope.actions".close,
                            ["q"] = require "telescope.actions".close,
                            -- ["<CR>"] = require "telescope.actions".select_default,
                            ["o"] = require("telescope.actions").select_default,

                            ["x"] = require "telescope.actions".select_horizontal,
                            ["v"] = require "telescope.actions".select_vertical,

                            ["<Tab>"] = require "telescope.actions".toggle_selection + require "telescope.actions".move_selection_worse,
                            ["j"] = require "telescope.actions".move_selection_next,
                            ["k"] = require "telescope.actions".move_selection_previous,
                            ["gg"] = require "telescope.actions".move_to_top,
                            ["G"] = require "telescope.actions".move_to_bottom,

                            ["K"] = require "telescope.actions".preview_scrolling_up,
                            ["J"] = require "telescope.actions".preview_scrolling_down,
                            ["H"] = require "telescope.actions".preview_scrolling_left,
                            ["L"] = require "telescope.actions".preview_scrolling_right,

                            ["?"] = require "telescope.actions".which_key,
                        }
                    }
                },
                pickers = {
                    colorscheme = {
                        enable_preview = true
                    }

                },

                find_files = {
                    -- 在这里设置你希望搜索的目录
                    search_dirs = { "~/study_md/**" }
                },
                find_grep = {
                    search_dirs = { "~/study_md" }
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    undo = {
                        -- telescope-undo.nvim config, see below
                    },
                }

            })
            -- require("telescope").load_extension("fzf")
            require("telescope").load_extension("undo")
            vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>")
            --n: ["u"] = require("telescope-undo.actions").restore,
        end
    },




    { --这是自动保存、手动加载sessions的插件
        --automatically saves the active session under ~/.local/state/nvim/sessions on exit
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {
            options = vim.opt.sessionoptions:get(),
            need = 0
        },
        -- stylua: ignore
        keys = {
            { "<leader>lS", function() require("persistence").load() end, desc = "Restore Session" },
        },
    },

    {                  --the surroud add/change/del tools
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "LspAttach",
        config = function()
            require("nvim-surround").setup({
            })
        end
        --use:
        --add:ys{motion}{char}
        --delete:ds{char}
        --change:cs{tarfet}{repalcement}
    },

    { --the is a comment helper
        'numToStr/Comment.nvim',
        lazy = true,
        event = "LspAttach",
        opts = {
            -- add any options here
        },
        config = function()
            require('Comment').setup()
        end
        -- use:
        -- `gcc` - Toggles the current line using linewise comment
        -- `gbc` - Toggles the current line using blockwise comment
        -- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
        -- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
        -- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
        -- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
    },

    { --for : todo/note/fix/warning/perf/hack
        -- usage: write `:TODO: xxxx` then take a gcc
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },

}


-- 一些命令行工具，保存到此处防止忘记
-- tldr:too long;don't read,简化版的man手册
-- figlet:ascii art生成
-- zoxide: 记性好的cd
-- carbonyl: 终端浏览器
