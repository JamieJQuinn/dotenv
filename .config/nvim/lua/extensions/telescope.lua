--[[
  File: telescope.lua
  Description: Telescope plugin configuration
  See: https://github.com/nvim-telescope/telescope.nvim
]]

local actions = require("telescope.actions")
local telescope = require("telescope")
telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      },
    },
  }
}

local action_state = require "telescope.actions.state"

local actions = {}

actions.do_stuff = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr) -- picker state
  local entry = action_state.get_selected_entry()
  print(entry)
end

-- builtin.lsp_workspace_symbols
