local map = vim.keymap.set

-- Escape
map("i", "jk", "<Esc>", { noremap = true })
map("v", "jk", "<Esc>", { noremap = true })

-- Better movement
map("n", "j", "gj", { noremap = true })
map("n", "k", "gk", { noremap = true })

-- Splits: navigate
map("n", "<C-h>", "<C-w>h", { noremap = true })
map("n", "<C-j>", "<C-w>j", { noremap = true })
map("n", "<C-k>", "<C-w>k", { noremap = true })
map("n", "<C-l>", "<C-w>l", { noremap = true })

-- Splits: create
map("n", "<leader>sv", "<C-w>v", { desc = "[S]plit [V]ertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "[S]plit [H]orizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "[S]plit [E]qual" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "[S]plit Close" })

-- Buffers
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "[B]uffer [D]elete" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "[B]uffer [N]ext" })
map("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "[B]uffer [P]rev" })

-- Search
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear [H]ighlight" })

-- Quick save/quit
map("n", "<leader>w", "<cmd>w<CR>", { desc = "[W]rite" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "[Q]uit" })

-- Move lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", { noremap = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })

-- Paste without losing register
map("x", "<leader>p", '"_dP', { desc = "[P]aste without yank" })

-- Python: run file
map("n", "<leader>pp", "<cmd>w<CR><cmd>!python3 %<CR>", { desc = "[P]ython [R]un" })

-- Diagnostics (non-LSP buffers)
map("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- LSP (attached via LspAttach autocmd, see autocmds.lua)
-- K           = hover
-- gd/gD/gi/go/gr/gs = definition/declaration/implementation/type/references/signature
-- <F2>      = rename
-- <leader>ca = code action
