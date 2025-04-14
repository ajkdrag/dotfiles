require("luasnip.loaders.from_lua").load()
require("luasnip").config.setup {
  update_events = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
}
