let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>n :call vimspector#StepOver()<CR>
nmap <leader>m :call vimspector#StepInto()<CR>
nmap <leader>b :call vimspector#ToggleBreakpoint()<CR>
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>ds :call vimspector#Stop()<CR>
