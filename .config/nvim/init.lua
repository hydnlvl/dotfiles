---------------------------------------------
-- Options
---------------------------------------------
-- UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.winborder = "solid"
vim.o.laststatus = 3
vim.o.termguicolors = true

-- Behavior
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.undofile = true
vim.o.swapfile = false

---------------------------------------------
-- Plugin downloads
---------------------------------------------
vim.pack.add({
  { src = "https://github.com/aktersnurra/no-clown-fiesta.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/saghen/blink.lib" },
})

---------------------------------------------
-- Plugin setup
---------------------------------------------
vim.lsp.enable({ "lua_ls", "clangd", "pyright", "jdtls" })
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- Disable semantic token highlighting
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

require("nvim-treesitter.").install { "lua", "cpp", "java", "markdown" }
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

require("telescope").setup {
  defaults = {
    sorting_strategy = "ascending",
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " ", },
    path_displays = { "smart" },
    layout_config = {
      prompt_position = "top",
      width = { padding = 0 },
      height = { padding = 0 },
      preview_width = 0.5
    }
  }
}

---------------------------------------------
-- Colors
---------------------------------------------
require("no-clown-fiesta").setup {
  theme = 'dark',
  transparent = true
}
vim.cmd.colorscheme("no-clown-fiesta")

vim.api.nvim_set_hl(0, 'StatusLine', {
  bg = 'none',
})


---------------------------------------------
-- Keymaps 
---------------------------------------------
local map = vim.keymap.set
vim.g.mapleader = ' '
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remaps
map({'n', 'x'}, 'H', '^')
map({'n', 'x'}, 'J', '}')
map({'n', 'x'}, 'K', '{')
map({'n', 'x'}, 'L', '$')
map({'n', 'x'}, 'M', 'J')

-- Quick commands
map('n', '<leader>q', '<Cmd>quit<CR>')
map('n', '<leader>w', '<Cmd>update<CR>')
map('n', '<leader>e', '<Cmd>Ex<CR>')
map('n', '<leader><Tab>', '<Cmd>b#<CR>')

-- LSP
map('n', '<leader>k', vim.lsp.buf.hover)
map('n', '<leader>a', vim.lsp.buf.code_action)
map('n', '<leader>=', vim.lsp.buf.format)

-- System clipboard
map({ 'n', 'x' }, '<leader>y', '"+y')
map({ 'n', 'x' }, '<leader>d', '"+d')
map({ 'n', 'x' }, '<leader>p', '"+p')
map({ 'n', 'x' }, '<leader>Y', '"+Y')
map({ 'n', 'x' }, '<leader>D', '"+D')
map({ 'n', 'x' }, '<leader>P', '"+P')

-- Telescope pickers
local builtin = require('telescope.builtin')
map('n', '<leader>b', builtin.buffers)
map('n', '<leader>f', builtin.find_files)
map('n', '<leader>g', builtin.live_grep)
map('n', '<leader>h', builtin.help_tags)
map('n', '<leader>m', builtin.marks)
map('n', '<leader>r', builtin.lsp_references)
