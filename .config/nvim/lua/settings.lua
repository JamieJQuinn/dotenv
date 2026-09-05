require "helpers/globals"

-- Set associating between turned on plugins and filetype
cmd[[filetype plugin on]]

-- Disable comments on pressing Enter
cmd[[autocmd FileType * setlocal formatoptions-=cro]] -- Use autocommand to override all other settings

-- Zig autofmt
cmd[[autocmd BufWritePost *.zig silent! <cmd>!zig fmt %<CR>]]
g["zig_build_makeprg_params"] = "--error-style minimal"
-- g["zig_build_makeprg_params"] = "-freference-trace=8"

-- opt.number = true

-- Swap (recovery)
opt.directory = "."                -- Set swap file location

-- Tabs
opt.expandtab = true                -- Use spaces by default
opt.shiftwidth = 2                  -- Set amount of space characters, when we press "<" or ">"
opt.tabstop = 2                     -- 1 tab equal 2 spaces
opt.smartindent = true              -- Turn on smart indentation. See in the docs for more info

-- Clipboard
vim.g.clipboard = 'xclip'
opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.fixeol = false -- Turn off appending new line in the end of a file

-- Folding
vim.opt.foldenable = false
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldminlines = 10
-- vim.opt.foldcolumn = "0"
-- vim.opt.foldtext = ""
-- vim.opt.foldlevel = 2
-- vim.opt.foldlevelstart = 99
-- opt.foldnestmax = 1
opt.conceallevel = 0

-- Search
opt.ignorecase = true               -- Ignore case if all characters in lower case
opt.joinspaces = false              -- Join multiple spaces in search
opt.smartcase = true                -- When there is a one capital letter search for exact match
opt.showmatch = true                -- Highlight search instances

-- Window
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new vertical splits to right

-- Wild Menu
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- Default Plugins
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
