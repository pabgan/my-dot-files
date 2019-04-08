" Enter the current millenium [2]
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
set mouse=		" Disable mouse usage (all modes)

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark
colorscheme ron

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STYLE SETTINGS
set softtabstop=4
set shiftwidth=4
set tabstop=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER SETTINGS
"
" Enable plugins
filetype plugin on

" Display a permanent status bar at the bottom of the vi screen showing the filename, row number, column number, etc. [1]
set laststatus=2

" Underline current line
set cursorline
" Highlight current line
hi CursorLine cterm=NONE ctermbg=black

" For line number to appear in the line selected and all the other ones
" relative to it
set number relativenumber
" Toggle showing line numbers
nmap <C-N><C-N> :set invnumber invrelativenumber<CR>

" Toggle showing metacharacters
nmap <C-H><C-H> :set list!<CR>

" Buscar lo que hay seleccionado pulsando / dos veces
vnoremap // y/<C-R>"<CR>

" Maintain the undo history even after the file is saved [1]
set undofile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BUILT IN FUZZY SEARCH [2]
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SNIPPETS [2]
"
" Insert a {code:}{code} block
nnoremap \jc :-1read $HOME/Plantillas/snippets/jira-code-block.txt<CR>f:a
" Surround text selected with a code block
vnoremap \jac d:-1read $HOME/Plantillas/snippets/jira-code-block.txt<CR>pkf:a
" Insert a {noformat}{noformat} block
nnoremap \jn :-1read $HOME/Plantillas/snippets/jira-noformat-block.txt<CR>o
" Surround text selected with a noformat block
vnoremap \jan d:-1read $HOME/Plantillas/snippets/jira-noformat-block.txt<CR>p
" Execute SQL query
vnoremap <c-e> yG:read !sqlturbo.py <c-r>=DB<CR> <c-r>=DBF<CR> "<c-r>""<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SOURCES
" 1. https://opensource.com/article/18/9/vi-editor-productivity-powerhouse
" 2. https://www.youtube.com/watch?v=XA2WjJbmmoM / https://github.com/changemewtf/no_plugins/
