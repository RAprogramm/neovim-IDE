local fn = vim.fn
local execute = vim.api.nvim_command
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute(
        '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path
    )
end
vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
vim.cmd [[packadd packer.nvim]]
require('packer').init {
    git = { clone_timeout = 350 },
    display = {
        title = 'Packer',
        done_sym = '',
        error_syn = '×',
        keybindings = { toggle_info = 'o' },
    },
}
return require('packer').startup {
    function(use)
        use 'wbthomason/packer.nvim'
        -- ui
        use 'nvim-telescope/telescope-ui-select.nvim'
        use 'navarasu/onedark.nvim'
        use 'nvim-lualine/lualine.nvim'
        use 'kyazdani42/nvim-web-devicons'
        use 'lukas-reineke/indent-blankline.nvim'
        use 'norcalli/nvim-colorizer.lua'
        use 'yamatsum/nvim-cursorline'
        use 'rcarriga/nvim-notify'
        use { 'startup-nvim/startup.nvim',
            config = function()
                require("startup").setup(require("config.startup_config"))
            end
        }
        use { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' }
        -- git
        use { 'TimUntersberger/neogit', requires = "nvim-lua/plenary.nvim" }
        use { 'lewis6991/gitsigns.nvim',
            event = 'BufRead',
            config = function()
                require('gitsigns').setup()
            end,
        }

        -- telescope
        use 'nvim-telescope/telescope.nvim'
        use 'nvim-telescope/telescope-project.nvim'
        use "nvim-telescope/telescope-file-browser.nvim"
        use 'nvim-telescope/telescope-symbols.nvim'
        -- utils
        use 'lewis6991/impatient.nvim'
        use 'nvim-lua/popup.nvim'
        use 'nvim-lua/plenary.nvim'
        use 'akinsho/toggleterm.nvim'
        use 'windwp/nvim-autopairs'
        use 'terrortylor/nvim-comment'
        use 'folke/todo-comments.nvim'
        use 'folke/which-key.nvim'
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use { 'RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter' }
        use { 'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter',
        }
        -- lsp
        use 'jose-elias-alvarez/null-ls.nvim'
        use "williamboman/nvim-lsp-installer"
        use 'ray-x/lsp_signature.nvim'
        use 'onsails/lspkind-nvim'
        use 'folke/lsp-colors.nvim'
        use 'neovim/nvim-lspconfig'
        -- completions
        use { 'zbirenbaum/copilot-cmp',
            after = { 'copilot.lua', 'nvim-cmp' },
        }
        use { 'zbirenbaum/copilot.lua',
            event = 'InsertEnter',
            config = function()
                vim.schedule(function()
                    require('copilot').setup()
                end)
            end,
        }
        use 'hrsh7th/cmp-nvim-lsp'
        use { 'saadparwaiz1/cmp_luasnip' }
        use { 'L3MON4D3/LuaSnip',
            config = function()
                require('luasnip').config.setup { history = false }
            end,
        }
        use { 'hrsh7th/nvim-cmp',
            config = function()
                require 'config.cmp'
            end,
            requires = {
                { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
                { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
                { 'kdheepak/cmp-latex-symbols' },
                { 'L3MON4D3/LuaSnip' },
            },
        }
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float { border = 'rounded' }
            end,
        },
    },
}
