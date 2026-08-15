-- =========================================================
-- CONFIGURAÇÕES BÁSICAS
-- =========================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- =========================================================
-- INSTALAÇÃO DO LAZY.NVIM
-- =========================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local resultado = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        error("Erro ao instalar lazy.nvim:\n" .. resultado)
    end
end

vim.opt.rtp:prepend(lazypath)

-- =========================================================
-- PLUGINS
-- =========================================================

require("lazy").setup({

    -- Tema Catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,

        opts = {
            flavour = "mocha",
            transparent_background = false,
            auto_integrations = true,
        },

        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    {
    	"windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },

    -- Procurar arquivos e textos
    {
        "nvim-telescope/telescope.nvim",
        version = "*",

        dependencies = {
            "nvim-lua/plenary.nvim",

            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },

        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({})

            pcall(telescope.load_extension, "fzf")

            vim.keymap.set(
                "n",
                "<leader>ff",
                builtin.find_files,
                { desc = "Procurar arquivos" }
            )

            vim.keymap.set(
                "n",
                "<leader>fg",
                builtin.live_grep,
                { desc = "Procurar texto no projeto" }
            )

            vim.keymap.set(
                "n",
                "<leader>fb",
                builtin.buffers,
                { desc = "Mostrar arquivos abertos" }
            )

            vim.keymap.set(
                "n",
                "<leader>fh",
                builtin.help_tags,
                { desc = "Pesquisar ajuda" }
            )
        end,
    },

    -- Explorador de arquivos
    {
        "stevearc/oil.nvim",
        lazy = false,

        dependencies = {
            {
                "nvim-mini/mini.icons",
                opts = {},
            },
        },

        opts = {
            default_file_explorer = true,

            view_options = {
                show_hidden = true,
            },
        },

        keys = {
            {
                "-",
                "<CMD>Oil<CR>",
                desc = "Abrir explorador de arquivos",
            },
        },
    },

    -- Informações do Git nas linhas
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },

    -- Autocomplete
    {
        "saghen/blink.cmp",
        version = "1.*",

        dependencies = {
            "rafamadriz/friendly-snippets",
        },

        opts = {
            -- Tab funciona de maneira parecida com o VS Code
            keymap = {
                preset = "super-tab",
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },

            fuzzy = {
                implementation = "prefer_rust",
            },

            signature = {
                enabled = true,
            },
        },

        opts_extend = {
            "sources.default",
        },
    },

    -- Configurações dos servidores LSP
    {
        "neovim/nvim-lspconfig",
    },

    -- Instalador de LSPs, formatadores e ferramentas
    {
        "mason-org/mason.nvim",
        opts = {},
    },

    -- Integra Mason com os LSPs
    {
        "mason-org/mason-lspconfig.nvim",

        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },

        opts = {
            ensure_installed = {
                "lua_ls", -- Lua
                "clangd", -- C e C++
                "pyright", -- Python
                "jdtls", -- Java
                "html", -- HTML
                "cssls", -- CSS
                "ts_ls", -- JavaScript e TypeScript
            },

            automatic_enable = true,
        },
    },

    -- Melhor destaque de sintaxe
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",

        config = function()
            local linguagens = {
                "lua",
                "vim",
                "vimdoc",
                "c",
                "cpp",
                "java",
                "python",
                "javascript",
                "typescript",
                "html",
                "css",
                "json",
                "bash",
                "markdown",
                "markdown_inline",
                "verilog",
            }

            require("nvim-treesitter").install(linguagens)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "lua",
                    "vim",
                    "c",
                    "cpp",
                    "java",
                    "python",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "html",
                    "css",
                    "json",
                    "sh",
                    "bash",
                    "markdown",
                    "verilog",
                    "systemverilog",
                },

                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },

    -- Formatação de código
    {
        "stevearc/conform.nvim",
        opts = {},

        keys = {
            {
                "<leader>f",

                function()
                    require("conform").format({
                        async = true,
                        lsp_format = "fallback",
                    })
                end,

                mode = {
                    "n",
                    "v",
                },

                desc = "Formatar código",
            },
        },
    },

}, {
    checker = {
        enabled = true,
        notify = false,
    },

    change_detection = {
        notify = false,
    },
})

-- =========================================================
-- ATALHOS DO LSP
-- =========================================================

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opcoes = {
            buffer = event.buf,
            silent = true,
        }

        vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            vim.tbl_extend("force", opcoes, {
                desc = "Ir para definição",
            })
        )

        vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            vim.tbl_extend("force", opcoes, {
                desc = "Mostrar referências",
            })
        )

        vim.keymap.set(
            "n",
            "K",
            vim.lsp.buf.hover,
            vim.tbl_extend("force", opcoes, {
                desc = "Mostrar documentação",
            })
        )

        vim.keymap.set(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            vim.tbl_extend("force", opcoes, {
                desc = "Renomear variável ou função",
            })
        )

        vim.keymap.set(
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            vim.tbl_extend("force", opcoes, {
                desc = "Ações de código",
            })
        )
    end,
})
