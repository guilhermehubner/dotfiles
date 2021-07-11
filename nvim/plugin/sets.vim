" increase max memory to show syntax highlighting for large files
set maxmempattern=20000

" No spellcheck
set nospell

" No folding
set nofoldenable

"No hidden
set nohidden

" Auto reload if file saved externally
set autoread

" Automatically highlight matching braces/brackets/etc.
set showmatch
set matchtime=2 " match only 2 times

" General improvements
set lazyredraw
set laststatus=2
set noshowmode
set number

" Split configurations
set splitright
set splitbelow
set inccommand=nosplit

" Connect clipboard from OS to VIM clipboard
set clipboard=unnamedplus

" Allow mouse usage
set mouse=a

" No backup (annoying swp files)
set noswapfile
set nobackup
set nowb

" Setting history and undo size to a higher value
set history=1000
set undolevels=1000

" Vim and nvim compliance
set viminfo='10,\"100,:20,%,n~/.nviminfo

" Set default tab to 4 spaces
set sts=4 ts=4 sw=4 expandtab smarttab ai smartindent

" Padding on j/k at least 5 lines from the screen end
set so=5
