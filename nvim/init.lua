-- Set leader key
vim.g.mapleader = ' '

vim.opt.relativenumber = true
-- Enhanced Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

vim.keymap.set('n', '<C-n>', ':Explore<CR>', {desc = 'Open file explorer'})

---------------------------------------------------------------------------
-- LSP setup
---------------------------------------------------------------------------
vim.lsp.enable('nil_ls')

require("conform").setup({
	formatters_by_ft = {
		nix = {"nixfmt"},
	},
	format_on_save = {
		lsp_fallback = true,
	},
})
