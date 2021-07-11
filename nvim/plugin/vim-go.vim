let g:go_fmt_command = "goimports"
let g:go_def_mode = 'godef'

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_rename_command = 'gopls'
let g:go_referrers_mode = 'gopls'

au FileType go nmap <C-]> <Plug>(go-def)
au FileType go nmap <Leader>rn <Plug>(go-rename)
au FileType go nmap <Leader>dh <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gr <Plug>(go-referrers)
au FileType go nmap <C-k> <Plug>(go-info)

" work around to coverage works with github.com/agiledragon/gomonkey/
cab GoCoverage GoCoverage -gcflags=all=-l
