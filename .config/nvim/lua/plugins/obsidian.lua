return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  -- cmd = 'Obsidian',
  ft = "markdown",
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
      footer = {enabled = false},
      ui = {enable = false},
      statusline = {enabled = false},
      checkbox = {enabled = false},

      picker = {
        name = "fzf-lua",
      },

      daily_notes = {
        folder = "journal",
        date_format = "%Y-%m-%d",
      },
      note_id_func = require('obsidian.builtin').title_to_slug,
    }

    local actions = require "obsidian.actions"
    vim.keymap.set("n", "<Tab>", function()
      actions.nav_link "next"
    end, { buffer = true, desc = "Go to next link" })
    vim.keymap.set("n", "<S-Tab>", function()
      actions.nav_link "prev"
    end, { buffer = true, desc = "Go to previous link" })
  end
};
