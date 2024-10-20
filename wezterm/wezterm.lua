local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'iceberg_dark'
config.font = wezterm.font('CaskaydiaMono Nerd Font Mono', {weight = 'Regular', stretch = 'Normal', style = 'Normal'})
config.font_size = 14
config.cell_width = 1.0
config.line_height = 1.10
config.window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 0
}

-- and finally, return the configuration to wezterm
return config
