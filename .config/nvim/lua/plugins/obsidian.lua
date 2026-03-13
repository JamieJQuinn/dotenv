local map = vim.keymap.set

return {
  "obsidian-nvim/obsidian.nvim",
  enabled = false,
  version = "*", -- use latest release, remove to use latest commit
  ft = "markdown",
  ---@module 'obsidian'
  config = function()
    require "helpers.globals"

    nm('<leader>wp', '<cmd>ObsidianQuickSwitch<CR>')
    nm('<leader>wf', '<cmd>ObsidianSearch<CR>')
    nm('<leader>w#', '<cmd>ObsidianTags<CR>')
    nm('<leader>wb', '<cmd>ObsidianBacklinks<CR>')
    if (os.getenv("NOTES_DIR")) then
      NOTES_DIR = os.getenv("NOTES_DIR")

      map("n", "<leader>wj", function()
        vim.api.nvim_set_current_dir(NOTES_DIR)
        vim.cmd("e ./journal/2025.md")
      end)

      map("n", "<leader>ww", function()
        vim.api.nvim_set_current_dir(NOTES_DIR)
        vim.cmd("e ./wiki/readme.md")
      end)
      map("n", "<leader>wq", function()
        vim.api.nvim_set_current_dir(NOTES_DIR)
        vim.cmd("e ./quicknote.md")
      end)
      map("n", "<leader>wn", function()
        vim.api.nvim_set_current_dir(NOTES_DIR)
        vim.cmd("FzfLua files")
      end)
      map("n", "<leader>wt", function()
        vim.api.nvim_set_current_dir(NOTES_DIR)
        vim.cmd("e todo/todo.md")
      end)

      map("n", "<leader>wc", function()
        vim.api.nvim_set_current_dir(NOTES_DIR .. "/cr0ft_roguelike_wiki")
        vim.cmd("e ./index.md")
      end)
    end
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
