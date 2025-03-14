--[[
  File: plugins.lua
  Description: This file needed for loading plugin list into lazy.nvim and loading plugins
  Info: Use <zo> and <zc> to open and close foldings
  See: https://github.com/folke/lazy.nvim
]]

require "helpers/globals"

return {
  -- Mason {{{
  -- {
  --   "williamboman/mason.nvim",
  --   build = ":MasonUpdate",
  --   dependencies = {
  --     "williamboman/mason-lspconfig.nvim",
  --     "neovim/nvim-lspconfig",
  --   },
  --   config = function()
  --     local mason = require("mason")
  --     local mason_lspconfig = require("mason-lspconfig")
  --     local lspconfig = require("lspconfig")
  --
  --     mason.setup()
  --     mason_lspconfig.setup {
  --       ensure_installed = {}
  --     }
  --
  --     -- Setup every needed language server in lspconfig
  --     mason_lspconfig.setup_handlers {
  --       function (server_name)
  --         lspconfig[server_name].setup {}
  --       end,
  --     }
  --   end
  -- },
  -- }}}

  -- Mason {{{
  {
    "neovim/nvim-lspconfig",
    event = "InsertEnter",
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig['zls'].setup{capabilities = capabilities}
    end
  },
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

  -- Telescope {{{
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ahmedkhalf/project.nvim",
    },
    config = function()
      require "extensions.telescope"
    end
  },
  -- }}}

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

      local ls = require("luasnip")
      local t = ls.text_node
      local i = ls.insert_node
      local s = ls.snippet
      local rep = require("luasnip.extras").rep

      ls.add_snippets(nil, {
        zig = {
          s("hello_world", {t({"const std = @import(\"std\");", "", "pub fn main() void {", "    "}), i(1), t({"", "}"})}),
          s("init", {t("var "), i(1), t" = ", i(2), t".init(", i(3), t{");", ""}, rep(1), t".deinit();"}),
        },
      })
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
    lazy = true,
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  -- }}}

  -- TreeSitter {{{
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
        enable = { "markdown" },
        disable = {},
      }
    }
    end
  },
  -- }}}

  -- Theme {{{
  {
    "navarasu/onedark.nvim",
    lazy = false,
    config = function ()
      require('onedark').setup {style = 'dark'}
      require('onedark').load()
    end
  },
  -- }}}

  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/notes",
        },
      },

      disable_frontmatter = true,
      ui = {
        enable = false,
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["o"] = { char = "", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
      },

      completion = {
        nvim_cmp = false,
        min_chars = 1,
        -- prepend_note_id = false,
        -- use_path_only = true,
      },

      mappings = {
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        }
      },

      daily_notes = {
        folder = "journal",
        date_format = "%Y-%m-%d",
      },

      note_id_func = function(title)
        return title:gsub(" ", "_"):gsub("[^A-Za-z0-9_]", ""):lower()
      end,

      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        -- vim.fn.jobstart({"open", url})  -- Mac OS
        vim.fn.jobstart({"xdg-open", url})  -- linux
      end,
    },
  },

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
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   ft = "markdown",
  --   build = function()
  --     fn["mkdp#util#install"]()
  --   end,
  -- },
  {
    "stevearc/aerial.nvim",
    event = "BufEnter",
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
      default_direction = "prefer_right",
    }
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 80, -- width of the Zen window
        height = 0.9, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
        },
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = true }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = true,
          font = "+1", -- font size increment
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
        vim.diagnostic.disable()
        -- require('onedark').setup {style = 'light'}
        -- require('onedark').load()
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        -- require('onedark').setup {style = 'dark'}
        -- require('onedark').load()
        vim.diagnostic.enable()
      end,
    }
  },
  {
    "tpope/vim-fugitive",
    event = "InsertEnter",
  },
  -- {
  --   "AndrewRadev/switch.vim",
  --   ft = "markdown",
  --   init = function()
  --     vim.g.switch_mapping = "-"
  --     vim.g.switch_definitions = {}
  --     vim.b.switch_definitions = {}
  --     vim.g.switch_custom_definitions = {
  --       {"TODO", "DONE", "DOING", "ASAP", "NOTTODO"},
  --       {"TINY", "DONE"},
  --     }
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      keywords = {
        TODO = { icon = "✗ ", color = "yellow" },
        DONE = { icon = "✔ ", color = "green" },

        ASAP = { icon = "‼ ", color = "red" },
        DOING = { icon = "✗ ", color = "blue" },
        WAITING = { icon = " ", color = "grey" },
        NOTTODO = { icon = "✔ ", color = "grey" },

        -- NOW = { icon = "‼ ", color = "now" },
        -- TODAY = { icon = "! ", color = "today" },
        -- SOON = { icon = " ", color = "soon" },
        -- TINY = { icon = "ε ", color = "tiny" },
      },
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
        keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",
        before = "",
        comments_only = false, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      search = {
        pattern = [[\b(KEYWORDS)]], -- ripgrep regex
      },
      colors = {
        -- todo = { "DiagnosticInfo" },
        grey = { "Comment" },
        red = { "DiagnosticError" },
        orange = { "Character" },
        yellow = { "NvimNumberPrefix" },
        green = { "String" },
        blue = { "Title" },
      },
    }
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
  -- { 
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  --   config = function()
  --     require("dapui").setup()
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --   event = "InsertEnter",
  --   config = function()
  --     require "extensions.dap"
  --   end
  -- },
}
