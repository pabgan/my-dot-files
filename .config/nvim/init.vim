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
" NETRW
" [6]
"let g:netrw_winsize = 25
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1

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
nmap <C-S><C-H> :set cursorline!<CR>
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
nmap <C-S><C-L> :set list!<CR>

" Toggle wrapping lines
nmap <C-S><C-W> :set wrap!<CR>

" Toggle paste
nmap <C-S><C-P> :set paste!<CR>

" ------ EXECUTE ----------------------------------------------------------
" Execute query and bring results
nnoremap <C-X><C-Q> yap}pvip:s/%/\\\%/ge<CR>vipd:-1read !~/.local/bin/sqlturbo.py -u <C-R>=CUSTOMER_DB<CR> -f <C-R>=DBF<CR> "<C-R>""<CR>
" desc(ribe) table or view
nnoremap <C-X><C-D> viw<ESC>b<ESC>idesc <ESC>bvee:call slime#send_op(visualmode(), 1)<cr>u
nnoremap <C-X><C-V> viwyo<CR>select text from user_views where view_name='<C-R>"';<ESC>o<ESC>kvip:call slime#send_op(visualmode(), 1)<cr>u

if $CLASS == "trabajo"
	let $LD_LIBRARY_PATH="/usr/lib/oracle/12.2/client64/lib:"
endif

" Execute command
vnoremap <C-X><C-S> y:read !<C-R>"<CR><CR>
nnoremap <C-X><C-S> 0y$:read !<C-R>"<CR><CR>

" ------ USUAL FORMAT CHANGES ---------------------------------------------
" Flatten
nnoremap <C-C><C-F> vipJV:s/\s\+/, /g<CR>
nnoremap <C-C><C-U> :s/,\s*/\r/g<CR>
" Format in columns
vnoremap <C-C><C-L> :!column -t -s','

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
" SNIPPETS and TEMPLATES and FORMAT automations [2]
"
"" Common
" Jump to next edit point
inoremap <TAB><Space> <ESC>/<++><Enter>"_c4l

" Let me decide between snippets (Insert Snippet)
nnoremap \s<TAB> :read $HOME/Templates/snippets/<C-Z>
"nnoremap \s<TAB> :read $HOME/Templates/snippets/<C-Z>:set nopaste<C-Z>i<TAB><Space>

"" MarkDown
" Insert image
nnoremap \si diWa![<C-R>"](<C-R>")<ESC>
" Insert link
nnoremap \sl diWa[<C-R>"](<C-R>")<ESC>

"" JIRA
" Insert SCENARIO divider
nnoremap \sS :read $HOME/Templates/snippets/jira-scenario.txt<CR>/<++><Enter>"_c4l
" Insert test
nnoremap \sT :read $HOME/Templates/snippets/jira-test.txt<CR>/<++><Enter>"_c4l
" Insert a {code:}{code} block
nnoremap \sc :-1read $HOME/Templates/snippets/jira-code-block.txt<CR>/<++><Enter>"_c4l
vnoremap \sc d:-1read $HOME/Templates/snippets/jira-code-block.txt<CR>pk/<++><Enter>"_c4l
" Insert a {noformat}{noformat} block
nnoremap \sn :-1read $HOME/Templates/snippets/jira-noformat-block.txt<CR>o
vnoremap \sn d:-1read $HOME/Templates/snippets/jira-noformat-block.txt<CR>p
" Make it no format
nnoremap \s{ viw<ESC>Bi{{<ESC>Ea}}<ESC>
" Insert thumbnail
nnoremap \st WBdW:-1read $HOME/Templates/snippets/jira-thumbnail-tag.txt<CR>pjddk
vnoremap \st d:-1read $HOME/Templates/snippets/jira-thumbnail-tag.txt<CR>p
" Insert attachment
nnoremap \sa WBdE:-1read $HOME/Templates/snippets/jira-attachment-tag.txt<CR>/<++><Enter>"_c4l<C-R>"<ESC>J
" [5]
inoremap \sa <C-R>=system('cat $HOME/Templates/snippets/jira-attachment-tag.txt')<CR><ESC>kJB/<++><Enter>"_c4l
vnoremap \sa d<C-R>=system('cat $HOME/Templates/snippets/jira-attachment-tag.txt')<CR><ESC>kJB/<++><Enter>"_c4l
" Insert result tag
nnoremap \sp :read $HOME/Templates/snippets/jira-pass.txt<CR>
nnoremap \sf :read $HOME/Templates/snippets/jira-fail.txt<CR>
nnoremap \ss :read $HOME/Templates/snippets/jira-skipped.txt<CR>
" Insert "verified" sentence
nnoremap \sv :-1read $HOME/Templates/snippets/jira-verified-in.txt<CR>/<++><Enter>"_c4l<C-R>=CUSTOMER_ENV<ENTER><ESC>n"_c4l<C-R>=CUSTOMER_VER<ENTER><ESC>

"" CVS
" Insert CVS header
nnoremap \sh :read $HOME/Templates/snippets/cvs-header.txt<CR>

"" Markdown
" Underline line with =
nnoremap \s= yypv$r=
" Underline line with -
nnoremap \s- yypv$r-
" Emphasize it
nnoremap \s* wbi*<ESC>Ea*<ESC>
vnoremap \s* A*<ESC>`<i*<ESC>`>l
" Emphasize it more
nnoremap \s** wbi**<ESC>Ea**<ESC>
vnoremap \s** A**<ESC>`<i**<ESC>`>ll

"" Templates
" Let me decide between templates (Insert Template)
nnoremap \t<TAB> :read $HOME/Templates/ASSIA/<C-Z>

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
" fzf
set rtp+=/srv/repos/fzf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VARIABLES
"
if $CLASS == "work"
	let CUSTOMER_ENV=$CUSTOMER_ENV
	let CUSTOMER_VER=$CUSTOMER_VER
	let CUSTOMER_NAME=$CUSTOMER_NAME
	let CUSTOMER_DB=$CUSTOMER_DB
	let DBF=$DBF
endif

let TASK=$TASK

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SOURCES
" [1] https://opensource.com/article/18/9/vi-editor-productivity-powerhouse
" [2] https://www.youtube.com/watch?v=XA2WjJbmmoM / https://github.com/changemewtf/no_plugins/
" [3] https://vi.stackexchange.com/questions/17573/function-to-toggle-set-colorcolumn
" [4] https://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
" [5] https://unix.stackexchange.com/questions/61273/while-in-vi-how-can-i-pull-in-insert-paste-the-contents-of-another-file
" [6] https://shapeshed.com/vim-netrw/
