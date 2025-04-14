local function whichkeySetup()
  local whichkey = require('which-key')

  whichkey.setup()
  whichkey.add(
    {
      { "<leader>c",  group = "[C]ode" },
      { "<leader>c_", hidden = true },
      { "<leader>e",  group = "[E]xplorer" },
      { "<leader>e_", hidden = true },
      { "<leader>r",  group = "[R]ename" },
      { "<leader>r_", hidden = true },
      { "<leader>s",  group = "[S]earch" },
      { "<leader>s_", hidden = true },
      { "<leader>w",  group = "[W]orkspace" },
      { "<leader>w_", hidden = true },
    }
  )
  -- whichkey.register({
  --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  --   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  --   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  --   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  --   ['<leader>e'] = { name = '[E]xplorer', _ = 'which_key_ignore' },
  -- })
end

whichkeySetup()
