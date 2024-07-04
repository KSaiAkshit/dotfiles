function fish_user_key_bindings
    bind -M insert \co 'set old_tty (stty -g); stty sane; yy; stty $old_tty; commandline -f repaint'
    bind -M default \co 'set old_tty (stty -g); stty sane; yy; stty $old_tty; commandline -f repaint'
end
