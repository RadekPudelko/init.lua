local builtin = require('telescope.builtin')

-- Fuzzy finding thru all files
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- Fuzzy finding thru files in git
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- Grep for a string used in the projecet
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
