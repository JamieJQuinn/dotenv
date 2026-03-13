local function getWords()
  return tostring(vim.fn.wordcount().words)
end

local function is_markdown()
    return vim.bo.filetype == "markdown" or vim.bo.filetype == "asciidoc"
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {{'nvim-tree/nvim-web-devicons'}},
  opts = {
    options = {
      component_separators = '',
      section_separators = { left = '', right = '' },
      theme = 'onedark',
    },
    sections = {
      lualine_a = { { 'mode', separator = { left = '' }}},
      lualine_z = { { 'location', separator = { right = '' }}, {getWords, cond = is_markdown, separator = { right = '' }}},
    },
  },
};
