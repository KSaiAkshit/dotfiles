if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose "Rosé Pine"
end

# Aliases

alias ari aria2c
alias bgg 'swww img'
alias bt bartib
alias c clear
alias cat bat
alias cls clear
alias cp 'cp -i'
alias g gh
alias gog 'web-search google'
alias gp tgpt
alias hm home-manager
alias home 'tmux new -s Home'
alias hx helix
alias icat 'kitten icat'
alias la 'eza -la --icons --group-directories-first'
alias ll 'eza -l --icons --group-directories-first'
alias ln 'ln -i'
alias mkdir 'mkdir -pv'
alias mv 'mv -i'
alias nps 'web-search nixpkgs'
alias p paru
alias pls 'doas (builtin history -n 1 | string split " "; and echo $1)'
alias rm 'trash -i'
alias rmrf 'rm -rf'
alias rosd 'ros-docker-run.py'
alias sg 's -p google'
alias ta 'tmux attach'
alias trash 'trash -i'
alias v viml
alias vim nvim
alias wget 'wget -c'
alias y zellij-runner
alias zj zellij
alias zja 'zellij a -c $(basename $("pwd"))'

# Abbreviations

abbr -a bu --function projectdo_build
abbr -a pr --function projectdo_tool
abbr -a ru --function projectdo_run
abbr -a te --function projectdo_test
abbr aoct "cargo gen --path $HOME/dev/template/aoc_template --vcs=none"
abbr bc bard-cli
abbr exe exercism
abbr how how2
abbr pbr "pomodoro break"
abbr pwo "pomodoro work"
abbr reload "exec fish"
abbr sfsh "source ~/.config/fish/config.fish"

function nvc
    set -x NVIM_APPNAME NvChad
    nvim $argv
end

function viml
    set -x NVIM_APPNAME LazyVim
    nvim $argv
end

# Variables
export EDITOR=/usr/bin/helix
export HAS_ALLOW_UNSAFE=y
set -g fish_key_bindings fish_hybrid_key_bindings
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_visual underscore
set -x THEFUCK_OVERIDDEN_ALIASES hub
set -x PNPM_HOME "/home/akshit/.local/share/pnpm"
set -x PATH "$BUN_INSTALL/bin" $PATH
switch "*:$PATH:"
    case "*:$PNPM_HOME:"
    case "*"
        set -x PATH "$PNPM_HOME" $PATH
end


# fish settings
set hydro_color_pwd "#a84055"

# Hook for direnv
direnv hook fish | source

# Zoxide settings
zoxide init fish | source

# Starship settings
starship init fish | source
enable_transience

# Luarocks
eval "$(luarocks path --lua-version 5.1)"

# cod init
cod init $fish_pid fish | source

# asdf
source /opt/asdf-vm/asdf.fish

# atuin
atuin init fish | source
