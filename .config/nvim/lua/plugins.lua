--[[
  File: plugins.lua
  Description: This file needed for loading plugin list into lazy.nvim and loading plugins
  Info: Use <zo> and <zc> to open and close foldings
  See: https://github.com/folke/lazy.nvim
]]

require "helpers/globals"
local map = vim.keymap.set

return {
  -- Mason {{{
  {
    "williamboman/mason.nvim",
    lazy = false,
    build = ":MasonUpdate",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },
  -- }}}

  -- Mason {{{
  -- }}}

  -- Neo Tree {{{
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    cmd = "NeoTreeFocusToggle",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      require "extensions.neotree"
    end
  },
  -- }}}
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {}
    ---@diagnostic enable: missing-fields
  },
  -- CMP {{{
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind-nvim',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require "extensions.cmp"
    end
  },
  {
    'L3MON4D3/LuaSnip',
    event = "InsertEnter",
    config = function()
      -- Add snippets from Friendly Snippets
      require("luasnip/loaders/from_vscode").lazy_load()
      require("luasnip/loaders/from_snipmate").lazy_load()
    end
  },
  -- }}}
  -- Alternative CMP
  -- {
  --   'Saghen/blink.cmp',
  --   event = "InsertEnter",
  --   version = '*',
  --   dependencies = 'rafamadriz/friendly-snippets',
  --   opts = {
  --       -- 'default' for mappings similar to built-in completion
  --       -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  --       -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  --       -- See the full "keymap" documentation for information on defining your own keymap.
  --       keymap = { 
  --         preset = 'default',
  --         ['<C-l>'] = { 'select_and_accept' },
  --       },
  --
  --       appearance = {
  --         -- Sets the fallback highlight groups to nvim-cmp's highlight groups
  --         -- Useful for when your theme doesn't support blink.cmp
  --         -- Will be removed in a future release
  --         -- use_nvim_cmp_as_default = true,
  --         -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --         -- Adjusts spacing to ensure icons are aligned
  --         nerd_font_variant = 'mono'
  --       },
  --
  --       completion = {
  --         list = {
  --           selection = { preselect = false, auto_insert = true },
  --         },
  --         ghost_text = {
  --           enabled = true,
  --         },
  --       },
  --
  --       signature = { enabled = true },
  --
  --       -- Default list of enabled providers defined so that you can extend it
  --       -- elsewhere in your config, without redefining it, due to `opts_extend`
  --       sources = {
  --         default = { 'lsp', 'path', 'snippets', 'buffer' },
  --         per_filetype = { 
  --           markdown = { 'snippets' },
  --         },
  --       },
  --     },
  --     opts_extend = { "sources.default" }
  -- },

  -- Git Signs{{{
  {
    'lewis6991/gitsigns.nvim',
    event = "BufEnter",
    config = function()
      require "extensions.gitsigns"
    end
  },
  -- }}}

  -- Trouble {{{
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  -- }}}
  -- Theme {{{
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority=1000,
    config = function ()
      require('onedark').setup {style = 'dark'}
      require('onedark').load()
    end
  },
  -- }}}
  "bullets-vim/bullets.vim",
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {{'nvim-tree/nvim-web-devicons'}},
    config = function()
      require "extensions.lualine"
    end,
  },
  {
    'numToStr/Comment.nvim',
    event = "BufEnter",
    opts = {
      mappings = {
        basic=false,
        extra=false
      },
    }
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_preview_options = {
        maid = {
          flowchart = {
            defaultRenderer = "elk"
          },
          securityLevel = "loose",
        },
        disable_sync_scroll = 1,
      }
    end,
    ft = { "markdown" },
  },
  {
    "stevearc/aerial.nvim",
    -- cmd = "AerialToggle",
    event = "BufEnter", -- dae this to get immediate access to { and }(see below)
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    opts = {
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
      end,
      default_direction = "right",
    }
  },
  {
    "tpope/vim-fugitive",
    event = "InsertEnter",
  },
  {
    "AndrewRadev/switch.vim",
    ft = "markdown",
    init = function()
      vim.g.switch_mapping = "-"
      vim.g.switch_definitions = {}
      vim.b.switch_definitions = {}
      vim.g.switch_custom_definitions = {
        {"TODO", "PROG", "DONE", "DONT", "MOVED"},
      }
    end,
  },
  {
    -- Highlight indentation
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    main = "ibl",
    opts = {},
  },
  {
    -- Highlight colours like #AABBCC
    "brenoprata10/nvim-highlight-colors",
    lazy = false,
    opts = {},
  },
  {
    -- Change terminal background to match vim
    "typicode/bg.nvim",
    lazy = false
  },
  {
    "preservim/vim-pencil",
    ft = {"markdown", "text"},
    cmd = "Pencil",
    init = function()
      vim.g["pencil#wrapModeDefault"] = "soft"
      vim.g["pencil#autoformat"] = 0
      vim.g["pencil#conceallevel"] = 0
    end,
  },
  {
    "godlygeek/tabular",
    event = "InsertEnter",
  },
  "m4xshen/hardtime.nvim", -- GAINS
  {
    "echasnovski/mini.surround",
    event = "InsertEnter",
    opts = {},
  },
}
