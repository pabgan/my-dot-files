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
" VARIABLES
"
let TASK=$TASK

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
if $CLASS == "work"
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

" Open FZF find
nmap \of :FZF <CR>

" Open a wiki page
nmap \ow :FZF ~/Documents/KnowHow/wiki<CR>

" Open terminal in another tab
nmap \ot :term:b#

" Navigate buffers
nmap \bp :bp<CR>
nmap \bn :bn<CR>
nmap \bl :b#<CR>
nmap \bd :bd<CR>

" ------ CONFIG ------------------------------------------------------------
" Underline current line
nmap \sh :set cursorline!<CR>

" Toggle showing line numbers
nmap \sn :set invnumber invrelativenumber<CR>

" Toggle showing a line to know where to wrap the text [3]
nmap \sc :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>

" Toggle showing metacharacters
nmap \sl :set list!<CR>

" Toggle wrapping lines
nmap \sw :set wrap!<CR>

" Toggle paste
nmap \sp :set paste!<CR>

" ------ EXECUTE ----------------------------------------------------------
" Execute query and bring results
nmap \xq yap}pvip:s/%/\\\%/ge<CR>vip:s/!/\\\!/ge<CR>vipd:-1read !~/.local/bin/sqlturbo.py -u <C-R>=$CUSTOMER_DB<CR> -f <C-R>=$DBF<CR> "<C-R>""<CR>
" desc(ribe) table or view
nmap \xd viw<ESC>b<ESC>idesc <ESC>bvee:call slime#send_op(visualmode(), 1)<cr>u
nmap \xv viwyo<CR>select text from user_views where view_name='<C-R>"';<ESC>o<ESC>kvip:call slime#send_op(visualmode(), 1)<cr>u

if $CLASS == "work"
	let $LD_LIBRARY_PATH="/usr/lib/oracle/12.2/client64/lib:"
endif

" Execute command
"vnoremap \xs y:read !sh -c '<C-R>"<CR>'<CR>
"nmap <C-X><C-S> 0y$:read !sh -c '<C-R>"<CR>'<CR>
"nmap \xs yip}pvip:s/'/\\'/ge<CR>vipd:read !<C-R>"<CR>
nmap \xs yip:read !<C-R>"<CR>

" Execute command in environment
nmap \xe yip:read !ssh $CUSTOMER_ENV '<C-R>"'<CR>
"nmap \xe yip}pvip:s/'/\\'/ge<CR>vipd:read !ssh $CUSTOMER_ENV '<C-R>"'<CR>

" Execute command on open terminal below (not working... too fast?)
nmap \xx vipy:b term:ApA
" ... and copy results
nmap \xy yG:b#vip"_dP


" ------ USUAL FORMAT CHANGES ---------------------------------------------
" Flatten
nmap \cf vipJV:s/\s\+/, /g<CR>:noh<CR>
nmap \cu :s/,\s*/\r/g<CR>:noh<CR>
" Format in columns
vnoremap \cc :!column -t -s','
" Format XML
vnoremap \cx :!xmllint --format -
" Format Json
vnoremap \cj :!python -m json.tool

" ------ OTHERS -----------------------------------------------------------
" Search for what it is selected pressing / twice
vnoremap // y/<C-R>"<CR>

" Copy the whole file into the system clipboard
nmap \ya gg"+yG''

" CD into current file's directory
nmap \cD :cd %:p:h<CR>

" Copy just this line between the two windows
nmap \iy yy<C-W>pp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SNIPPETS and TEMPLATES and FORMAT automations [2]
"
"" Common
" Jump to next edit point
inoremap <TAB><Space> <ESC>/<++><Enter>"_c4l

" Let me decide between snippets (Insert Snippet)
nmap \i<TAB> :read $HOME/Templates/snippets/<C-Z>
"nmap \i<TAB> :read $HOME/Templates/snippets/<C-Z>:set nopaste<C-Z>i<TAB><Space>

"" MarkDown
" Insert image
nmap \ii diWa![<C-R>"](<C-R>")<ESC>
" Insert link
nmap \il viW<ESC>Bi[<ESC>Ea]<ESC>yi[Ea(<C-R>")<ESC>T[
vnoremap \il c[<C-R>"](<C-R>")<ESC>T[

"" JIRA
" Insert SCENARIO divider
nmap \iS :read $HOME/Templates/snippets/jira-scenario.txt<CR>/<++><Enter>"_c4l
" Insert test
nmap \iT :read $HOME/Templates/snippets/jira-test.txt<CR>/<++><Enter>"_c4l
" Insert a ``` block
nmap \ic :read $HOME/Templates/snippets/markdown-code-block.txt<CR>/<++><Enter>"_c4l
vnoremap \ic dk:read $HOME/Templates/snippets/markdown-code-block.txt<CR>p?<++><Enter>"_c4l
" Insert a {noformat}{noformat} block
nmap \in :-1read $HOME/Templates/snippets/jira-noformat-block.txt<CR>o
vnoremap \in d:-1read $HOME/Templates/snippets/jira-noformat-block.txt<CR>p
" Make it no format
nmap \i{ viw<ESC>Bi{{<ESC>Ea}}<ESC>
" Insert thumbnail
nmap \it WBdW:-1read $HOME/Templates/snippets/jira-thumbnail-tag.txt<CR>pjddk
vnoremap \it d:-1read $HOME/Templates/snippets/jira-thumbnail-tag.txt<CR>p
" Insert attachment
nmap \ia WBdE:-1read $HOME/Templates/snippets/jira-attachment-tag.txt<CR>/<++><Enter>"_c4l<C-R>"<ESC>J
" [5]
inoremap \ia <C-R>=system('cat $HOME/Templates/snippets/jira-attachment-tag.txt')<CR><ESC>kJB/<++><Enter>"_c4l
vnoremap \ia d<C-R>=system('cat $HOME/Templates/snippets/jira-attachment-tag.txt')<CR><ESC>kJB/<++><Enter>"_c4l
" Insert result tag
nmap \ip :read $HOME/Templates/snippets/jira-pass.txt<CR>
nmap \if :read $HOME/Templates/snippets/jira-fail.txt<CR>
nmap \is :read $HOME/Templates/snippets/jira-skipped.txt<CR>
" Insert "verified" sentence
nmap \iv :-1read $HOME/Templates/snippets/jira-verified-in.txt<CR>/<++><Enter>"_c4l<C-R>=$CUSTOMER_ENV<ENTER><ESC>n"_c4l<C-R>=$CUSTOMER_VER<ENTER><ESC>
" Inser user
nmap \iu :r ~/Templates/ASSIA/jira-users/

"" CVS
" Insert CVS header
nmap \ih :read $HOME/Templates/snippets/cvs-header.txt<CR>

"" Markdown
" Underline line with =
nmap \i= yypv$r=
" Underline line with -
nmap \i- yypv$r-
" Emphasize it
nmap \i* wbi*<ESC>Ea*<ESC>
vnoremap \i* A*<ESC>`<i*<ESC>`>l
" Emphasize it more
nmap \i** wbi**<ESC>Ea**<ESC>
vnoremap \i** A**<ESC>`<i**<ESC>`>ll
" Make it CODE like
nmap \i` wbi`<ESC>Ea`<ESC>
vnoremap \i` A`<ESC>`<i`<ESC>`>ll

"" Templates
" Let me decide between templates (Insert Template)
nmap \t<TAB> :read $HOME/Templates/ASSIA/<C-Z>

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
" SOURCES
" [1] https://opensource.com/article/18/9/vi-editor-productivity-powerhouse
" [2] https://www.youtube.com/watch?v=XA2WjJbmmoM / https://github.com/changemewtf/no_plugins/
" [3] https://vi.stackexchange.com/questions/17573/function-to-toggle-set-colorcolumn
" [4] https://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
" [5] https://unix.stackexchange.com/questions/61273/while-in-vi-how-can-i-pull-in-insert-paste-the-contents-of-another-file
" [6] https://shapeshed.com/vim-netrw/
