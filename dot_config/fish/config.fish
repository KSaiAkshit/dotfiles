if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose "Rosé Pine"
end

# Aliases

alias arduino 'arduino-cli'
alias ari aria2c
alias bgg 'swww img'
alias bt bartib
alias c clear
alias cat bat
alias chmox 'chmod +x'
alias cls clear
alias cp 'cp -i'
alias docs 'web-search docs'
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
alias pls 'doas (builtin history -n 1 | string split " "; and echo $1)'
alias rdoc 'web-search rustdoc'
alias rm 'trash -i'
alias rmrf 'rm -rf'
alias sg 's -p google'
alias ta 'tmux attach'
alias trash 'trash -i'
alias tree 'eza --tree'
alias vim viml
alias v nvim
alias wget 'wget -c'
alias zs zellij-smart-sessionizer
alias zj zellij
alias zja 'zellij a -c $(basename $("pwd"))'

# Abbreviations

abbr aoct "cargo gen --path $HOME/dev/template/aoc_template --vcs=none"
abbr bc bard-cli
abbr exe exercism
abbr how how2
abbr j just
abbr lg lazygit
abbr md 'mkdir -pv'
abbr p paru
abbr pbr "pomodoro break"
abbr pwo "pomodoro work"
abbr rd 'web-search rustdoc'
abbr reload "exec fish"
abbr sudo 'doas'

function nvc
    set -x NVIM_APPNAME NvChad
    nvim $argv
end

function mini
    set -x NVIM_APPNAME mini
    nvim $argv
end

function viml
    set -x NVIM_APPNAME LazyVim
    nvim $argv
end

function dvim
    set -x NVIM_APPNAME DreamNvim
    nvim $argv
end

# Variables
export EDITOR=/usr/bin/helix
# export HAS_ALLOW_UNSAFE=y
# set -g fish_key_bindings fish_hybrid_key_bindings
# set -g fish_cursor_default block
# set -g fish_cursor_insert line
# set -g fish_cursor_visual underscore
# set -x THEFUCK_OVERIDDEN_ALIASES hub
# set -x PATH "$BUN_INSTALL/bin" $PATH


# Hook for direnv
direnv hook fish | source

# Zoxide settings
zoxide init fish | source

# Starship settings
starship init fish | source
enable_transience

# completion/suggestion init
# cod init $fish_pid fish | source
carapace _carapace | source

# atuin
atuin init fish | source
