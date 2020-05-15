"Welcome to my .vimrc!

"Below are all the set commands
"Essentially the main declarations needed
"These include:
"Setting encoding to utf-8
"Setting vim to have numbers for lines on the side
"Setting linebreak so that vim doesn't break apart words
"Setting clipboard to the + register
"Setting filetype plugin on (very important!)

set encoding=utf-8
set laststatus=2
set number
set lbr
set clipboard=unnamedplus
set incsearch
set nohlsearch
set nocompatible
set display+=lastline
set wrap
filetype on
set wildmenu
set path+=**
set nu rnu
set autoindent
set hidden

"A script to download and install vim-plug if it is not already installed:
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"My plugins using vim-plug

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'

Plug 'dylanaraps/wal.vim'

Plug 'vim-airline/vim-airline-themes'

call plug#end()


"My vim mappings below

"Mapping for file search with vim's built in :find command (add set path variable as in the beginning for recursive search):
"Simply start typing and press tab for auto-completion e.g. Docume <Tab> completes to Documents, etc.
map <f6> :find 
map! <f6> <esc>:find 

"Mappings for opening LaTeX, Markdown and LilyPond pdf outputs in zathura:
autocmd FileType tex,markdown,lilypond map <f4> :!zathura %<.pdf & disown<CR><CR>
autocmd FileType tex,markdown,lilypond map! <f4> <esc><esc>:!zathura %<.pdf & disown<CR><CR>

"Mappings for LaTeX compilation and subsequent opening of created pdf with zathura:
autocmd FileType tex map <f5> :w<CR>:lcd%:p:h<CR>:!latex %<CR><CR>:!biber %<<CR><CR>:!pdflatex %<CR><CR>
autocmd FileType tex map! <f5> <esc><esc>:w<CR>:lcd%:p:h<CR>:!latex %<CR><CR>:!biber %<<CR><CR>:!pdflatex %<CR><CR>

"Mappings for pandoc Markdown compilation:
"You will essentially be asked for output format (as an extension: i.e.: pdf, tex, docx, etc.)
autocmd FileType markdown map <f5> :w<CR>:lcd%:p:h<CR>:!pandoc % -f markdown -o %<."$(read -p "Output format: " format; echo "$format")"<CR><CR>
autocmd FileType markdown map! <f5> <esc>:w<CR>:lcd%:p:h<CR>:!pandoc % -f markdown -o %<."$(read -p "Output format: " format; echo "$format")"<CR><CR>

"Mappings for lilypond sheet music compilation:
autocmd FileType lilypond mapclear <buffer>
autocmd FileType lilypond map <f5> :w<CR>:lcd%:p:h<CR>:!lilypond %<CR><CR>
autocmd FileType lilypond map! <f5> <esc>:w<CR>:lcd%:p:h<CR>:!lilypond %<CR><CR>

"Mappings for loading of .Xresources upon pressing f5:
autocmd FileType xdefaults map <f5> :w<CR><CR>:lcd%:p:h<CR><CR>:!xrdb ~/.Xresources<CR><CR>
autocmd FileType xdefaults map! <f5> <esc><esc>:w<CR><CR>:lcd%:p:h<CR><CR>:!xrdb ~/.Xresources<CR><CR>

"Airline settings:
let g:airline_theme='wal'
let g:airline#extensions#tabline#enabled = 1

"My colourscheme
colo elflord
