local dap = require("dap")

dap.adapters.python = {
  type = 'executable';
  command = '/Users/radek/.virtualenvs/debugpy/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

function myvenv()
    return vim.api.nvim_exec('!pipenv --venv', true)
end

-- h dap-configurations
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = '/opt/homebrew/bin/python3';
  },
  {
    type = 'python';
    request = 'launch';
    name = "Django";
    program ="${workspaceFolder}/manage.py";
    args = {"runserver"};
    pythonPath = function()
        local ok, mypath = pcall(myvenv)
        if ok then
            mypath = string.sub(mypath, 19, #mypath - 1) .. '/bin/python'
        end
        if ok and vim.fn.executable(mypath) then
            return mypath
        else
            return '/opt/homebrew/bin/python3'
        end
    end;
    django = true;
  },
  -- {
  --   type = 'python';
  --   request = 'launch';
  --   name = "Launch file";
  --   program = function()
  --       if vim.loop.fs_stat('manage.py') then
  --           return "${workspaceFolder}/manage.py"
  --       else
  --           return "${file}"
  --       end
  --   end;
  --
  --   args = function()
  --       if vim.loop.fs_stat('manage.py') then
  --           return {"runserver"}
  --       else
  --           return {}
  --       end
  --   end;
  --
  --
  --   pythonPath = function()
  --       local ok, mypath = pcall(myvenv)
  --       if ok then
  --           mypath = string.sub(mypath, 19, #mypath - 1) .. '/bin/python'
  --       end
  --       if ok and vim.fn.executable(mypath) then
  --           return mypath
  --       else
  --           return '/opt/homebrew/bin/python3'
  --       end
  --   end;
  --
  --   django = function()
  --       if vim.loop.fs_stat('manage.py') then
  --           return true;
  --       else
  --           return false;
  --       end
  --   end;
  --
  -- },
}
vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<Leader>ds', function() require('dap').step_over() end)
vim.keymap.set('n', '<Leader>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<Leader>do', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dt', function() require('dap').terminate() end)

-- print(val)
require("dapui").setup()
