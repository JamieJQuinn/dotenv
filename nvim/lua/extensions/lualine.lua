
local function getWords()
  return tostring(vim.fn.wordcount().words)
end

require('lualine').setup {
  options = {
    component_separators = { left = '\\', right = '/'},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_z = {'location', getWords}
  },
}
