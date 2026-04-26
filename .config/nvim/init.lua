---------------------------------------------
-- Bootstrap lazy.nvim
---------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------
-- Options
---------------------------------------------
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.winborder = "solid"
vim.o.termguicolors = true

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.undofile = true
vim.o.swapfile = false

---------------------------------------------
-- Setup lazy.nvim
---------------------------------------------
require("lazy").setup({
  spec = {
    {
      "aktersnurra/no-clown-fiesta.nvim",
      priority = 1000,
      config = config,
      lazy = false,
    },

    {
      "nvim-treesitter/nvim-treesitter",
      branch = "master",
      lazy = false,
      build = ":TSUpdate"
    },

    { "neovim/nvim-lspconfig", },

    {
      'nvim-telescope/telescope.nvim',
      tag = 'v0.2.0',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {
      'saghen/blink.cmp',
      dependencies = { 'rafamadriz/friendly-snippets' },
      version = '1.*',

      opts = {
        keymap = { preset = 'super-tab' },
        appearance = { nerd_font_variant = 'mono' },
        completion = { documentation = { auto_show = false } },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" }
    }
  },
  -- Configure any other settings here. See the documentation for more details. automatically check for plugin updates
  checker = { enabled = false },
})

---------------------------------------------
-- Additional plugin setup
---------------------------------------------
vim.lsp.enable({ "lua_ls", "clangd", "jdtls" })

-- Disable LSP syntax highlighting
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "cpp", "java" },
  highlight = { enable = true }
})

require('telescope').setup {
  defaults = {
    sorting_strategy = "ascending",
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " ", },
    path_displays = { "smart" },
    layout_config = {
      prompt_position = "top",
      preview_width = 0.5
    }
  }
}

---------------------------------------------
-- Colors
---------------------------------------------
vim.cmd("colorscheme no-clown-fiesta")

vim.api.nvim_set_hl(0, 'StatusLineNC', {
  bg = '#151515',
  fg = '#151515',
})

---------------------------------------------
-- Keymaps 
---------------------------------------------
vim.g.mapleader = " "
local map = vim.keymap.set

map('n', '<leader>q', '<Cmd>quit<CR>')
map('n', '<leader>w', '<Cmd>update<CR>')
map('n', '<leader>e', '<Cmd>Ex<CR>')
map('n', '<leader>s', '<Cmd>source<CR>')
map('n', '<leader><Tab>', '<Cmd>b#<CR>')

map({ 'n', 'x' }, '<leader>y', '"+y')
map({ 'n', 'x' }, '<leader>d', '"+d')
map({ 'n', 'x' }, '<leader>p', '"+p')

map('n', '<leader>a', vim.lsp.buf.code_action)
map('n', '<leader>=', vim.lsp.buf.format)

local builtin = require('telescope.builtin')
map('n', '<leader>b', builtin.buffers)
map('n', '<leader>f', builtin.find_files)
map('n', '<leader>g', builtin.live_grep)
map('n', '<leader>h', builtin.help_tags)
map('n', '<leader>m', builtin.marks)
map('n', '<leader>r', builtin.lsp_references)

