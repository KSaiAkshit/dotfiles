function fish_user_key_bindings
  fzf_key_bindings
  bind -M insert -m default jj backward-char force-repaint
  # bind \co 'commandline ranger-cd; commandline -f execute'
  bind \co 'set old_tty (stty -g); stty sane; ranger-cd; stty $old_tty; commandline -f repaint'
end
