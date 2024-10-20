-- Set the leader and local leader key for key mappings
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

-- Set the behavior of the backspace key
vim.opt.backspace:append('indent')
vim.opt.backspace:append('eol')
vim.opt.backspace:append('start')

-- Enable command-line completion menu
vim.opt.showcmd = true
vim.opt.wildmenu = true

-- Ensure the status line is always shown
vim.opt.laststatus = 2

-- Automatically write the buffer to the file when switching buffers or exiting Vim
vim.opt.autowrite = true

-- Highlight the current line
vim.opt.cursorline = true

-- Automatically reload files from disk if modified outside of Vim
vim.opt.autoread = true

-- Enable line numbers in the current window
vim.wo.number = true

-- Indentation settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Disable swap file creation
vim.cmd('set noswapfile')

-- Enable true color support for the terminal
vim.cmd('set termguicolors')

-- Set foldmethods and foldlevels
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99

-- Set 'lazyredraw' and 'ttyfast' for performance
vim.opt.lazyredraw = true
vim.opt.ttyfast = true

-- Search related options
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable system clipboard integration
vim.opt.clipboard = 'unnamedplus'
