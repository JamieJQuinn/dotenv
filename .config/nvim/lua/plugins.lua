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
  {
    "neovim/nvim-lspconfig",
    lazy=false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.enable('lua_ls')
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end,
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
          }
        },
        capabilities = capabilities
      })
      vim.lsp.enable('zls')
      vim.lsp.enable('bashls')
      vim.lsp.enable('clangd')
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

  -- TreeSitter {{{
  {
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
  {
    "obsidian-nvim/obsidian.nvim",
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
  },
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
      on_open = function()
        vim.diagnostic.enable(false)
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
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
      sign_priority = 8,
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },

        TODO = { icon = "✗ ", color = "error"},
        PROG = { icon = " ", color = "warning" },
        DONE = { icon = "✓ ", color = "#10B981" },
        DONT = { icon = "~ ", color = "comment" },
        MOVED = { icon = "> ", color = "comment" },

        HACK = { icon = "‼ ", color = "warning" },
        DEBUG = { icon = "! ", color = "debug" },
        PERF = { icon = " ", color = "info" },
        GIRLY = { icon = "ℊ ", color = "hint" },

        -- WARN = { icon = " ", color = "warning" },
        -- NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        -- TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      merge_keywords = false,

      highlight = {
        multiline = false, -- enable multine todo comments
        before = "", -- "fg" or "bg" or empty
        keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = false, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "SpellBad", "ErrorMsg", "#DC2626" },
        warning = { "SpellCap", "WarningMsg", "#FBBF24" },
        debug = { "SpellCap", "WarningMsg", "#FBBF24" },
        perf = { "SpellRare", "#7C3AED" },

        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        comment = { "SpecialComment", "#3f3f3f" },
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        pattern = [[\b(KEYWORDS)]], -- ripgrep regex
      },
    }
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
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
    },
  },
}
