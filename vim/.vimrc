set encoding=utf8 
set laststatus=2
set number
set lbr
set clipboard+=unnamedplus
set hlsearch
set incsearch
set nocompatible
set display+=lastline
set wrap
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

Plug 'tpope/vim-surround' 

Plug 'scrooloose/nerdtree'

call plug#end()

map <f6> :FZF
map! <f6> <esc>:FZF
autocmd FileType tex map <f5> :w<CR> :lcd %:p:h<CR> :! pdflatex %<CR><CR> 
autocmd FileType tex map! <f5> <esc>:w<CR> :lcd %:p:h<CR> :! pdflatex %<CR><CR> 
