#!/bin/bash

# You can enable both at the same time

# copy an url to clipboard
printf "%s" "$1" | wl-copy 
# copy to tmux
#printf "%s" "$1" | tmux loadb -
