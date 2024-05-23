return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/neodev.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
                "clangd",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,

                ["clangd"] = function()
                    local lspconfig = require("lspconfig")
                    local clangdCmd = {
                        "clangd",
                        "--background-index",
                        "--function-arg-placeholders=1",
                        "--header-insertion=never",
                        "--all-scopes-completion=1",
                        -- "--completion-style=detailed",
                    }

                    local isParticleProject = require("lspconfig.util").root_pattern("project.properties")(vim.api.nvim_buf_get_name(0)) ~= nil
                    local isParticleDeviceOS = nil
                    if not isParticleProject then
                        isParticleDeviceOS = require("lspconfig.util").root_pattern("deviceOS")(vim.api.nvim_buf_get_name(0)) ~= nil
                    end
                    if isParticleProject or isParticleDeviceOS then
                        table.insert(clangdCmd,"--query-driver=/Users/radek/.particle/toolchains/gcc-arm/10.2.1/bin/arm-none-eabi-gcc")
                        -- table.insert(clangdCmd,"--query-driver=/Users/radek/.particle/toolchains/gcc-arm/9.2.1/bin/arm-none-eabi-gcc")
                    end

                    lspconfig.clangd.setup({
                        cmd = clangdCmd,
                        root_dir = function(fname)
                            return require("lspconfig.util").root_pattern(
                                "Makefile",
                                "project.properties"
                            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json")(fname) or require("lspconfig.util").find_git_ancestor(fname)
                        end,
                        filetypes = { "c", "cpp", "ino"},
                        on_attach = function(client, bufnr)
                            vim.keymap.set("n", "<leader>c", [[:ClangdSwitchSourceHeader<CR>]], {buffer=bufnr})
                        end,
                    })
                end
            }
        })

        -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_select = { behavior = cmp.SelectBehavior.Insert }

        cmp.setup({
            -- snippet = {
            --     expand = function(args)
            --         require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            --     end,
            -- },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'path' },
            --     { name = 'luasnip' }, -- For luasnip users.
            -- }, {
                { name = 'buffer' },
            }),
            -- window = {
            --     completion = cmp.config.window.bordered(),
            --     documentation = false
            -- },
        })

        cmp.setup.filetype({ "sql" }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
            },
        })

        -- Open float with with leader d
        -- TODO does this do anything?
        vim.api.nvim_set_keymap(
            'n', '<Leader>ld', ':lua vim.diagnostic.open_float()<CR>',
            { noremap = true, silent = true }
        )

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
            -- TODO: what does this do
            virtual_text = true,
        })

    require("neodev").setup {}
    end
}

