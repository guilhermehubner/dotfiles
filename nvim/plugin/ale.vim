let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1

" Navigate between errors
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Customize lints for languages
let g:ale_linters = {
\  'go': ['gopls', 'golangci-lint'],
\  'python': ['flake8', 'pylint'],
\  'typescript': ['tsserver'],
\  'javascript': ['eslint'],
\}

" Customize fixers for languages
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'javascript.jsx': ['prettier'],
\ 'typescript': ['prettier'],
\ 'html': ['prettier'],
\ 'css': ['prettier'],
\ 'scss': ['prettier'],
\ 'sass': ['prettier'],
\ 'json': ['prettier'],
\ 'md': ['prettier'],
\ 'graphql': ['prettier'],
\ 'python': ['yapf', 'autopep8'],
\}
