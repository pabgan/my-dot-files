" Enter the current millenium
set nocompatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on
filetype indent plugin on

" Recommended settings
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch		" Highlight all search matches
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" For line number to appear in the line selected and all the other ones
" relative to it
set number relativenumber
" Toggle showing line numbers
nmap <C-N><C-N> :set invnumber invrelativenumber<CR>

" Toggle showing metacharacters
nmap <C-H><C-H> :set list!<CR>

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Buscar lo que hay seleccionado pulsando / dos veces
vnoremap // y/<C-R>"<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER SETTINGS
"
" Enable plugins
filetype plugin on
" Highlight current line
set cursorline
hi CursorLine cterm=NONE ctermbg=black 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BUILT IN FUZZY SEARCH
" 
" Search down into subfolders recursively
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WECAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy
"
" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer
