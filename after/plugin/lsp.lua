--https://neovim.io/doc/user/lsp.html
local log = require("plenary.log").new({
    plugin = "radek-lsp",
    level = "debug",
})

local lsp = require("lsp-zero").preset({
    name = "recommended",
    set_lsp_keymaps = true,
    manage_nvim_cmp = false,
})

--lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            --runtime = {
            ---- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            --version = 'LuaJIT',
            --},
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

--.clangd user configs at ~/Library/Preferences/clangd/config.yaml
lsp.configure('clangd', {
    cmd = {
        "clangd",
        --"--completion-style=detailed",
        "--function-arg-placeholders",
        "--header-insertion=never",
        "--all-scopes-completion=0",
        --"--query-driver=/Users/radek/.particle/toolchains/gcc-arm/10.2.1/bin/arm-none-eabi-gcc",
        "--query-driver=/opt/homebrew/bin/arm-none-eabi-gcc",
        --"--compile-commands-dir=/Users/radek/CodeRP/cpp/QFile/QFileTest",
        --"--query-driver=/opt/homebrew/Cellar/arm-none-eabi-gcc/10.3-2021.07/gcc/bin/arm-none-eabi-gcc",
        --"--background-index",
        --"-log=verbose"
    },
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>c", [[:ClangdSwitchSourceHeader<CR>]], {buffer=bufnr})
    end,
    -- Switch between .cpp and .h
})

--require'lspconfig'.ccls.setup {
    --init_options = {
        --clang = {
            ---- Does this do anything??
          ----extraArgs = { "--query-driver=/opt/homebrew/bin/arm-none-eabi-gcc"  },
          ----resourceDir = {"/usr"};
          --resourceDir = "/opt/homebrew/Cellar/llvm/15.0.7_1";
          ----resourceDir = "/opt/homebrew/opt/llvm";
        --};
    --};
--};



--


--lsp.setup_nvim_cmp({
  --mapping = cmp_mappings,
  --sources = cmp_sources
--})

lsp.set_preferences({
    --sign_icons = {
        --error = 'E',
        --warn = 'W',
        --hint = 'H',
        --info = 'I'
    --},
    -- disable sign icons
    sign_icons = { }
})

-- The following remaps only exist for the current buffer that I am on, so they only
-- apply to buffers
lsp.on_attach(function(client, bufnr)
    -- log.debug(client.name)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
-- ctrl+p/n to navigate autocomplete, ctrl+y to accept, ctrl+space starts completion
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

local ts_utils = require("nvim-treesitter.ts_utils")
local cmp_config = lsp.defaults.cmp_config({
    sources = {
        { name = 'nvim_lua', keyword_length=2},
        { name = 'path', keyword_length=2},
        {
           name = 'nvim_lsp', keyword_length=2,
           -- Only suggest variables for function arguments Does not work
           entry_filter = function(entry, ctx)
               local kind = entry:get_kind()
               if not pcall(ts_utils.get_node_at_cursor():type()) then
                   return true
                end
               local node = ts_utils.get_node_at_cursor():type()
               --log.debug(node)
               if node == "argument_list" then
                   --https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/ see CompletionItemKind
                   if kind == 6 then
                       return true
                   else
                       return false
                   end
               end
               return true
           end
        },
        { name = 'tags' },
        { name = 'buffer', keyword_length=5},
        { name = 'luasnip', keyword_length=2},
        
    },
    mapping = cmp_mappings,
    window = {
        completion = cmp.config.window.bordered(),
        documentation = false
    },
    experimental = {
        ghost_text = true
    },
    --formatting = {
        --format = function(entry, vim_item)
            --local item = entry:get_completion_item()

            --if item.detail then
                --vim_item.abbr = string.format('%s %s', item.detail, vim_item.abbr)
            --end

            --return vim_item
        --end,
    --},
})
--lsp.setup()
cmp.setup(cmp_config)


vim.diagnostic.config({
  --float = {
    --source = 'always',
    --border = border
  --},


    --virtual_text = false,
    --signs = trueo
    --float = {
        --border = "single",
        --format = function(diagnostic)
            --return string.format(
                --"%s (%s) [%s]",
                --diagnostic.message,
                --diagnostic.source,
                --diagnostic.code or diagnostic.user_data.lsp.code
            --)
        --end,
    --},
    
    --virtual_text = false,
    virtual_text = true,
})
-- Open floag with with leader d
vim.api.nvim_set_keymap(
  'n', '<Leader>ld', ':lua vim.diagnostic.open_float()<CR>', 
  { noremap = true, silent = true }
)
