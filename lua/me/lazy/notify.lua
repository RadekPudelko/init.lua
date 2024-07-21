return {
  'rcarriga/nvim-notify',
  priority = 1000,
  config = function()
    local notify = require("notify")
    notify.setup({})
    vim.notify = notify
  end
}
