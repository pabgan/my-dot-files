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
set hidden		" Hide buffers when they are abandoned
set mouse=		" Disable mouse usage (all modes)
set undofile		" Maintain the undo history even after the file is saved [1]

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
set noexpandtab
if $CLASS == "trabajo"
	autocmd FileType python setlocal expandtab smarttab shiftwidth=4
	autocmd FileType java setlocal expandtab smarttab shiftwidth=4
	autocmd FileType shell setlocal expandtab smarttab shiftwidth=4
endif
filetype indent plugin on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER SETTINGS
"
" Enable plugins
"filetype plugin on

" Display a permanent status bar at the bottom of the vi screen showing the filename, row number, column number, etc. [1]
set laststatus=2

" Underline current line
set cursorline
" Highlight current line
highlight CursorLine cterm=NONE ctermbg=DarkGrey

" For line number to appear in the line selected and all the other ones
" relative to it
set number relativenumber

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYBINDINGS
"
" Make wildchar work within keybindings
set wcm=<C-Z>

" ------ CONFIG ------------------------------------------------------------
" Toggle showing line numbers
nmap <C-S><C-N> :set invnumber invrelativenumber<CR>

" Toggle showing a line to know where to wrap the text [3]
nnoremap <C-S><C-C> :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>

" Toggle showing metacharacters
nmap <C-S><C-H> :set list!<CR>

" ------ EXECUTE ----------------------------------------------------------
" Execute query and bring results
vnoremap <C-X><C-Q> msy'so<ESC>map'a0v/;<CR>:s/%/\\\%/ge<CR>'av/;<CR>hy'av/;<CR>d<ESC>:read !~/.scripts/sqlturbo.py -u <C-R>=DB<CR> -f <C-R>=DBF<CR> "<C-R>""<CR>
nnoremap <C-X><C-Q> vipyvip$<ESC>o<ESC>map'a0v/;<CR>:s/%/\\\%/ge<CR>'av/;<CR>hy'av/;<CR>d<ESC>:read !~/.scripts/sqlturbo.py -u <C-R>=DB<CR> -f <C-R>=DBF<CR> "<C-R>0"<CR>
" desc(ribe) table or view
nnoremap <C-X><C-D> wbidesc <ESC>bvee:call slime#send_op(visualmode(), 1)<cr>u

if $CLASS == "trabajo"
	let $LD_LIBRARY_PATH="/usr/lib/oracle/12.2/client64/lib:"
endif

" Execute command
vnoremap <C-X><C-S> y:read !<C-R>"<CR><CR>
nnoremap <C-X><C-S> yip:read !<C-R>"<BS><CR>

" ------ USUAL FORMAT CHANGES ---------------------------------------------
" Flatten
nnoremap <C-C><C-F> vipJV:s/\s\+/, /g<CR>
nnoremap <C-C><C-U> :s/,\s*/\r/g<CR>

" ------ OTHERS -----------------------------------------------------------
" Search for what it is selected pressing / twice
vnoremap // y/<C-R>"<CR>

" Copy the whole file into the system clipboard
nnoremap \ya gg"+yG''

" CD into current file's directory
nnoremap <C-C><C-D> :cd %:p:h<CR>

" Copy just this line in vimdiff
nnoremap <C-I><C-Y> <C-W>pyy<C-W>pPjdd
nnoremap <C-I><C-C> vecClosed<ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SNIPPETS and TEMPLATES [2]
"
"" JIRA
" Let me decide between snippets (Insert Snippet)
nnoremap \is<TAB> :read $HOME/Plantillas/snippets/<C-Z>
" Insert a {code:}{code} block
nnoremap \isjc :-1read $HOME/Plantillas/snippets/jira-code-block.txt<CR>f:a
vnoremap \isjc d:-1read $HOME/Plantillas/snippets/jira-code-block.txt<CR>pkf:a
" Insert a {noformat}{noformat} block
nnoremap \isjn :-1read $HOME/Plantillas/snippets/jira-noformat-block.txt<CR>o
vnoremap \isjn d:-1read $HOME/Plantillas/snippets/jira-noformat-block.txt<CR>p
" Make it no format
nnoremap \isj{ wBi{{<ESC>Ea}}<ESC>
" Insert thumbnail
vnoremap \isjt d:-1read $HOME/Plantillas/snippets/jira-thumbnail-tag.txt<CR>p
nnoremap \isjt WBdW:-1read $HOME/Plantillas/snippets/jira-thumbnail-tag.txt<CR>pjddk
" Insert attachment
vnoremap \isja d:-1read $HOME/Plantillas/snippets/jira-attachment-tag.txt<CR>lp
nnoremap \isja WBdW:-1read $HOME/Plantillas/snippets/jira-attachment-tag.txt<CR>lpjddk
" Insert result tag
nnoremap \isjp :read $HOME/Plantillas/snippets/jira-pass.txt<CR>
nnoremap \isjf :read $HOME/Plantillas/snippets/jira-fail.txt<CR>
nnoremap \isjs :read $HOME/Plantillas/snippets/jira-skipped.txt<CR>

"" CVS
" Insert CVS header
nnoremap \isch :read $HOME/Plantillas/snippets/cvs-header.txt<CR>

"" Makefile
" Insert Makefile snippets
nnoremap \isM<TAB> :read $HOME/Plantillas/snippets/makefile-<C-Z>

"" Markdown
" Insert Markdown snippets
nnoremap \ism<TAB> :read $HOME/Plantillas/snippets/markdown-<C-Z>

"" Templates
" Let me decide between templates (Insert Template)
nnoremap \it<TAB> :read $HOME/Plantillas/ASSIA/<C-Z>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DEVELOPMENT TOOLS
"
" Look in the current directory for "tags", and work up the tree towards root until one is found [4]
set tags=./.tags;/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOMATIONS
"
" Autogenerate PDF for Markdown files
autocmd BufWritePost *.mkd ! pandoc -o "<afile>.pdf" "<afile>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"
" vim-slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{down-of}"}
" vim-autotags
let g:autotagTagsFile=".tags"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VARIABLES
"
if $CLASS == "trabajo"
	let DB=$DB
	let DBF=$DBF
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SOURCES
" [1] https://opensource.com/article/18/9/vi-editor-productivity-powerhouse
" [2] https://www.youtube.com/watch?v=XA2WjJbmmoM / https://github.com/changemewtf/no_plugins/
" [3] https://vi.stackexchange.com/questions/17573/function-to-toggle-set-colorcolumn
" [4] https://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
