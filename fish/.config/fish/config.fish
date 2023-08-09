if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Aliases

alias ari aria2c
alias bgg 'swww img'
alias c clear
alias cat bat
alias cls clear
alias cp 'cp -i'
alias g hub
alias git hub
alias gog 'web-search google'
alias gp tgpt
alias hmm home-manager
alias home 'tmux new -s Home'
alias hx helix
alias icat 'kitten icat'
alias la 'exa -la --icons --group-directories-first'
alias ll 'exa -l --icons --group-directories-first'
alias ln 'ln -i'
alias mkdir 'mkdir -pv'
alias mv 'mv -i'
alias nps 'web-search nixpkgs'
alias nvc nvchad
alias rm 'rm -i'
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
abbr -a bu --function projectdo_build
abbr -a pr --function projectdo_tool
abbr -a ru --function projectdo_run
abbr -a te --function projectdo_test
abbr how how2
abbr pbr "pomodoro break"
abbr pwo "pomodoro work"
abbr sfsh "source ~/.config/fish/config.fish"
abbr reload "exec fish"

function nvchad
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
set -x THEFUCK_OVERIDDEN_ALIASES hub
# export XDG_DATA_HOME="$HOME/.local/share"

# fish settings
set hydro_color_pwd "#a84055"

# Hook for direnv
direnv hook fish | source

# Zoxide settings
zoxide init fish | source

# Starship settings
starship init fish | source
enable_transience

# cod init
cod init $fish_pid fish | source

# Nix stuff
replay '. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh'

# asdf
source /opt/asdf-vm/asdf.fish

# atuin
atuin init fish | source
