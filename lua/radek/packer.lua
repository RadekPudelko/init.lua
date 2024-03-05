-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'


    use '/Users/radek/.config/particle.nvim'
    -- use 'RadekPudelko/particle.nvim'

    use "jose-elias-alvarez/null-ls.nvim"


    use 'folke/zen-mode.nvim'

    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,}

	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		-- config = function()
		-- 	vim.cmd('colorscheme rose-pine')
		-- end
	})
    use({'ellisonleao/gruvbox.nvim',
        as = 'gruvbox',
		-- config = function()
		-- 	vim.cmd('colorscheme gruvbox')
		-- end
    })
    use({"sainnhe/sonokai",
        as = 'sonokai',
    })
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    }
    use('nvim-treesitter/playground')
	--Lets you mark and switch thru marked files quickly
	use('theprimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp',
              requires = {
                {
                  'quangnguyen30192/cmp-nvim-tags',
                  -- if you want the sources is available for some file types
                  ft = {
                    'c++',
                    'cpp',
                    'c'
                  }
                }
              },
            },
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    }
    -- use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
    use{'windwp/nvim-autopairs',
        config = function() require("nvim-autopairs").setup {} end
    }
    use('ray-x/lsp_signature.nvim')
    --use('quangnguyen30192/cmp-nvim-tags')
    --
    use('lewis6991/gitsigns.nvim')

    use('mfussenegger/nvim-dap')
    use('mfussenegger/nvim-dap-ui')
    use('simrat39/rust-tools.nvim')
    use("nvim-treesitter/nvim-treesitter-context");
end)

