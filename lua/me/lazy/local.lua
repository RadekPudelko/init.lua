return {
  "particle",
  dir="~/.config/particle.nvim",
  priority = 999,
  -- "RadekPudelko/particle.nvim",
  config = function()
    local particle = require("particle")
    particle.setup({
      log = {
        {
          type = "echo",
          level = vim.log.levels.DEBUG,
        },
        {
          type = "file",
          filename = "particle.log",
          level = vim.log.levels.DEBUG,
        }
      }
    })

    vim.keymap.set("n", "<leader><leader>p", ":Particle<CR>", { nowait=false, noremap=true, silent=true, desc = "Launch Particle.nvim local project configuration" })
  end

}
