autocmd FileType php setlocal omnifunc=phpactor#Complete

au FileType php nmap <C-]> :call phpactor#GotoDefinition()<CR>
au FileType php nmap <Leader>gr :call phpactor#FindReferences()<CR>
au FileType php nmap <C-k> :call phpactor#Hover()<CR>

au FileType php nmap <Leader>pp :call phpactor#Transform()<CR>
au FileType php nmap <Leader>ga :call phpactor#GenerateAccessor()<CR>
au FileType php nmap <Leader>i :call phpactor#UseAdd()<CR>
au FileType php nmap <Leader>ia :call phpactor#ImportMissingClasses()<CR>
au FileType php nmap <Leader>cm :call phpactor#ContextMenu()<CR>
