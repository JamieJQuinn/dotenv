# Nice git aliases
abbr -a gc git commit
abbr -a gs git status
abbr -a gd git diff
abbr -a gdh git diff HEAD~1
abbr -a gb git branch
abbr -a gl git log
abbr -a ga git add

abbr -a cmB cmake -B build
abbr -a cmb cmake --build build
abbr -a cmt ctest --test-dir build/tests/ --rerun-failed --output-on-failure

# Vim
set -x EDITOR nvim
alias vim nvim

## Todos
set -x TODO_DIR ~/notes/todo

# Notes
set -x NOTES_DIR ~/notes

# Configs
alias vimcfg "cd ~/.config/nvim; nvim +'Telescope find_files' ."
alias fishcfg "cd ~/.config/fish; nvim +'Telescope find_files' ."
alias kittycfg "cd ~/.config/kitty; nvim kitty.conf"

function cheatsh --description "Streamline cheat.sh call"
    curl cheat.sh/$argv
end

# Useful aliases
alias timesheet "vim ~/timesheet.md"
alias kssh "kitty +kitten ssh"

alias a 'xdg-open'
alias connect_to_home_vnc "ssh -C -L 5901:home:5901 -N home-pi -v &; sleep 2; vncviewer localhost:1"

# Add scripts
set PATH ~/scripts $PATH

# Greeting
function fish_greeting
  bash ~/scripts/motd.sh
end
