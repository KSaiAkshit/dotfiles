function fish_user_key_bindings
  fzf_key_bindings
  bind -M insert -m default jj backward-char force-repaint
  bind \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
end
