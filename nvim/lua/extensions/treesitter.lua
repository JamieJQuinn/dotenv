--[[
  File: treesitter.lua
  Description: Configuration of tree-sitter
  See: https://github.com/tree-sitter/tree-sitter
]]
require'nvim-treesitter.configs'.setup {

  -- Needed parsers
  ensure_installed = {
    "lua",
    "javascript",
    "python",
    "bibtex",
    "bash",
    "c",
    "cpp",
    "cuda",
    "diff",
    "fortran",
    "json",
    "julia",
    "make",
    "markdown_inline", -- experimental 2023-07-08
    "terraform",
    "todotxt",
    "toml",
    "wgsl"
  },

  -- Install all parsers synchronously
  sync_install = false,

  -- Подсветка
  highlight = {
    -- Enabling highlight for all files
    enable = true,
    disable = {},
  },

  indent = {
    -- Disabling indentation for all files
    enable = false,
    disable = {},
  }
}
