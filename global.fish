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
alias extract_todos "grep -P '\- \[.?\]'"
alias todo "cd ~/notes/todo; vim todo.txt"
alias todo-today "grep '(A)' ~/notes/todo/todo.txt"
alias journal "vim ~/notes/journal/(date +\"%Y-%m\").md"

# Notes
set -x NOTES_DIR ~/notes
alias notes "cd ~/notes; vim -c 'Files'"

# Useful aliases
alias timesheet "vim ~/timesheet.md"
alias wiki "vim -c VimwikiIndex"
alias wiki_new "vim -c ZettelNewBibtex"
alias a 'xdg-open'
alias connect_to_home_vnc "ssh -C -L 5901:home:5901 -N home-pi -v &; sleep 2; vncviewer localhost:1"

# Add scripts
set PATH ~/scripts $PATH

# Greeting
function fish_greeting
  bash ~/scripts/motd.sh
end
