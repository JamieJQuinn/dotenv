return {
  -- The GitHub repository for the codecompanion.nvim plugin.
  "olimorris/codecompanion.nvim",
  version = "*", -- use latest release, remove to use latest commit

  -- Specifies other plugins that codecompanion.nvim needs to function correctly.
  dependencies = {
    -- plenary.nvim provides common utility functions that are used by many Neovim plugins.
    "nvim-lua/plenary.nvim",
  },

  keys = {
    {"<leader>cc", "<cmd>CodeCompanionChat toggle<cr>"},
    -- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    -- {
    --   "<leader>fp",
    --   function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
    --   desc = "Find Plugin File",
    -- },
  },

  -- The 'opts' table contains all the user-specific settings for the plugin.
  opts = {
    -- This 'strategies' table sets the DEFAULT AI PROVIDER and MODEL
    -- for different categories of actions within the plugin.
    strategies = {
      -- Configures the default model for running custom prompts.
      cmd = {
        adapter = "ollama",
        model = "hf.co/TheBloke/CapybaraHermes-2.5-Mistral-7B-GGUF:Q4_K_M",
      },

      -- Configures the model for the interactive chat window (:CompanionChat).
      chat = {
        adapter = "ollama",
        model = "hf.co/QuantFactory/Qwen2.5-Coder-7B-Instruct-GGUF:Q5_K_M",
      },

      -- Configures the model for any action that modifies code directly in your buffer
      -- using the 'inline' strategy.
      inline = {
        adapter = "ollama",
        model = "hf.co/TheBloke/CapybaraHermes-2.5-Mistral-7B-GGUF:Q4_K_M",
      },
    },
  },
}
