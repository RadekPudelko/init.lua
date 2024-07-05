return {
  'stevearc/overseer.nvim',
  opts = {},
  dependencies = {
    "rcarriga/nvim-notify",
    "stevearc/dressing.nvim",
  },
  keys = {
    { "<leader>oo", "<cmd>OverseerToggle!<CR>", mode = "n", desc = "[O]verseer [O]pen" },
    { "<leader>or", "<cmd>OverseerRun<CR>", mode = "n", desc = "[O]verseer [R]un" },
  },
}
