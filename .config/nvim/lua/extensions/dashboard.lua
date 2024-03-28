require('dashboard').setup {
  theme = 'hyper',
  shortcut_type = 'number',
  config = {
    week_header = {
     enable = true,
    },
    shortcut = {
      { desc = '󰊳 Update', group = 'Tag', action = 'Lazy update', key = 'u' },
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Number',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        icon = '󰖬 ',
        desc = 'Wiki',
        group = 'DiagnosticHint',
        action = 'cd $NOTES_DIR/wiki | WikiIndex',
        key = 'w',
      },
      {
        icon = ' ',
        desc = 'Notes',
        group = 'Constant',
        action = 'cd $NOTES_DIR | Telescope find_files',
        key = 'n',
      },
      {
        icon = ' ',
        desc = 'ToDo',
        group = 'Todo',
        action = 'cd $TODO_DIR | e todo.txt',
        key = 't',
      },
    },
  },
}
