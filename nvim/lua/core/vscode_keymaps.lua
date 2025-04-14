vim.opt.clipboard = 'unnamedplus'

-- map configurations
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set the leader and local leader key for key mappings
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Set 'lazyredraw' and 'ttyfast' for performance
vim.opt.lazyredraw = true
vim.opt.ttyfast = true

-- Remap 'j' and 'k' for navigation
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)


-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


-- Navigate between splits with Ctrl-h/j/k/l
keymap("n", "<C-j>", "<cmd>lua require('vscode').action('workbench.action.navigateDown')<CR>")
keymap("n", "<C-k>", "<cmd>lua require('vscode').action('workbench.action.navigateUp')<CR>")
keymap("n", "<C-L>", "<cmd>lua require('vscode').action('workbench.action.navigateRight')<CR>")
keymap("n", "<C-H>", "<cmd>lua require('vscode').action('workbench.action.navigateLeft')<CR>")


-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)


-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)


-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)


-- format doc
keymap({ "n", "v" }, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
