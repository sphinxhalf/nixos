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
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

---------------------------------------------------------------------------
--- Treesitter
---------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
})

---------------------------------------------------------------------------
--- Auto-complete
---------------------------------------------------------------------------
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})


---------------------------------------------------------------------------
-- LSP setup
---------------------------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("nil_ls", {
  capabilities = capabilities,
})

vim.lsp.enable("nil_ls")

vim.lsp.config("rust-analyzer", {
  capabilities = capabilities,
})

vim.lsp.enable("rust-analyzer")

require("conform").setup({
  formatters_by_ft = {
    nix = {"nixfmt"},
    rust = {"rustfmt"},
  },
  format_on_save = {
    lsp_fallback = true,
  },
})
