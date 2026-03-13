return {
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
};
