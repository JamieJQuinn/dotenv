local map = vim.keymap.set

return {
  "obsidian-nvim/obsidian.nvim",
  enabled = true,
  version = "*", -- use latest release, remove to use latest commit
  ft = "markdown",
  ---@module 'obsidian'
  config = function()
    require "helpers.globals"

    require('obsidian').setup{
      legacy_commands = false, -- this will be removed in the next major release
      workspaces = {
        {
          name = "notes",
          path = os.getenv("NOTES_DIR"),
        },
        {
          name = "wiki",
          path = os.getenv("NOTES_DIR") .. "/wiki",
        },
        {
          name = "cr0ft",
          path = os.getenv("NOTES_DIR") .. "/cr0ft_roguelike_wiki",
        },
      },
      frontmatter = {enabled = false},
      daily_notes = {
        folder = "journal",
        date_format = "%Y-%m-%d",
      },
      ui = {enable = false},
      note_id_func = require('obsidian.builtin').title_to_slug,
      -- footer = {
      --   enabled = true,
      --   format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
      --   hl_group = "Comment",
      --   separator = string.rep("-", 80),
      -- },
    }
  end
};
