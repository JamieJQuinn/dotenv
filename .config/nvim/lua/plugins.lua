--[[
  File: plugins.lua
  Description: This file needed for loading plugin list into lazy.nvim and loading plugins
  Info: Use <zo> and <zc> to open and close foldings
  See: https://github.com/folke/lazy.nvim
]]

require "helpers/globals"

return {
  -- Mason {{{
  {
    "williamboman/mason.nvim",
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
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      lspconfig.zls.setup{capabilities = capabilities}
      require'lspconfig'.lua_ls.setup {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              -- library = vim.api.nvim_get_runtime_file("", true)
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
      }
      lspconfig.bashls.setup{}
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
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
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
        "lua",
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

      textobjects = {
        move = {
          -- enable = true,
          enable = { "markdown", "markdown-inline" },
          set_jumps = true, -- whether to set jumps in the jumplist
          lookahead = true,
          goto_next_start = {
            -- ["]m"] = "@function.outer",
            -- ["]]"] = { query = "@class.outer", desc = "Next class start" },
            --
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
            -- ["]o"] = "@loop.inner",
            -- ["]o"] = { query = "@loop.outer" },
            -- ["]l"] = { query = "@markup.link.label", query_group = "highlights"},
            ["]l"] = { query = "@markup.link"},
            -- ["]h"] = { query = "@markup.heading.1" },
            ["]h"] = { query = "@markup.heading.*" },
            -- ["]h"] = { query = "@markup.heading.1" },
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            -- ["]f"] = { query = "@local.definition.function", query_group = "locals", desc = "Next scope" },
            -- ["]h"] = { query = "@markup.header.1", query_group = "highlights", desc = "Next header 1" },
            -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          -- goto_next_end = {
          --   ["]M"] = "@function.outer",
          --   ["]["] = "@class.outer",
          -- },
          goto_previous_start = {
            ["[h"] = { query = "@markup.heading.*" },
            -- ["[m"] = "@function.outer",
            -- ["[["] = "@class.outer",
          },
          -- goto_previous_end = {
          --   ["[M"] = "@function.outer",
          --   ["[]"] = "@class.outer",
          -- },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          -- goto_next = {
          --   ["]d"] = "@conditional.outer",
          -- },
          -- goto_previous = {
          --   ["[d"] = "@conditional.outer",
          -- }
        },
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

  -- {
  -- "serenevoid/kiwi.nvim",
  --   ft = "markdown",
  --   opts = {
  --       {
  --           name = "cr0ft",
  --           path = "~/notes/cr0ft_roguelike_wiki/"
  --       },
  --       {
  --           name = "notes",
  --           path = "~/notes"
  --       },
  --       {
  --           name = "wiki",
  --           path = "~/notes/wiki"
  --       }
  --   },
  --   keys = {
  --       { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index(\"wiki\")<cr>", desc = "Open Wiki index" },
  --       { "<leader>wc", ":lua require(\"kiwi\").open_wiki_index(\"cr0ft\")<cr>", desc = "Open index of personal wiki" },
  --       { "<cr>", ":lua require(\"kiwi\").todo.toggle()<cr>", desc = "Toggle Markdown Task" }
  --   },
  -- },

  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    -- ft = "markdown",
    -- lazy = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
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
        nvim_cmp = true,
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

      -- callbacks = {
      --   post_set_workspace = function(client, workspace)
      --     -- local root = require("obsidian").find_vault_root()
      --     vim.api.nvim_set_current_dir(workspace.path.filename)
      --   end,
      -- },

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
  -- {
  --   'numToStr/Comment.nvim',
  --   event = "BufEnter",
  --   opts = {
  --     mappings = {
  --       basic=false,
  --       extra=false
  --     },
  --   }
  -- },
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
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = "✗ ", color = "error" },
        HACK = { icon = "‼ ", color = "warning" },
        DEBUG = { icon = "! ", color = "debug" },
        PERF = { icon = " ", color = "perf" },

        WARN = { icon = " ", color = "warning" },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      merge_keywords = false,

      highlight = {
        multiline = false, -- enable multine todo comments
        before = "", -- "fg" or "bg" or empty
        keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
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
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        pattern = [[\b(KEYWORDS)]], -- ripgrep regex
      },
    }
  },
  {
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
