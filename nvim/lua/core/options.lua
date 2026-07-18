-- Leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Behavior
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.mouse = "a"

-- UI
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.laststatus = 2
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Files
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- Performance
vim.opt.lazyredraw = true
vim.opt.ttyfast = true



-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Scrolling
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- LSP
vim.lsp.inlay_hint.enable(true)
