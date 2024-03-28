# Nice git aliases
abbr -a gc git commit
abbr -a gs git status
abbr -a gd git diff
abbr -a gdh git diff HEAD~1
abbr -a gb git branch
abbr -a gl git log
abbr -a ga git add

# Cmake
abbr -a cmB cmake -B build
abbr -a cmb cmake --build build
abbr -a cmt ctest --test-dir build/tests/ --rerun-failed --output-on-failure

# Zig
alias zbr "zig build run"

# Vim
set -x EDITOR nvim
alias vim nvim

## Todos
set -x TODO_DIR ~/notes/todo

# Notes
set -x NOTES_DIR ~/notes

# Configs
alias vimcfg "cd ~/.config/nvim; $EDITOR +'Telescope find_files' ."
alias fishcfg "cd ~/.config/fish; $EDITOR +'Telescope find_files' ."
alias kittycfg "cd ~/.config/kitty; $EDITOR kitty.conf"
alias i3cfg "cd ~/.config/i3; $EDITOR config"

function cheatsh --description "Streamline cheat.sh call"
    curl cheat.sh/$argv
end

# Useful aliases
alias kssh "kitty +kitten ssh"

alias a 'xdg-open'

# Add scripts
set PATH ~/scripts $PATH

# Greeting
function fish_greeting
  bash ~/scripts/motd.sh
end
