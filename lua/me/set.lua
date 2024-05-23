vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.showmode = false

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
-- increment search - ex try /vim.* = and see how search increments
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Treat .ino files as cpp
vim.api.nvim_create_autocmd("FileType", { pattern = "arduino", command = [[set ft=cpp]] })

-- Max number of popup menu items
vim.opt.pumheight = 10

