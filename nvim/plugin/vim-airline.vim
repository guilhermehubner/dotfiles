if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme = 'term'
let g:airline_section_b='%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'
let g:airline_symbols.dirty=''
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
