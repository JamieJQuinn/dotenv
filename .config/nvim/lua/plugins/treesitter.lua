return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { 
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
    -- "OXY2DEV/markview.nvim",
  },
  build = ":TSUpdate",
  -- lazy = false,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
  require'nvim-treesitter.configs'.setup {
    -- Needed parsers
    ensure_installed = {
      "markdown",
      "cpp",
      "fortran",
      "python",
      "zig",
      "lua",
      "jsonnet",
      "yaml",
    },

    -- Install all parsers synchronously
    sync_install = false,

    highlight = {
      enable = true,
      disable = {},
    },

    indent = {
      enable = { "markdown" },
      disable = {},
    },
  }
  end,
};
