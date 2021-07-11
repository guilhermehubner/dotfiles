let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']
set completeopt-=preview

autocmd BufEnter *.tsx set filetype=typescript
autocmd BufEnter *.rb set filetype=ruby

au FileType javascript,typescript,python,c,cpp nnoremap <C-k> :YcmCompleter GetType<CR>
au FileType ruby nnoremap <C-k> :YcmCompleter GetHover<CR>
au FileType javascript,typescript,python,ruby,c,cpp nnoremap <C-]> :YcmCompleter GoTo<CR>
au FileType javascript,typescript,python,ruby,c,cpp nnoremap <Leader>gr :YcmCompleter GoToReferences<CR>
au FileType javascript,typescript,ruby,c,cpp nnoremap <Leader>rn :YcmCompleter RefactorRename

let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'ruby',
  \     'cmdline': [ $HOME.'/.gem/bin/solargraph', 'stdio' ],
  \     'filetypes': [ 'ruby' ],
  \   },
  \   {
  \     'name': 'yaml',
  \     'cmdline': [ 'yaml-language-server', '--stdio' ],
  \     'filetypes': [ 'yaml' ],
  \   }
  \ ]

