--[[
  File: cmp.lua
  Description: CMP plugin configuration (with lspconfig)
  See: https://github.com/hrsh7th/nvim-cmp
]]

local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup{
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body) -- Luasnip expand
    end,
  },

  -- Mappings for cmp
  mapping = {

    -- Autocompletion menu
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i' }),
    -- ['<CR>'] = cmp.config.disable,                      -- Turn off autocomplete on <CR>
    ['<C-l>'] = cmp.mapping.confirm({ select = true }), -- Turn on autocomplete on <C-y>

    -- Use <C-e> to abort autocomplete
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(), -- Abort completion
      c = cmp.mapping.close(), -- Close completion window
    }),

    -- Use <C-p> and <C-n> to navigate through completion variants
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable() then
        luasnip.jump(1)
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },                -- LSP
    { name = 'nvim_lsp_signature_help' }, -- LSP for parameters in functions
    { name = 'nvim_lua' },                -- Lua Neovim API
    { name = 'luasnip' },                 -- Luasnip
    { name = 'buffer' },                  -- Buffers
    { name = 'path' },                    -- Paths
    -- { name = "emoji" },                   -- Emoji
  }, {
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- Show only symbol annotations
      maxwidth = 50,   -- Prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    })
  }
}

-- Add snippets from Friendly Snippets
require("luasnip/loaders/from_vscode").lazy_load()

local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node
local s = ls.snippet

ls.add_snippets(nil, {
  zig = {s("hello_world", {t({"const std = @import(\"std\");", "", "pub fn main() void {", "    "}), i(1), t({"", "}"})})}
})
