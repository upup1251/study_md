-- color.lua
return {
    { --this is a ui,
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    },

    { --这是一个语法高亮插件
        'nvim-treesitter/nvim-treesitter',
        -- we should add the paser per language
        -- to do it , we can use :TSInstall language_name
        -- to know what language paser we have,we can use :TSInstallInfo
        lazy = true,
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { "markdown", "markdown_inline", "html" },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            }
        end
    },

    { --符号自动成双对
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },

    { --彩虹括号
        -- no many setting
        'HiPhish/rainbow-delimiters.nvim',
    },

    { --垂直线插件
        -- require the treesitter
        -- The scope is not the current indentation level!
        -- Instead, it is the indentation level where variables or functions are accessible
        "lukas-reineke/indent-blankline.nvim",
        event = "LspAttach",
        config = function()
            -- set mutiple indent colors
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)
            -- 与rainbow-delimiters集成
            vim.g.rainbow_delimiters = { highlight = highlight }
            -- start the plugin
            require("ibl").setup {
                scope = { highlight = highlight },
                exclude = {
                    filetypes = {
                        "help",
                        "alpha",
                        "dashboard",
                        "neo-tree",
                        "Trouble",
                        "trouble",
                        "lazy",
                        "mason",
                        "notify",
                        "toggleterm",
                        "lazyterm",
                    }
                }
            }
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end
    },

    { -- the scope of the place whre you are
        -- with the animation ,is vivid
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        lazy = true,
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
            require('mini.indentscope').setup({
                -- default mappings
                mappings = {
                    -- Textobjects
                    object_scope = 'ii',
                    object_scope_with_border = 'ai',

                    -- Motions (jump to respective border line; if not present - body line)
                    goto_top = '[i',
                    goto_bottom = ']i',
                },
            })
        end,
    },


    { --上方的buffer栏
        'akinsho/bufferline.nvim',
        version = "*",
        --图标
        dependencies = 'nvim-tree/nvim-web-devicons',
        keys = {
            { "<A-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "<A-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        },
        config = function()
            require("bufferline").setup {
                options = {
                    offsets = {
                        { --设置nvim-tree打开时buffer偏移
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        },
                    },
                    --这里是样式设计
                    --我们可以通过“:h bufferline-configuration”来查看具体设置
                    separator_style = "slanted"
                },
                vim.api.nvim_create_autocmd("BufAdd", {
                    callback = function()
                        vim.schedule(function()
                            pcall(nvim_bufferline)
                        end)
                    end,
                })
            }
        end
    },


    { --下方的状态栏
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    -- many preset themes can found on lualine github
                    -- theme = 'auto',
                    theme = {
                        normal = {
                            a = { bg = "#007ACC", fg = "#ffffff" },
                            b = { bg = "#007ACC", fg = "#ffffff" },
                            c = { bg = "#007ACC", fg = "#ffffff" },
                        },
                        inactive = {
                            a = { bg = "#a0a0a0", fg = "#ffffff" },
                            b = { bg = "#a0a0a0", fg = "#ffffff" },
                            c = { bg = "#a0a0a0", fg = "#ffffff" }
                        },
                    },
                    component_separators = '',
                    section_separators = '',
                    disabled_filetypes = {
                        statusline = { 'dashboard', 'NvimTree' },
                    }
                },
                sections = {
                    lualine_a = { { 'filetype', colored = false, icon_only = true },
                        { 'filename' } },
                    lualine_b = {
                        {
                            'diagnostics',
                            diagnostics_color = {
                                error = { fg = '#ffffff' },
                                warn = { fg = '#ffffff' },
                                info = { fg = '#ffffff' },
                            },
                        }
                    },
                    lualine_c = { '' },
                    lualine_x = {
                        {
                            'diff',
                            colored = false,
                            diff_color = {
                                -- Same color values as the general color option can be used here.
                                added    = { fg = '#ffffff' }, -- Changes the diff's added color
                                modified = { fg = '#ffffff' }, -- Changes the diff's modified color
                                removed  = { fg = '#ffffff' }, -- Changes the diff's removed color you
                            },
                        },
                        'branch'
                    },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    },


    { --启动界面
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            --go home
            vim.api.nvim_set_keymap('n', '<leader>gh', ':Dashboard<CR>', { noremap = true, silent = true })
            require('dashboard').setup {
                -- change_to_vcs_root = true, --自动跳转到目标文件的.git文件根目录
                -- 我的评价是不如bufferenter自动切换目录的自动命令
                theme = "hyper", --doom/hyper，两种布局
                hide = {
                    statusline = true,
                },
                config = {
                    header = {
                        '                                ',
                        '                                ',
                        ' ⡿⠉⠄⠄⠄⠄⠈⠙⠿⠟⠛⠉⠉⠉⠄⠄⠄⠈⠉⠉⠉⠛⠛⠻⢿⣿⣿⣿⣿⣿ ',
                        ' ⠁⠄⠄⠄⢀⡴⣋⣵⣮⠇⡀⠄⠄⠄⠄⠄⠄⢀⠄⠄⠄⡀⠄⠄⠄⠈⠛⠿⠋⠉ ',
                        ' ⠄⠄⠄⢠⣯⣾⣿⡿⣳⡟⣰⣿⣠⣂⡀⢀⠄⢸⡄⠄⢀⣈⢆⣱⣤⡀⢄⠄⠄⠄ ',
                        ' ⠄⠄⠄⣼⣿⣿⡟⣹⡿⣸⣿⢳⣿⣿⣿⣿⣴⣾⢻⣆⣿⣿⣯⢿⣿⣿⣷⣧⣀⣤ ',
                        ' ⠄⠄⣼⡟⣿⠏⢀⣿⣇⣿⣏⣿⣿⣿⣿⣿⣿⣿⢸⡇⣿⣿⣿⣟⣿⣿⣿⣿⣏⠋ ',
                        ' ⡆⣸⡟⣼⣯⠏⣾⣿⢸⣿⢸⣿⣿⣿⣿⣿⣿⡟⠸⠁⢹⡿⣿⣿⢻⣿⣿⣿⣿⠄ ',
                        ' ⡇⡟⣸⢟⣫⡅⣶⢆⡶⡆⣿⣿⣿⣿⣿⢿⣛⠃⠰⠆⠈⠁⠈⠙⠈⠻⣿⢹⡏⠄ ',
                        ' ⣧⣱⡷⣱⠿⠟⠛⠼⣇⠇⣿⣿⣿⣿⣿⣿⠃⣰⣿⣿⡆⠄⠄⠄⠄⠄⠉⠈⠄⠄ ',
                        ' ⡏⡟⢑⠃⡠⠂⠄⠄⠈⣾⢻⣿⣿⡿⡹⡳⠋⠉⠁⠉⠙⠄⢀⠄⠄⠄⠄⠄⠂⠄ ',
                        ' ⡇⠁⢈⢰⡇⠄⠄⡙⠂⣿⣿⣿⣿⣱⣿⡗⠄⠄⠄⢀⡀⠄⠈⢰⠄⠄⠄⠐⠄⠄ ',
                        ' ⠄⠄⠘⣿⣧⠴⣄⣡⢄⣿⣿⣿⣷⣿⣿⡇⢀⠄⠤⠈⠁⣠⣠⣸⢠⠄⠄⠄⠄⠄ ',
                        ' ⢀⠄⠄⣿⣿⣷⣬⣵⣿⣿⣿⣿⣿⣿⣿⣷⣟⢷⡶⢗⡰⣿⣿⠇⠘⠄⠄⠄⠄⠄ ',
                        ' ⣿⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣾⣿⣿⡟⢀⠃⠄⢸⡄⠁⣸ ',
                        ' ⣿⠄⠄⠘⢿⣿⣿⣿⣿⣿⣿⢛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⢄⡆⠄⢀⣪⡆⠄⣿ ',
                        ' ⡟⠄⠄⠄⠄⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣟⣻⣩⣾⣃⣴⣿⣿⡇⠸⢾ ',
                        '                                ',
                    },
                    -- 显示加载的包
                    packages = { enable = true },
                    -- 关闭日期显示
                    week_header = {
                        enable = false,
                    },
                    -- 快捷键操作
                    shortcut = { --shortcut/center for hyper/doom
                        { action = "Lazy", group = "@property", desc = " Lazy", icon = "󰒲 ", key = "l" },
                        {
                            icon = " ",
                            desc = "Files",
                            group = "Label", --配色组
                            action = "Telescope find_files",
                            key = "f",
                        },
                        --指定搜索目录：action = 'Telescope find_files search_dirs=~/.config/',
                        -- { action = "LazyExtras", group = "DiagnosticHint", desc = " Lazy Extras", icon = " ", key = "x" },
                        { action = "Telescope live_grep", group = "Label", desc = "Text", icon = " ", key = "g" },
                        { action = "Telescope oldfiles", group = "Number", desc = "Oldfiles", icon = " ", key = "o" },
                        { action = 'lua require("persistence").load()', group = "Number", desc = "Session", icon = " ", key = "s" },
                        { action = "Telescope live_grep search_dirs=~/.config", group = "Label", desc = "Config", icon = " ", key = "c" },
                        { action = "Telescope live_grep search_dirs=~/study_md", group = "Label", desc = "Markdown", icon = " ", key = "m" },
                        { action = "qa", desc = " Quit", icon = " ", key = "q" },
                    },
                    --页脚文字
                    footer = function()
                        local quotes = {
                            "两情若是久长时 又岂在朝朝暮暮",
                            "痛苦本身是可以被接纳、理解和化解的"
                        }

                        -- 随机选择一条名言
                        math.randomseed(os.time())
                        local random_quote = quotes[math.random(#quotes)]

                        -- 将随机名言放入一个表中并返回
                        return {
                            " ",
                            random_quote
                        }
                    end
                },
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons',
            'nvim-telescope/telescope.nvim',
        } }
    },

    { --主题
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd [[colorscheme tokyonight]]
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        cond = false
    },
    {
        'shaunsingh/nord.nvim',
        cond = false
        
    }
}
