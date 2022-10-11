if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ROS
source /opt/ros/noetic/share/rosbash/rosfish
bass source /opt/ros/noetic/setup.bash

# for npm
bass source ~/.profile

# Setting up z
lua ~/tools/z.lua/z.lua --init fish | source

# Alias
alias ll 'exa -la --icons' 
alias g 'git'
alias cat 'bat'
alias config '/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# hydro settings
set hydro_color_pwd "#a84055"

# Set Editor
set -gx EDITOR lvim

# THE FUCK
thefuck --alias | source


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/akshit/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

