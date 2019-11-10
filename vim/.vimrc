set encoding=utf8 
set laststatus=2
set number
set lbr
set clipboard=unnamedplus
set hlsearch
set incsearch
filetype on


if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf'

Plug 'bling/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-surround' 

Plug 'scrooloose/nerdtree'

call plug#end()


autocmd FileType tex :map! <f5> <esc> \o
autocmd FileType tex :map <f5> <esc> \o 
