return {
  {'MunifTanjim/nui.nvim'},
  "stevearc/dressing.nvim",
  config = function()
    require('dressing').setup({
      input = {
        enabled = true,
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:Normal",
          -- winhighlight = 'NormalFloat:DiagnosticError'
        }
      },
      select = {
        enabled = true,
        -- win_options = {
        --   winhighlight = "Normal:Normal,FloatBorder:Normal",
        -- },
        backend = { "telescope", "nui" },
        -- backend = { "nui" },
        nui = {
          -- position = "50%",
          -- size = nil,
          -- relative = "editor",
          border = {
            style = "rounded",
          },
          -- buf_options = {
          --   swapfile = false,
          --   filetype = "DressingSelect",
          -- },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
            -- winhighlight = 'NormalFloat:DiagnosticError',
            winblend = 0,
          },
          -- max_width = 80,
          -- max_height = 40,
          -- min_width = 40,
          -- min_height = 10,
        },

      },
    })
  end,
}
