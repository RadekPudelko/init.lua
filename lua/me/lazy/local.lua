return {
  "particle",
  dir="~/.config/particle.nvim",
  -- "RadekPudelko/particle.nvim",
  config = function()
    local particle = require("particle")
    particle.setup({
      log = {
        {
          type = "echo",
          level = vim.log.levels.WARN,
        },
        {
          type = "file",
          filename = "particle.log",
          level = vim.log.levels.DEBUG,
        }
      }
    })
  end
}
