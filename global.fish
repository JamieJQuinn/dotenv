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
alias zbd "zig build debug"

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
alias kittycfg "cd ~/.config/kitty; $EDITOR kitty.conf"
alias i3cfg "cd ~/.config/i3; $EDITOR config"
alias sshcfg "cd ~/.ssh; nvim +'Telescope find_files' ."

function cheatsh --description "Streamline cheat.sh call"
    curl cheat.sh/$argv
end

if test -n "$SSH_AUTH_SOCK";
  ssh-add 2> /dev/null
end

# Useful aliases
alias kssh "kitty +kitten ssh"
alias j "nvim +ZenMode $NOTES_DIR/journal/(date +%Y-%m).md"
alias todo "cd $TODO_DIR; $EDITOR todo.md"
alias a 'xdg-open'
alias d 'date +%Y_%m_%d'
alias enable_performance_mode "asusctl profile -P balanced; supergfxctl -m Hybrid"
alias disable_performance_mode "asusctl profile -P quiet; supergfxctl -m Integrated"
alias notes "cd $NOTES_DIR; nvim +'Telescope find_files' ."
alias bonsai "cbonsai -l -m 'Hello $USER' -b 1 -L 64"

# Add scripts
set PATH ~/scripts $PATH

# Greeting
function fish_greeting
  bash ~/scripts/motd.sh
end
