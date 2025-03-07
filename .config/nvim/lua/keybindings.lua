require "helpers/globals"
require "helpers/keyboard"

g.mapleader = ' '                                                                 -- Use Space, like key for alternative hotkeys

-- MINE
nm('<leader>e', '<cmd>e#<CR>' )
nm('<bs>', '<c-o>')
nm('<leader>v', '<cmd>vsplit<CR>' )
nm('<leader>`', 'i```<CR>```<esc>O<esc>p' )
nm('<leader>q', '<cmd>q<CR>' )
nm('j', 'gj' )
nm('k', 'gk' )
nm('<c-h>', '<c-w><c-h>' )
nm('<c-l>', '<c-w><c-l>' )
nm('<c-j>', '<c-w><c-j>' )
nm('<c-k>', '<c-w><c-k>' )
nm('<leader>a', '<cmd>AerialToggle!<CR>')
nm('<leader>#', '<cmd>Telescope aerial<CR>')
nm('vv', 'viw')
vm('p', 'P')
nm('<F5>', '<cmd>make<CR>')
-- nm('<F6>', '<cmd>make<CR>')
nm('<leader>gg', '<cmd>LazyGit<cr>')
nm(']e', '<cmd>cn<cr>')
nm('[e', '<cmd>cp<cr>')

im('p`', '`<esc>pa`')

nm('<leader>n', '<cmd>noh<cr>)')

-- Commenting
nm('<leader>/', '<Plug>(comment_toggle_linewise_current)')
vm('<leader>/', '<Plug>(comment_toggle_linewise_visual)')

-- Telekasten {{{
-- im('[[', '<cmd>Telekasten insert_link<CR>')
-- im('[#', '<cmd>Telekasten show_tags<CR>')
-- nm('[#', '<cmd>Telekasten show_tags<CR>')
-- nm('<leader>wb', '<cmd>Telekasten show_backlinks<CR>')
--- }}}

-- Obsidian.nvim --
nm('<leader>wp', '<cmd>ObsidianQuickSwitch<CR>')
nm('<leader>wf', '<cmd>ObsidianSearch<CR>')
nm('<leader>wt', '<cmd>ObsidianTags<CR>')
nm('<leader>wb', '<cmd>ObsidianBacklinks<CR>')
nm('<leader>x', '<cmd>lua require("obsidian").util.toggle_checkbox({" ", "x", "o"})<CR>')
nm('[j', '<cmd>ObsidianYesterday<CR>')
nm('<leader>j', '<cmd>ObsidianToday<CR>')
nm(']j', '<cmd>ObsidianTomorrow<CR>')

nm(']e', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nm('[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- quick links --
if os.getenv("NOTES_DIR") then
	nm('<leader>ww', '<cmd>e ' .. os.getenv("NOTES_DIR") .. '/wiki/readme.md<CR>')
	nm('<leader>wc', '<cmd>e ' .. os.getenv("NOTES_DIR") .. '/cr0ft_roguelike_wiki/index.md<CR>')
	nm('<leader>wq', '<cmd>e ' .. os.getenv("NOTES_DIR") .. '/quicknote.md<CR>')
	nm('<leader>wn', '<cmd>cd ' .. os.getenv("NOTES_DIR") .. '<CR><cmd>Telescope find_files<CR>')

	-- TODOs --
	nm('<leader>tt', '<cmd>e ' .. os.getenv("NOTES_DIR") .. '/todo/todo.md<CR>')
	nm('<leader>tp', '<cmd>TodoTelescope keywords=NOW,TODAY,SOON cwd=' .. os.getenv("NOTES_DIR") .. '/todo<CR>')
end

-- vim.keymap.set("n", "]t", function()
--   require("todo-comments").jump_next({keywords = { "TODO", "SOON", "TODAY", "NOW" }})
-- end, { desc = "Next todo comment" })
--
-- vim.keymap.set("n", "[t", function()
--   require("todo-comments").jump_prev({keywords = { "TODO", "SOON", "TODAY", "NOW" }})
-- end, { desc = "Prev todo comment" })

nm('<leader>dd', '<cmd>lua require("dapui").toggle()<CR>' )
nm('<leader>ds', '<cmd>lua require("dap").continue()<CR>' )

-- LSP {{{
nm('K', '<cmd>lua vim.lsp.buf.hover()<CR>' )                                      -- Hover object
nm('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')                                -- Code actions
nm('gR', '<cmd>lua vim.lsp.buf.rename()<CR>')                                     -- Rename an object
nm('gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')                                -- Go to declaration
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
nm('<leader>t', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')              -- Search for dynamic symbols
-- }}}

-- ZenMode
nm('zz', '<cmd>ZenMode<CR>')

-- nm('<leader>b', '<cmd>lua if vim.o.bg == "dark" then vim.o.bg = "light" else vim.o.bg = "dark" end<CR>')

-- Trouble {{{
nm('<c-x>', '<cmd>Trouble diagnostics toggle<CR>')                                         -- Show all problems in project (with help of LSP)
nm('gr', '<cmd>Trouble lsp_references focus=true win.position=right<CR>')                                       -- Show use of object in project
nm('<c-s>', '<cmd>Trouble symbols toggle focus=false<CR>')                                         -- Show all problems in project (with help of LSP)
-- }}}

-- Neo Tree {{{
nm('<leader>\\', '<cmd>NeoTreeFocusToggle<CR>')                                        -- Toggle file explorer
-- }}}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
