" ┌──────────────────────────────────────────────┐
" │ vim init, just loads lua and the color theme │
" └──────────────────────────────────────────────┘
source $HOME/.config/nvim/themes/mountain.vim
luafile $HOME/.config/nvim/lua/init.lua

autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"
" asd

" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path
