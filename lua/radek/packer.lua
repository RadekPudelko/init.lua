-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}
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
	--Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	use('nvim-treesitter/nvim-treesitter', {use = ':TSUpdate'})
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
end)

