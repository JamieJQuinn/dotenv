
local function getWords()
  return tostring(vim.fn.wordcount().words)
end

require('lualine').setup {
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_z = {
      {'location', getWords, separator = { right = '' }, left_padding = 2},
    },
  },
}
