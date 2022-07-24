" Plugins:
"Work around https://github.com/vim/vim/issues/3117 < https://github.com/vim/vim/issues/3117#issuecomment-406853295 >
""if has('python3') && !has('patch-8.1.201')
""  silent! python3 1
""endif
execute pathogen#infect()
source $VIMRUNTIME/defaults.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom vim configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" Disable Mouse in Insert mode
set mouse=nv

" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Leader Key
let mapleader = "!"

" for powerline 
let g:airline_powerline_fonts = 1
let g:airline_symbols = {}
let g:airline_symbols.linenr = 'Ξ'
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
" ignore case for searching
set ignorecase

" enable hybrid line number
set number relativenumber

" copy paste to windows style key
" CTRL-X for cut
vnoremap <C-X> "+x
" CTRL-C for copy
vnoremap <C-C> "+y
" CTRL-Shift-V for paste
" map <C-V> "+gP
" cmap <C-V> <C-R>*

" enable syntax highlighting
syntax on

" Set mapping delay
set timeoutlen=300


" Navigating with guides
inoremap $<Tab> <Esc>/<++><Enter>"_c4l
vnoremap $<Tab> <Esc>/<++><Enter>"_c4l
map $<Tab> <Esc>/<++><Enter>"_c4l
inoremap $gui <++>

" Indentation setting
set expandtab
set shiftwidth=4
set softtabstop=4

" easier moving of code blocks
vnoremap > >gv 
vnoremap < <gv

" show white space
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O ....
" set t_Co=256
" color wombat256mod

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" enable cross hair
hi CursorLine cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
" fix meta-keys
"set termencoding=latin1
"let c='a'
"while c <= 'z'
  "exec "set <M-".toupper(c).">=\e".c
  "exec "imap \e".c." <M-".toupper(c).">"
  "let c = nr2char(1+char2nr(c))
"endw
"for i in range(65,90) + range(97,122)
"  let c = nr2char(i)
"  exec "map \e".c." <M-".c.">"
  "exec "map! \e".c." <M-".c.">"
"endfor
" Latex Compiling on keypress

" Remap auto-parenthesis plugin key maps
" git clone git://github.com/jiangmiao/auto-pairs.git ~/.vim/bundle/auto-pairs
" Escape auto parenthesis
let g:AutoPairsShortcutToggle = '<Leader>p'
let g:AutoPairsShortcutFastWrap = '<C-e>'
let g:AutoPairsShortcutJump = '<C-n>'
let g:AutoPairsShortcutBackInsert = '<C-b>'
inoremap $<Space> <Esc>la

set nocompatible
filetype plugin on
" Default .tex files to latex file
let g:tex_flavor = "latex"

" set interpretation to markdown for calcurse notes:
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown

" YCM settings:
let g:ycm_filetype_blacklist = {'tex': 1 }

set sessionoptions=buffers,tabpages,sesdir
"
" Settings for ctrlp
" git clone https://github.com/ctrlpvim/ctrlp.vim.git
" http://ctrlpvim.github.io/ctrlp.vim/#installation
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
" set nofoldenable
" Python folding with SimpylFold
" git clone https://github.com/tmhedberg/SimpylFold.git
" help fold-commands
set foldlevel=99
hi Folded ctermbg=237
map <Leader>f za
map <Leader>F :call ToggleFold()<CR>
function! ToggleFold()
    let b:folded = get(b:, 'folded', 0)
    if( b:folded == 0 )
        exec "normal! zM"
        let b:folded = 1
    else
        exec "normal! zR"
        let b:folded = 0
    endif
endfunction

" Tagbar Settings
" git clone https://github.com/majutsushi/tagbar.git
" :helptags .../doc
nmap <Leader>t :TagbarToggle<CR>


" permit to load external vimrc file
set exrc
set secure
