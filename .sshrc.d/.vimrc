" Enter the current millenium [2]
set nocompatible

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
"set undofile		" Maintain the undo history even after the file is saved [1]
set nowrapscan		" Search stops at the end of the buffer (or beginning).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" APPEARANCE
" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark
colorscheme ron

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
" STYLE SETTINGS
filetype indent plugin on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER SETTINGS
"
" Enable plugins
"filetype plugin on

" Display a permanent status bar at the bottom of the vi screen showing the filename, row number, column number, etc. [1]
set laststatus=2

" Underline current line
nmap \sh :set cursorline!<CR>
" Highlight current line
highlight CursorLine cterm=NONE ctermbg=DarkGrey

" For line number to appear in the line selected and all the other ones
" relative to it
set number 
if v:version > 703 
	set relativenumber
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYBINDINGS
"
" Toggle showing line numbers
nmap \sn :set invnumber invrelativenumber<CR>

" Toggle showing a line to know where to wrap the text [3]
nnoremap \sc :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>

" Toggle showing metacharacters
nmap \sl :set list!<CR>

" Toggle wrapping lines
nmap \sw :set wrap!<CR>

" Toggle paste
nmap \sp :set paste!<CR>

if $CLASS == "trabajo"
	let $LD_LIBRARY_PATH="/usr/lib/oracle/12.2/client64/lib:"
endif

" Execute command
vnoremap \xs y:read !<C-R>"<CR><CR>
nnoremap \xs 0y$:read !<C-R>"<CR><CR>

" ------ USUAL FORMAT CHANGES ---------------------------------------------
" Flatten
nnoremap \cf vipJV:s/\s\+/, /g<CR>
nnoremap \cu :s/,\s*/\r/g<CR>
" Format in columns
vnoremap \cl :!column -t -s','

" ------ OTHERS -----------------------------------------------------------
" Search for what it is selected pressing / twice
vnoremap // y/<C-R>"<CR>

" Copy the whole file into the system clipboard
nnoremap \ya gg"+yG''

" CD into current file's directory
nnoremap \cd :cd %:p:h<CR>

" Copy just this line in vimdiff
nnoremap \ciy <C-W>pyy<C-W>pPjdd
nnoremap \ic vecClosed<ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SOURCES
" 1. https://opensource.com/article/18/9/vi-editor-productivity-powerhouse
" 2. https://www.youtube.com/watch?v=XA2WjJbmmoM / https://github.com/changemewtf/no_plugins/
" 3. https://vi.stackexchange.com/questions/17573/function-to-toggle-set-colorcolumn
