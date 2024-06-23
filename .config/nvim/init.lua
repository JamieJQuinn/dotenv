--[[
  File: init.lua
  Description: Entry point file for neovim
]]

-- Bootsraping plugin manager
require "lazy-bootstrap"

-- Settings
require "settings"
require "keybindings"

-- Plugin management {{{
local lazy = require("lazy")
local opts = {
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
  },
}
lazy.setup("plugins", opts)
-- }}}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
