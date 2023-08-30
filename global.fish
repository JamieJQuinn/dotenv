# Nice git aliases
abbr -a gc git checkout
abbr -a gs git status
abbr -a gd git diff
abbr -a gb git branch
abbr -a gl git log

# Vim
set -x EDITOR nvim
alias vim nvim

## Todos
set -x TODO_DIR ~/todo
alias extract_todos "grep -P '\- \[.?\]'"
alias todo-today "grep '(A)' $TODO_DIR/todo.txt"

# Notes
set -x NOTES_DIR ~/notes

# Configs
alias vimcfg "cd ~/.config/nvim; nvim +'Telescope find_files' ."
alias fishcfg "cd ~/.config/fish; nvim +'Telescope find_files' ."
alias kittycfg "cd ~/.config/kitty; nvim kitty.conf"

# Useful aliases
alias timesheet "vim ~/timesheet.md"

alias a 'xdg-open'
alias connect_to_home_vnc "ssh -C -L 5901:home:5901 -N home-pi -v &; sleep 2; vncviewer localhost:1"

# Add scripts
set PATH ~/scripts $PATH

# Greeting
function fish_greeting
  bash ~/scripts/motd.sh
end
