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
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require "extensions.mason"
    end
  },
  -- }}}

  -- Mason {{{
  {
    "neovim/nvim-lspconfig",
    config = function()
      require('lspconfig').zls.setup{}
    end
  },
  -- }}}

  -- Neo Tree {{{
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    lazy = true,
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
    lazy = true,
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
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require "extensions.cmp"
    end
  },
  -- }}}

  -- LSP Kind {{{
  {
    'onsails/lspkind-nvim',
    lazy = true,
    config = function()
      require('lspkind').init()
    end
  },
  -- }}}

  -- Git Signs{{{
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require('gitsigns').setup({
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'right_align',
          delay = 1000,
          ignore_whitespace = false,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)
          map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
    end
  },
  -- }}}

  -- Trouble {{{
  {
    "folke/trouble.nvim",
    lazy = true,
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    config = function()
      require("trouble").setup()
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  -- }}}

  -- TreeSitter {{{
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require "extensions.treesitter"
    end
  },
  -- }}}

  -- Theme {{{
  {
    "navarasu/onedark.nvim",
    lazy = false,
    config = function ()
      cmd("colorscheme onedark")
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
    config = function()
        require('Comment').setup({
          mappings = {
            basic=false,
            extra=false
          },
        })
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      fn["mkdp#util#install"]()
    end,
  },

  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require('aerial').setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
        end,
        default_direction = "prefer_left",
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
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
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        local zen_buf = vim.api.nvim_get_current_buf()

        local current_buf = vim.api.nvim_get_current_buf()

        if current_buf == zen_buf then
            return
        end

        vim.api.nvim_set_current_buf(zen_buf)

        vim.diagnostic.enable()
      end,
    }
  },

  "tpope/vim-fugitive",
  {
      "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
      -- optional for floating window border decoration
      dependencies = {
          "nvim-lua/plenary.nvim",
      },
  },
  {
    "AndrewRadev/switch.vim",
    ft = "markdown",
    init = function()
      vim.g.switch_mapping = "-"
      vim.g.switch_definitions = {}
      vim.b.switch_definitions = {}
      vim.g.switch_custom_definitions = {
        {"TODO", "DONE", "DOING", "ASAP", "NOTTODO"},
        {"TINY", "DONE"},
      }
    end,
  },
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
    "brenoprata10/nvim-highlight-colors",
    lazy = false,
    config = function()
      require('nvim-highlight-colors').setup{}
    end,
  },
  { "folke/twilight.nvim", opts = {context = 20},},
  { "typicode/bg.nvim", lazy = false },
}
