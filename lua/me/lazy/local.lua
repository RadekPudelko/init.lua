return {
    "particle",
    dir="~/.config/particle.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim"
    },
    -- 'RadekPudelko/particle.nvim'
    config = function()
        -- local particle = require("particle")
        require("particle")
        -- particle.setup()
    end
}
