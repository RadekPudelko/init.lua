local dap = require("dap")

dap.adapters.python = {
  type = 'executable';
  command = '/Users/radek/.virtualenvs/debugpy/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

local function myPython()
    local obj = vim.system({"pipenv", "--venv"}, {text = true}):wait()
    local myPath = '/opt/homebrew/bin/python3'
    if obj.code == 0 then
        myPath = string.gsub(obj.stdout, "\n", "") .. '/bin/python3'
    end
    print(myPath)
    return myPath
end

-- h dap-configurations
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = myPython;
  },
  {
    type = 'python';
    request = 'launch';
    name = "Django";
    program ="${workspaceFolder}/manage.py";
    args = {"runserver", "--noreload"};
    pythonPath = myPython;
    django = true;
  },
}
vim.keymap.set('n', '<Leader>du', function() require('dapui').close() end)

vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<Leader>ds', function() require('dap').step_over() end)
vim.keymap.set('n', '<Leader>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<Leader>do', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dt', function() require('dap').terminate() end)

local dap_ui = require("dapui")

dap_ui.setup({
    sidebar = {
    elements = {
      "stacks",
      "scopes",
    },
    size = 40,
    position = "left",
  },
  tray = {
    elements = {
      "repl",
    },
    size = 10,
    position = "bottom",
  },
})

-- Start debugging session
vim.keymap.set("n", "<Leader>ds", function()
  dap.continue()
  -- dap_ui.toggle({})
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end)

