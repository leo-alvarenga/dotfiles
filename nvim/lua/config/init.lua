local keymaps = require("config.keymaps")
local utils = require("config.utils")

require("config.options")
keymaps.setup_keymaps()

require("config.lazy")
keymaps.setup_telescope()

utils.set_theme("catppuccin")
