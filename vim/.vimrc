"Welcome to my .vimrc!

"Below are all the set commands
"Essentially the main declarations needed
"These include:
"Setting encoding to utf-8
"Setting vim to have numbers for lines on the side
"Setting linebreak so that vim doesn't break apart words
"Setting clipboard to the register
"Setting filetype plugin on (very important!)

set encoding=utf8 
set laststatus=2
set number
set lbr
set clipboard=unnamedplus
set incsearch
set nocompatible
set display+=lastline
set wrap
filetype on

"A script to download and install vim-plug if it is not already installed:
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"My plugins using vim-plug 

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf'

Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-surround' 

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'

Plug 'sirver/ultisnips'

Plug 'dylanaraps/wal.vim'

Plug 'vim-airline/vim-airline-themes'

call plug#end()


"My vim mappings below

"Mapping for fuzzy search (set to the home directory):
map <f6> :FZF ~/<CR>
map! <f6> <esc>:FZF ~/<CR>

"Mappings for LaTeX compilation and opening with zathura:
autocmd FileType tex map <f5> :w<CR> :lcd %:p:h<CR> :! latex %<CR><CR> :! biber %<<CR><CR> :! pdflatex %<CR><CR>
autocmd FileType tex map! <f5> <esc><esc>:w<CR> :lcd %:p:h<CR> :! latex %<CR><CR> :! biber %<<CR><CR> :! pdflatex %<CR><CR>
autocmd FileType tex map <f4> :lcd %:p:h<CR> :! zathura %<.pdf & disown<CR><CR>
autocmd FileType tex map! <f4> <esc><esc>:lcd %:p:h<CR> :! zathura %<.pdf & disown<CR><CR>

"Mappings for R Markdown compilation and opening with zathura:
autocmd FileType markdown map <f5> :w<CR> :lcd %:p:h<CR> :! R -e "rmarkdown::render('%', 'pdf_document', output_file='%<.pdf')"<CR><CR>
autocmd FileType markdown map! <f5> <esc><esc>:w<CR> :lcd %:p:h<CR> :! R -e "rmarkdown::render('%', 'pdf_document', output_file='%<.pdf')"<CR><CR>
autocmd FileType markdown map <f4> :lcd %:p:h<CR> :! zathura %<.pdf & disown<CR><CR>
autocmd FileType markdown map! <f4> <esc><esc>:lcd %:p:h<CR> :! zathura %<.pdf & disown<CR><CR>

"Mappings for loading of .Xresources upon pressing f5:
autocmd FileType xdefaults map <f5> :w<CR><CR> :lcd %:p:h<CR><CR> :! xrdb ~/.Xresources<CR><CR>
autocmd FileType xdefaults map! <f5> <esc><esc>:w<CR><CR> :lcd %:p:h<CR><CR> :! xrdb ~/.Xresources<CR><CR> 

"Airline settings:
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled = 1
