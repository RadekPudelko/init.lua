return {
  {'MunifTanjim/nui.nvim'},
  {
    "stevearc/dressing.nvim",
    config = function()
      require('dressing').setup({
        input = {
          enabled = true,
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
          }
        },
        select = {
          enabled = true,
          backend = { "telescope", "nui" },
          nui = {
            position = "50%",
            size = nil,
            relative = "editor",
            border = {
              style = "rounded",
            },
            buf_options = {
              swapfile = false,
              filetype = "DressingSelect",
            },
            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:Normal",
              winblend = 0,
            },
          }
        },
      })
    end,
  }
}
