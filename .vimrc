set encoding=utf8 
set laststatus=2
set number
set lbr
set clipboard=unnamedplus
filetype on


if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf'

Plug 'itchyny/lightline.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'xuhdev/vim-latex-live-preview'

Plug 'tpope/vim-surround' 

call plug#end()


autocmd FileType tex :map! <f5> <esc> :LLPStartPreview
autocmd FileType tex :map <f5> <esc> :LLPStartPreview <CR>
