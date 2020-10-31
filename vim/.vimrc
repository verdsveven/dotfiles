"Welcome to my .vimrc!

"Below are all the set commands

set encoding=utf-8		"Setting encoding to utf-8
set laststatus=2		"Sets when the last window will have a statusline
set number			"Setting vim to have numbers for lines on the side
set lbr				"Setting linebreak so that vim doesn't break apart words
set clipboard=unnamedplus	"Setting clipboard to the + register
set incsearch			"Shows where the pattern typed so far matches
set nohlsearch			"Disables highlighting words after a search
set nocompatible		"Disables vi-compatibility mode
set display+=lastline
set wrap			"Essentially enables soft-wrap
filetype on			"Setting filetype plugin on (very important!)
set wildmenu			"Enables better command line completion with <Tab>
set path+=**			"List of directories which will be searched by commands such as :find
set nu rnu			"Enables relative numbers
set autoindent			"Automatic indentation

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

Plug 'junegunn/goyo.vim'

call plug#end()

"My custom commands

"A command to open the current document's pdf in zathura:
command ReadPDF :silent !zathura --fork %<.pdf

"My vim mappings below

"Mapping for file search with vim's built in :find command (add set path variable as in the beginning for recursive search):
"Simply start typing and press tab for auto-completion e.g. Docume <Tab> completes to Documents, etc.
map <f6> :find 
map! <f6> <esc>:find 

"Mappings for opening LaTeX, Markdown and LilyPond pdf outputs in zathura:
autocmd FileType tex,markdown,lilypond execute "map <f4> :ReadPDF<CR> | map! <f4> <esc><esc>:ReadPDF<CR>"

"Mappings for LaTeX compilation and subsequent opening of created pdf with zathura:
autocmd FileType tex map <f5> :w<CR>:!latexmk -pdf -cd --shell-escape %<CR><CR>
autocmd FileType tex map! <f5> <esc><esc>:w<CR>:!latexmk -pdf -cd --shell-escape %<CR><CR>

"Mappings for pandoc Markdown compilation:
"You will essentially be asked for output format (as an extension: i.e.: pdf, tex, docx, etc.)
autocmd FileType markdown map <f5> :w<CR>:lcd%:p:h<CR>:!pandoc % -f markdown -o %<."$(read -p "Output format: " format; echo "$format")"<CR><CR>
autocmd FileType markdown map! <f5> <esc>:w<CR>:lcd%:p:h<CR>:!pandoc % -f markdown -o %<."$(read -p "Output format: " format; echo "$format")"<CR><CR>

"Mappings for lilypond sheet music compilation:
autocmd FileType lilypond mapclear <buffer>
autocmd FileType lilypond map <f5> :w<CR>:lcd%:p:h<CR>:!lilypond %<CR><CR>
autocmd FileType lilypond map! <f5> <esc>:w<CR>:lcd%:p:h<CR>:!lilypond %<CR><CR>

"Mappings for loading of .Xresources upon pressing f5:
autocmd FileType xdefaults map <f5> :w<CR><CR>:!xrdb ~/.Xresources<CR><CR>
autocmd FileType xdefaults map! <f5> <esc><esc>:w<CR><CR>:!xrdb ~/.Xresources<CR><CR>

"Airline settings:
let g:airline_theme='wal'
let g:airline#extensions#tabline#enabled = 1

"My colourscheme
colo elflord
