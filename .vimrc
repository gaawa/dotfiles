" Plugins:
"Work around https://github.com/vim/vim/issues/3117 < https://github.com/vim/vim/issues/3117#issuecomment-406853295 >
if has('python3') && !has('patch-8.1.201')
  silent! python3 1
endif
execute pathogen#infect()


" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
"  autocmd FileType text setlocal textwidth=78

  augroup END

else

"  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom vim configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" CTRL-V for paste
map <C-V> "+gP
cmap <C-V> <C-R>*

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
" ____        _   _                   ___ ____  _____
"|  _ \ _   _| |_| |__   ___  _ __   |_ _|  _ \| ____|
"| |_) | | | | __| '_ \ / _ \| '_ \   | || | | |  _|
"|  __/| |_| | |_| | | | (_) | | | |  | || |_| | |___
"|_|    \__, |\__|_| |_|\___/|_| |_| |___|____/|_____|
"       |___/


" Settings for python-mode
" git clone --recursive https://github.com/python-mode/python-mode.git
" :helptags .../doc
" help pymode
let g:pymode_python = 'python3'
let g:pymode_options_max_line_length = 150
" preserve wrapping
let g:pymode_options = 0 
hi ColorColumn ctermbg=233
map <Leader>g :call RopeGotoDefinition()<CR>


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
map <buffer> f za
map <buffer> F :call ToggleFold()<CR>
let b:folded = 1
function! ToggleFold()
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

" enable folding for latex
let g:tex_fold_enabled=1


" _          _              ____        _                  _       
"| |    __ _| |_ _____  __ / ___| _ __ (_)_ __  _ __   ___| |_ ___ 
"| |   / _` | __/ _ \ \/ / \___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
"| |__| (_| | ||  __/>  <   ___) | | | | | |_) | |_) |  __/ |_\__ \
"|_____\__,_|\__\___/_/\_\ |____/|_| |_|_| .__/| .__/ \___|\__|___/
"                                        |_|   |_|                 
" Compiling
inoremap $r <Esc>:w<Enter>:!rubber<Space>--pdf<space>main<Enter>
vnoremap $r <Esc>:w<Enter>:!rubber<Space>--pdf<space>main<Enter>
map $r <Esc>:w<Enter>:!rubber<Space>--pdf<space>main<Enter>

" Chapter, Section, Paragraph etc.
autocmd FileType tex inoremap $c \chapter{<++>}<Enter><++>
autocmd FileType tex inoremap $s \section{<++>}<Enter><++>
autocmd FileType tex inoremap $ss \subsection{<++>}<Enter><++>
autocmd FileType tex inoremap $sss \subsubsection{<++>}<Enter><++>
autocmd FileType tex inoremap $p \paragraph{<++>}<Enter><++>
autocmd FileType tex inoremap $sp \subparagraph{<++>}<Enter><++>
" (Temp) Anforderungstabelle
autocmd FileType tex inoremap $atab \begin{center}<Enter><Backspace>\begin{tabularx}{\textwidth}{<Bar>l<Bar>X<Bar>r<Bar>}<Enter>\hline<Enter>ID:<Space>&<Space>Quelle:<Space>&<Space>Priorität:\\<Space>\hline<Enter><Enter>\rowcolor{light-gray}<Enter>\arabic{id}<Space>&<Space>citation<Space>&<Space><++>\\<Space>\hline<Enter><Enter>\multicolumn{3}{<Bar>p{\dimexpr\linewidth-2\tabcolsep}<Bar>}{<Enter><++><Enter><Backspace>}\\<Space>\hline<Enter><Enter>\rowcolor{light-gray}<Enter>\multicolumn{3}{<Bar>p{\dimexpr\linewidth-2\tabcolsep}<Bar>}{<Enter><++><Enter><Backspace>}\\<Space>\hline<Enter>\end{tabularx}<Enter>\end{center}<Enter>\stepcounter{id}<Enter>\stepcounter{id_sub}

" Default Table
autocmd FileType tex inoremap $tab \begin{table}[tbph]<Enter>\begin{tabularx}{\textwidth}{<++>}<Enter>\hline<Enter><++><Enter>\hline<Enter>\end{tabularx}<Enter>\caption{<++>}<Enter>\label{tab:<++>}<Enter>\end{table}
" Normal Figure
autocmd FileType tex inoremap $fig \begin{figure}[tbph]<Enter>\centering<Enter>\includegraphics[width=\textwidth]{pics/<++>}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter>\end{figure}
" Side Ways Figure
autocmd FileType tex inoremap $sfig \begin{sidewaysfigure}<Enter>\includegraphics[width=\textwidth,height=\textheight,keepaspectratio]{pics/<++>}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter>\end{sidewaysfigure}
" Wrap Figure
autocmd FileType tex inoremap $wfig \begin{wrapfigure}{<++>}{<++>}<Enter>\centering<Enter>\includegraphics[width=<++>]{pics/<++>}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter>\end{wrapfigure}
" Code Insertion with lstlisting
autocmd FileType tex inoremap $code \lstset{language=<++>}<Enter>{\tiny\begin{lstlisting}[frame=single]<Enter><++><Enter>\end{lstlisting}}
" Enumeration
autocmd FileType tex inoremap $enum \begin{enumerate}<++><Enter>\item <++><Enter>\end{enumerate}
" Itemization
autocmd FileType tex inoremap $item \begin{itemize}<Enter>\item<++><Enter>\end{itemize}
" SI unit package
autocmd FileType tex inoremap $si \SI[per-mode=fraction]{<++>}{<++>}

" permit to load external vimrc file
set exrc
set secure
