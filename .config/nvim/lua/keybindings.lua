require "helpers/globals"
require "helpers/keyboard"

local map = vim.keymap.set

g.mapleader = ' ' -- Use Space, like key for alternative hotkeys

-- Just wee shortcuts
nm('j', 'gj' )
nm('k', 'gk' )
nm('<c-h>', '<c-w><c-h>' )
nm('<c-l>', '<c-w><c-l>' )
nm('<c-j>', '<c-w><c-j>' )
nm('<c-k>', '<c-w><c-k>' )
nm('vv', 'viw')
vm('p', 'P')
nm('<bs>', '<c-o>')
nm('<leader>v', '<cmd>vsplit<CR>' )
nm('<leader>q', '<cmd>quit<CR>' )
nm('<leader>w', '<cmd>write<CR>' )
nm('<leader>n', '<cmd>noh<cr>')
nm('<leader>e', '<cmd>e#<CR>' )
map({"i", "c"}, "<C-BS>", "<C-W>")
-- nm('<leader>b', '<cmd>lua if vim.o.bg == "dark" then vim.o.bg = "light" else vim.o.bg = "dark" end<CR>')

-- Commenting
nm('<leader>/', '<Plug>(comment_toggle_linewise_current)')
vm('<leader>/', '<Plug>(comment_toggle_linewise_visual)')

-- Navigate errors
map("n", "]e", function() vim.diagnostic.jump({count = 1, float=true}) end)
map("n", "[e", function() vim.diagnostic.jump({count = -1, float=true}) end)

-- Make
-- nm('<F5>', '<cmd>make<CR>') // I'm sick of dealing with fn-lock
nm('<leader>m', '<cmd>make<CR>')

-- Quick toggles
nm('<leader>gc', '<cmd>Git commit<cr>')
nm('<leader>a', '<cmd>AerialToggle!<CR>')

-- TODOs
nm('<c-t>', '<cmd>Trouble todo filter = {tag = {TODO}} filter.buf=0<CR>')
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next({keywords = { "TODO", "HACK" }})
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev({keywords = { "TODO", "HACK" }})
end, { desc = "Prev todo comment" })

-- Markdown
vim.keymap.set('v', '<leader>b', 'c**<c-r>"**')
vim.keymap.set('v', '<leader>i', 'c_<c-r>"_')

-- Notes and wiki
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

-- LSP {{{
-- map("n", "K", function() vim.lsp.buf.hover() end)
map("n", "ga", function() vim.lsp.buf.code_action() end)
map("n", "gR", function() vim.lsp.buf.rename() end)
map("n", "gd", function() vim.lsp.buf.definition() end)
map("n", "gD", function() vim.lsp.buf.declaration() end)
 -- }}}

-- Telescope {{{
-- nm('<leader>O', '<cmd>Telescope oldfiles<CR>')                                   -- Show recent files
-- nm('<leader>o', '<cmd>Telescope git_files<CR>')                                  -- Search for a file in project
nm('<leader>p', '<cmd>FzfLua files<CR>')                                 -- Search for a file (ignoring git-ignore)
nm('<leader>s', '<cmd>FzfLua lsp_document_symbols<CR>')                                 -- Search for a file (ignoring git-ignore)
-- nm('<leader>i', '<cmd>Telescope jumplist<CR>')                                   -- Show jumplist (previous locations)
-- nm('<leader>b', '<cmd>Telescope git_branches<CR>')                               -- Show git branches
nm('<leader>ff', '<cmd>FzfLua live_grep_native<CR>')                                  -- Find a string in project
nm('<leader>fr', '<cmd>FzfLua resume<CR>')                                  -- Find a string in project
nm('<leader>fb', '<cmd>FzfLua buffers<CR>')                                  -- Find a string in project
nm('<leader>fj', '<cmd>FzfLua jumps<CR>')                                  -- Find a string in project
-- nm('<leader>b', '<cmd>Telescope buffers<CR>')                                    -- Show all buffers
-- nm('<leader>a', '<cmd>Telescope<CR>')                                            -- Show all commands
-- nm('<leader>t', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')              -- Search for dynamic symbols
-- }}}

-- ZenMode
nm('zz', '<cmd>ZenMode<CR>')

-- Trouble {{{
nm('<c-x>', '<cmd>Trouble quickfix toggle<CR>')                                         -- Show all problems in project (with help of LSP)
nm('gr', '<cmd>Trouble lsp_references focus=true win.position=right<CR>')                                       -- Show use of object in project
-- nm('<c-s>', '<cmd>Trouble symbols toggle focus=false<CR>')                                         -- Show all problems in project (with help of LSP)
-- }}}

-- Neo Tree {{{
nm('<leader>\\', '<cmd>NeoTreeFocusToggle<CR>')                                        -- Toggle file explorer
-- }}}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
