"Welcome to my .vimrc!

"Set commands:
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

"My colorscheme:
colo default
set background=dark		"Sets the background color
highlight clear SpellBad	"Clears the highlighting for badly spelled words (changed to undercurl:)
highlight SpellBad cterm=undercurl

"A script to download and install vim-plug if it is not already installed (vim and nvim):
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) || empty(glob('~/.vim/autoload/plug.vim'))
	if has('nvim')
		silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	else
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	endif
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"My plugins using vim-plug
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'

Plug 'dylanaraps/wal.vim'

Plug 'junegunn/goyo.vim'

call plug#end()

"My custom commands:

"A command to open the current document's pdf in zathura:
autocmd FileType tex,markdown,lilypond command!-buffer ReadPDF :silent !zathura --fork "%<.pdf"

"Commands to compile markup
"LaTeX compilation:
autocmd FileType tex command!-buffer CompMarkup normal! :w<CR>:!latexmk -pdf -cd --shell-escape -lualatex "%"<CR>
"Markdown compilation (asks for output format as an extension: i.e.: pdf, tex, docx, etc.):
autocmd FileType markdown command!-buffer CompMarkup if !exists('b:format') | let b:format = input("Output format: ") | endif | exe 'normal!:w<CR>:!pandoc "%" -f markdown -o "%<.' . b:format .'"<CR>'
"Lilypond compilation:
autocmd FileType lilypond command!-buffer CompMarkup normal! :w<CR>:lcd%:p:h<CR>:!lilypond "%"<CR>

"Silent compilation
autocmd FileType tex,markdown,lilypond command!-buffer CompMarkupSilent :execute ":normal! :silent CompMarkup<CR>" | execute ':normal! :redraw!<CR>'

"My vim mappings:

"Mapping for file search with vim's built in :find command (add set path variable as in the beginning for recursive search):
"Simply start typing and press tab for auto-completion e.g. Docume <Tab> completes to Documents, etc.
map <f6> :find 
map! <f6> <esc>:find 

"Mappings for easing prose-writing:
autocmd FileType text,tex,markdown,lilypond map k gk
autocmd FileType text,tex,markdown,lilypond map j gj
autocmd FileType text,tex,markdown,lilypond map <Up> gk
autocmd FileType text,tex,markdown,lilypond map <Down> gj
autocmd FileType text,tex,markdown,lilypond map <F11> :Goyo<CR>
autocmd FileType text,tex,markdown,lilypond map! <F11> <esc>:Goyo<CR>li

autocmd FileType lilypond mapclear <buffer>

"Mapping for markup compile:
autocmd FileType tex,markdown,lilypond exe 'map <f5> :CompMarkupSilent<CR>|map! <f5> <esc><esc>:CompMarkupSilent<CR>'
"Mappings for opening LaTeX, Markdown and LilyPond pdf outputs in zathura:
autocmd FileType tex,markdown,lilypond exe 'map <f4> :ReadPDF<CR>:redraw!<CR>|map! <f4> <esc><esc>:ReadPDF<CR>:redraw!<CR>'

"Mappings for loading of .Xresources upon pressing f5:
autocmd FileType xdefaults map <f5> :w<CR><CR>:!xrdb ~/.Xresources<CR><CR>
autocmd FileType xdefaults map! <f5> <esc><esc>:w<CR><CR>:!xrdb ~/.Xresources<CR><CR>

"Lightline settings:
let g:lightline = {
      \ 'colorscheme': '16color',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
