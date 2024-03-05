--fat cursor
--vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- no backups
vim.opt.swapfile = false
vim.opt.backup = false
-- undotree access to long running undos
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
--Disable highlighting after search (hit enter)
vim.keymap.set("n", "<CR>", vim.cmd.noh)
-- increment search - ex try /vim.* = and see how search increments
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50 

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

-- Treat .ino files as cpp
vim.api.nvim_create_autocmd("FileType", { pattern = "arduino", command = [[set ft=cpp]] })

vim.opt.pumheight = 15

-- File path of current buffer added to status line
vim.opt.statusline = vim.opt.statusline + "%F"
