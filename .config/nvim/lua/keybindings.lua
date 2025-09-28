require "helpers/globals"
require "helpers/keyboard"

local map = vim.keymap.set

g.mapleader = ' '                                                                 -- Use Space, like key for alternative hotkeys

-- MINE
nm('<leader>e', '<cmd>e#<CR>' )
nm('<bs>', '<c-o>')
-- nm('<tab>', '<cmd>/[[<cr>')
nm('<leader>v', '<cmd>vsplit<CR>' )
nm('<leader>`', 'i```<CR>```<esc>O<esc>p' )
vim.keymap.set('v', '<leader>;', 'c:::<CR>:::<esc>O<esc>pi<CR><esc>')
vim.keymap.set('v', '<leader>;i', 'c::: info<CR>:::<esc>O<esc>pi<CR><esc>')
vim.keymap.set('v', '<leader>;c', 'c::: callout<CR>:::<esc>O<esc>pi<CR><esc>')
vim.keymap.set('v', '<leader>;C', 'c::: challenge<CR>:::<esc>O<esc>pi<CR><esc>')
vim.keymap.set('v', '<leader>;s', 'c:::: solution<CR>::::<esc>O<esc>pi<CR><esc>')
vim.keymap.set('v', '<leader>;k', 'c::: key<CR>:::<esc>O<esc>pi<CR><esc>')
nm('<leader>q', '<cmd>q<CR>' )
nm('j', 'gj' )
nm('k', 'gk' )
nm('<c-h>', '<c-w><c-h>' )
nm('<c-l>', '<c-w><c-l>' )
nm('<c-j>', '<c-w><c-j>' )
nm('<c-k>', '<c-w><c-k>' )
nm('<leader>a', '<cmd>AerialToggle!<CR>')
-- nm('<leader>#', '<cmd>Telescope aerial<CR>')
nm('vv', 'viw')
vm('p', 'P')
nm('<F5>', '<cmd>make<CR>')
-- nm('<F6>', '<cmd>make<CR>')
-- nm('<leader>gg', '<cmd>LazyGit<cr>')
nm(']e', '<cmd>cn<cr>')
nm('[e', '<cmd>cp<cr>')
nm('<leader>gc', '<cmd>Git commit<cr>i')

-- im('p`', '`<esc>pa`')

-- TODOs in code
map("n", "<leader>t", function()
  vim.cmd("Trouble todo filter = {tag = {TODO}} filter.buf=0")
end)
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next({keywords = { "TODO", "HACK" }})
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev({keywords = { "TODO", "HACK" }})
end, { desc = "Prev todo comment" })


nm('<leader>n', '<cmd>noh<cr>')

-- Commenting
nm('<leader>/', '<Plug>(comment_toggle_linewise_current)')
vm('<leader>/', '<Plug>(comment_toggle_linewise_visual)')

-- map("v", "<leader>/", "gc", { desc = "sargas/ux: toggle comment", remap = true })
-- map("n", "<leader>/", "gcc", { desc = "sargas/ux: toggle comment", remap = true })

-- local query=vim.treesitter.query.parse('markdown_inline','[[ (link_text) ]]')
-- vim.keymap.set('n','<TAB>',function ()
--     vim.cmd("/[[.\\{-}\\]\\]")
--     vim.cmd("noh")
--     -- local root=vim.treesitter.get_parser():parse()[1]:root()
--     -- local _,node,_=query:iter_captures(root,0,vim.fn.line'.',-1)()
--     -- if not node then return end
--     -- require'nvim-treesitter.ts_utils'.goto_node(node)
-- end)

-- Telekasten {{{
-- im('[[', '<cmd>Telekasten insert_link<CR>')
-- im('[#', '<cmd>Telekasten show_tags<CR>')
-- nm('[#', '<cmd>Telekasten show_tags<CR>')
-- nm('<leader>wb', '<cmd>Telekasten show_backlinks<CR>')
--- }}}

map("n", "]e", function() vim.diagnostic.goto_next() end)
map("n", "[e", function() vim.diagnostic.goto_prev() end)

-- Markdown

vim.keymap.set('v', '<leader>b', 'c**<c-r>"**')
vim.keymap.set('v', '<leader>i', 'c_<c-r>"_')

-- WIKI --
if os.getenv("NOTES_DIR") then
  -- Obsidian.nvim --
  nm('<leader>wp', '<cmd>ObsidianQuickSwitch<CR>')
  nm('<leader>wf', '<cmd>ObsidianSearch<CR>')
  nm('<leader>w#', '<cmd>ObsidianTags<CR>')
  nm('<leader>wb', '<cmd>ObsidianBacklinks<CR>')
  -- map("n", "<leader>x", function() require("obsidian").util.toggle_checkbox({" ", "x", "o"}) end)
  map("n", "<leader>wj", function()
    vim.api.nvim_set_current_dir(os.getenv("NOTES_DIR"))
    vim.cmd("e ./journal/2025.md")
  end)

  map("n", "<leader>ww", function()
    vim.api.nvim_set_current_dir(os.getenv("NOTES_DIR"))
    vim.cmd("e ./wiki/readme.md")
  end)
  map("n", "<leader>wq", function()
    vim.api.nvim_set_current_dir(os.getenv("NOTES_DIR"))
    vim.cmd("e ./quicknote.md")
  end)
  map("n", "<leader>wn", function()
    vim.api.nvim_set_current_dir(os.getenv("NOTES_DIR"))
    vim.cmd("Telescope find_files")
  end)
  map("n", "<leader>wt", function()
    vim.api.nvim_set_current_dir(os.getenv("NOTES_DIR"))
    vim.cmd("e todo/todo.md")
  end)

  map("n", "<leader>wc", function()
    vim.api.nvim_set_current_dir(os.getenv("NOTES_DIR") .. "/cr0ft_roguelike_wiki")
    vim.cmd("e ./index.md")
  end)
end

-- map("n", "<leader>dd", function() require("dapui").toggle() end)
-- map("n", "<leader>ds", function() require("dap").continue() end)

map("i", "<C-BS>", "<C-W>")

-- LSP {{{
-- map("n", "K", function() vim.lsp.buf.hover() end)
map("n", "ga", function() vim.lsp.buf.code_action() end)
map("n", "gR", function() vim.lsp.buf.rename() end)
map("n", "gD", function() vim.lsp.buf.declaration() end)
map("n", "<leader>#", function() vim.cmd("Telescope aerial") end)
 -- }}}

-- Telescope {{{
nm('gd', '<cmd>Telescope lsp_definitions<CR>')                            -- Goto declaration
nm('<leader>O', '<cmd>Telescope oldfiles<CR>')                                   -- Show recent files
nm('<leader>o', '<cmd>Telescope git_files<CR>')                                  -- Search for a file in project
nm('<leader>p', '<cmd>Telescope find_files<CR>')                                 -- Search for a file (ignoring git-ignore)
nm('<leader>i', '<cmd>Telescope jumplist<CR>')                                   -- Show jumplist (previous locations)
-- nm('<leader>b', '<cmd>Telescope git_branches<CR>')                               -- Show git branches
nm('<leader>f', '<cmd>Telescope live_grep<CR>')                                  -- Find a string in project
nm('<leader>b', '<cmd>Telescope buffers<CR>')                                    -- Show all buffers
-- nm('<leader>a', '<cmd>Telescope<CR>')                                            -- Show all commands
-- nm('<leader>t', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')              -- Search for dynamic symbols
-- }}}

-- ZenMode
nm('zz', '<cmd>ZenMode<CR>')

-- nm('<leader>b', '<cmd>lua if vim.o.bg == "dark" then vim.o.bg = "light" else vim.o.bg = "dark" end<CR>')

-- Trouble {{{
nm('<c-x>', '<cmd>Trouble quickfix toggle<CR>')                                         -- Show all problems in project (with help of LSP)
nm('gr', '<cmd>Trouble lsp_references focus=true win.position=right<CR>')                                       -- Show use of object in project
nm('<c-s>', '<cmd>Trouble symbols toggle focus=false<CR>')                                         -- Show all problems in project (with help of LSP)
-- }}}

-- Neo Tree {{{
nm('<leader>\\', '<cmd>NeoTreeFocusToggle<CR>')                                        -- Toggle file explorer
-- }}}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
