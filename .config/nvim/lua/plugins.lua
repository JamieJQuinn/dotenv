--[[
  File: plugins.lua
  Description: This file needed for loading plugin list into lazy.nvim and loading plugins
  Info: Use <zo> and <zc> to open and close foldings
  See: https://github.com/folke/lazy.nvim
]]

require "helpers/globals"
-- local map = vim.keymap.set

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    build = ":MasonUpdate",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    config = function()
      require("fzf-lua").setup({
        files = {
          actions = { ["ctrl-q"] = { fn = require"fzf-lua".actions.file_sel_to_qf, prefix = "select-all" } },
          hidden = false,
          rg_opts = [[--color=never --files --sortr=modified -g "!.git" -g "!.jj"]],
          fd_opts = [[--color=never --type f --type l --exclude .git --exclude .jj -X ls -t]],
        },
        grep = {
          actions = { ["ctrl-q"] = { fn = require"fzf-lua".actions.file_sel_to_qf, prefix = "select-all" } }
        },
      })
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
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority=1000,
    config = function ()
      require('onedark').setup {style = 'dark'}
      require('onedark').load()
    end
  },
  -- { -- just a fun colourscheme
  --   'kungfusheep/mfd.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd('colorscheme mfd-lumon')
  --   end,
  -- },
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
    dependencies = {
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
    event = "BufEnter",
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
    event = "BufEnter",
    main = "ibl",
    opts = {},
  },
  {
    -- Highlight colours like #AABBCC
    "brenoprata10/nvim-highlight-colors",
    event = "BufEnter",
    opts = {},
  },
  {
    -- Change terminal background to match vim
    "typicode/bg.nvim",
    event = "BufEnter",
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
    event = "BufEnter",
  },
  {
    "m4xshen/hardtime.nvim", -- GAINS
    lazy = false,
  },
  {
    "echasnovski/mini.surround",
    event = "InsertEnter",
    opts = {},
  },
  {
    'https://codeberg.org/ziglang/zig.vim',
    ft = "zig",
    init = function()
      -- vim.g.zig_fmt_parse_errors = 1
      -- vim.g.zig_fmt_autosave = 1
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { "*.zig", "*.zon" },
        callback = function(ev)
          vim.lsp.buf.format()
        end
      })
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   lazy = false,
  --   branch = "main",
  --   init = function()
  --     -- Disable entire built-in ftplugin mappings to avoid conflicts.
  --     -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
  --     vim.g.no_plugin_maps = true
  --
  --     vim.keymap.set("n", "<leader>L", function()
  --       require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
  --     end)
  --     vim.keymap.set("n", "<leader>H", function()
  --       require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
  --     end)
  --   end,
  -- },
  -- {
  --   "arborist-ts/arborist.nvim",
  --   init = function()
  --     require("arborist").setup()
  --   end
  -- },
{
    'ggml-org/llama.vim',
    init = function()
        vim.g.llama_config = {
            auto_fim = false,

		    keymap_fim_trigger =      "<C-f>",
		    keymap_fim_accept_full =  "<Tab>",
		    keymap_fim_accept_line =  "<S-Tab>",
		    keymap_fim_accept_word =  "",
		    keymap_fim_next =         "<C-J>",
		    keymap_fim_prev =         "<C-K>",
		    keymap_inst_trigger =     "",
		    keymap_inst_rerun =       "",
		    keymap_inst_continue =    "",
		    keymap_inst_accept =      "<Tab>",
		    keymap_inst_cancel =      "<Esc>",
		    keymap_debug_toggle =     "",
        }
    end,
},
}
