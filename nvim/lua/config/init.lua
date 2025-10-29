local keymaps = require("config.keymaps")
local utils = require("config.utils")

require("config.options")
keymaps.setup_keymaps()

require("config.lazy")
keymaps.setup_telescope()

require("config.lsp_and_tools")

utils.set_theme("catppuccin")
