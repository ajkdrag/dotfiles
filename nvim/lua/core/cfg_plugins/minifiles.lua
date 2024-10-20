-- cfg_plugins/minifiles.lua

local minifiles = require('mini.files')

minifiles.setup({
  options = {
    -- Set the default directory to the current directory
    default_directory = vim.fn.getcwd(),
    -- Enable the auto_close option to close the explorer when opening a file
    auto_close = true,
    -- Enable the remember_directory option to reopen from the last visited directory
    remember_directory = true,
  },
})

-- Define the toggle function
local function toggle_minifiles()
  if not minifiles.close() then
    minifiles.open(vim.fn.getcwd(), true)
  end
end

-- Define function to open lua dir
local function open_lua_dir()
  if not minifiles.close() then
    minifiles.open("~/.config/nvim", true)
  end
end


vim.keymap.set('n', '<leader>en', open_lua_dir, { noremap = true, silent = true , desc = "[E]xplore [N]vim config directory"})
vim.keymap.set('n', '<leader>ec', toggle_minifiles, { noremap = true, silent = true, desc = "Toggle [E]xplorer [C]onfiguration"})
