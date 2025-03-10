--[[
  File: settings.lua
  Description: Base settings for neovim
  Info: Use <zo> and <zc> to open and close foldings
]]

require "helpers/globals"

-- Set associating between turned on plugins and filetype
cmd[[filetype plugin on]]

-- Disable comments on pressing Enter
cmd[[autocmd FileType * setlocal formatoptions-=cro]]
cmd[[autocmd FileType markdown set spell]]
cmd[[autocmd FileType text Pencil]]
cmd[[autocmd FileType markdown Pencil]]
cmd[[autocmd FileType zig map <F6> <cmd>!zig build run<CR>]]
cmd[[autocmd FileType zig map <F7> <cmd>!zig fmt %<CR>]]
-- cmd[[autocmd FileType markdown set conceallevel=1]]

-- Zig autofmt
g["zig_fmt_autosave"] = false

-- Tabs {{{
opt.expandtab = true                -- Use spaces by default
opt.shiftwidth = 2                  -- Set amount of space characters, when we press "<" or ">"
opt.tabstop = 2                     -- 1 tab equal 2 spaces
opt.smartindent = true              -- Turn on smart indentation. See in the docs for more info
-- }}}

-- Clipboard {{{
opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.fixeol = false -- Turn off appending new line in the end of a file
-- }}}

-- Folding {{{
opt.foldenable = false
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldminlines = 4
opt.foldlevel = 2
-- opt.foldnestmax = 1
cmd[[autocmd FileType markdown set foldenable]]
cmd[[autocmd FileType markdown set foldlevel=1]]
cmd[[autocmd FileType markdown set foldnestmax=2]]
cmd[[autocmd FileType zig set foldlevel=3]]
cmd[[autocmd FileType zig set foldnestmax=4]]
-- }}}

opt.conceallevel = 0

-- Search {{{
opt.ignorecase = true               -- Ignore case if all characters in lower case
opt.joinspaces = false              -- Join multiple spaces in search
opt.smartcase = true                -- When there is a one capital letter search for exact match
opt.showmatch = true                -- Highlight search instances
-- }}}

-- Window {{{
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new vertical splits to right
-- }}}

-- Wild Menu {{{
opt.wildmenu = true
opt.wildmode = "longest:full,full"
-- }}}

-- Default Plugins {{{
local disabled_built_ins = {
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end
-- }}}

-- vim: tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=1
