alias ari = aria2c
alias bgg = swww img
alias c = clear
alias cat = bat
alias cls = clear
alias cp = cp -i
alias g = git
alias home = tmux new -s Home
alias icat = kitten icat
alias j = just
alias l = exa -l --icons --group-directories-first
alias la = exa -la --icons --group-directories-first
alias ll = exa -l --icons --group-directories-first
alias ln = ln -i
alias md = mkdir
alias mkdir = mkdir -v
alias mv = mv -i
alias reload = exec nu
alias rm = rm -i
alias rmrf = rm -rf
alias rt = trash -i
alias sg = s -p google
alias sudo = doas
alias ta = tmux attach
alias trash = trash -i
alias tree = eza -T
alias v = nvim
alias wget = wget -c
alias zj = zellij

def viml () {
  $env.NVIM_APPNAME = 'LazyVim'
  nvim
}

def nvc () {
  $env.NVIM_APPNAME = 'NvChad'
  nvim
}

def mini () {
  $env.NVIM_APPNAME = 'mini'
  nvim
}

def mvim () {
  $env.NVIM_APPNAME = 'mvim'
  nvim
}
