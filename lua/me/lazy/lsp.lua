function printTable(t)
  local printTable_cache = {}

  local function sub_printTable(t, indent)
    if (printTable_cache[tostring(t)]) then
      print(indent .. "*" .. tostring(t))
    else
      printTable_cache[tostring(t)] = true
      if (type(t) == "table") then
        for pos, val in pairs(t) do
          if (type(val) == "table") then
            print(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
            sub_printTable(val, indent .. string.rep(" ", string.len(pos) + 8))
            print(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
          elseif (type(val) == "string") then
            print(indent .. "[" .. pos .. '] => "' .. val .. '"')
          else
            print(indent .. "[" .. pos .. "] => " .. tostring(val))
          end
        end
      else
        print(indent .. tostring(t))
      end
    end
  end

  if (type(t) == "table") then
    print(tostring(t) .. " {")
    sub_printTable(t, "  ")
    print("}")
  else
    sub_printTable(t, "  ")
  end
end

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
        dir = "~/.config/particle.nvim",
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
          -- TODO: There is some amount of code rerunning more than it should here
          -- TODO: Need to handle just browsing the device os, it is not known which ccjson to use then as
          -- there is not .partcile.json
          local lspconfig = require("lspconfig")
          local particle = require("particle")
          -- TODO: Figure out how to load particle only when needed
          particle.setup()

          lspconfig.clangd.setup({
            on_new_config = function(new_config, new_root_dir)
              local command = {
                "clangd",
                "--background-index",
                "--function-arg-placeholders=1",
                "--header-insertion=never",
                "--all-scopes-completion=1",
                -- "--completion-style=detailed",
              }
              local type, root = particle.get_project_type(vim.api.nvim_buf_get_name(0))
              -- print(type, root)
              if type ~= nil then
                local query_driver = particle.get_query_driver()
                if query_driver ~= nil then
                  table.insert(command, "--query-driver=" .. query_driver)
                else
                  table.insert(command,"--query-driver=/Users/radek/.particle/toolchains/gcc-arm/10.2.1/bin/arm-none-eabi-gcc")
                end
                if type == particle.PROJECT_DEVICE_OS then
                  local cc_dir = particle.get_device_os_ccjson_dir()
                  table.insert(command, "--compile-commands-dir=" .. cc_dir)
                else
                end
              end
              new_config.cmd = command
            end,

            -- fname is full path of the buffer
            root_dir = function(fname)
              local type, root = particle.get_project_type(fname)
              if type ~= nil then
                if root ~= nil then
                  return root
                end
              end
              root = vim.fs.root(0, {'Makefile', '.git', 'compile_commands.json'})
              return root
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
            }, {
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

        vim.lsp.handlers['textDocument/signatureHelp']  = vim.lsp.with(vim.lsp.handlers['signature_help'], {
            border = 'single',
            close_events = { "CursorMoved", "BufHidden" },
        })
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help)

    require("neodev").setup {}
    end
}

