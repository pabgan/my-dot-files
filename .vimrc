" For line number to appear in the line selected and all the other ones
" relative to it
set number relativenumber
nmap <C-N><C-N> :set invnumber invrelativenumber<CR>

set showcmd

" Buscar lo que hay debajo del cursor pulsando / dos veces
vnoremap // y/<C-R>"<CR>
