" Plugins:
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
" permit to load external vimrc file
set exrc

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
inoremap ;<Tab> <Esc>/<++><Enter>"_c4l
vnoremap ;<Tab> <Esc>/<++><Enter>"_c4l
map ;<Tab> <Esc>/<++><Enter>"_c4l
inoremap ;gui <++>

" Indentation setting
set expandtab
set shiftwidth=2
set softtabstop=2

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
" Escape auto parenthesis
let g:AutoPairsShortcutToggle = '<C-p>'
let g:AutoPairsShortcutFastWrap = '<C-e>'
let g:AutoPairsShortcutJump = '<C-n>'
let g:AutoPairsShortcutBackInsert = '<C-b>'
inoremap ;<Space> <Esc>la

set nocompatible
filetype plugin on
" Default .tex files to latex file
let g:tex_flavor = "latex"

" _          _              ____        _                  _       
"| |    __ _| |_ _____  __ / ___| _ __ (_)_ __  _ __   ___| |_ ___ 
"| |   / _` | __/ _ \ \/ / \___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
"| |__| (_| | ||  __/>  <   ___) | | | | | |_) | |_) |  __/ |_\__ \
"|_____\__,_|\__\___/_/\_\ |____/|_| |_|_| .__/| .__/ \___|\__|___/
"                                        |_|   |_|                 
" Chapter, Section, Paragraph etc.
autocmd FileType tex inoremap ;c \chapter{<++>}<Enter><++>
autocmd FileType tex inoremap ;s \section{<++>}<Enter><++>
autocmd FileType tex inoremap ;ss \subsection{<++>}<Enter><++>
autocmd FileType tex inoremap ;sss \subsubsection{<++>}<Enter><++>
autocmd FileType tex inoremap ;p \paragraph{<++>}<Enter><++>
autocmd FileType tex inoremap ;sp \subparagraph{<++>}<Enter><++>
" (Temp) Anforderungstabelle
autocmd FileType tex inoremap ;atab \begin{center}<Enter><Backspace>\begin{tabularx}{\textwidth}{<Bar>l<Bar>X<Bar>r<Bar>}<Enter>\hline<Enter>ID:<Space>&<Space>Quelle:<Space>&<Space>Priorität:\\<Space>\hline<Enter><Enter>\rowcolor{light-gray}<Enter>\arabic{id}<Space>&<Space>citation<Space>&<Space><++>\\<Space>\hline<Enter><Enter>\multicolumn{3}{<Bar>p{\dimexpr\linewidth-2\tabcolsep}<Bar>}{<Enter><++><Enter><Backspace>}\\<Space>\hline<Enter><Enter>\rowcolor{light-gray}<Enter>\multicolumn{3}{<Bar>p{\dimexpr\linewidth-2\tabcolsep}<Bar>}{<Enter><++><Enter><Backspace>}\\<Space>\hline<Enter>\end{tabularx}<Enter>\end{center}<Enter>\stepcounter{id}<Enter>\stepcounter{id_sub}

" Default Table
autocmd FileType tex inoremap ;tab \begin{table}[tbph]<Enter>\begin{tabularx}{\textwidth}{<++>}<Enter>\hline<Enter><++><Enter>\hline<Enter>\end{tabularx}<Enter>\caption{<++>}<Enter>\label{tab:<++>}<Enter>\end{table}

" Normal Figure
autocmd FileType tex inoremap ;fig \begin{figure}[tbph]<Enter>\centering<Enter>\includegraphics[width=\textwidth]{pics/<++>}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter>\end{figure}
" Side Ways Figure
autocmd FileType tex inoremap ;sfig \begin{sidewaysfigure}<Enter>\includegraphics[width=\textwidth,height=\textheight,keepaspectratio]{pics/<++>}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter>\end{sidewaysfigure}
" Wrap Figure
autocmd FileType tex inoremap ;wfig \begin{wrapfigure}{<++>}{<++>}<Enter>\centering<Enter>\includegraphics[width=<++>]{pics/<++>}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter>\end{wrapfigure}
" Code Insertion with lstlisting
autocmd FileType tex inoremap ;code \lstset{language=<++>}<Enter>{\tiny\begin{lstlisting}[frame=single]<Enter><++><Enter>\end{lstlisting}}

" Enumeration
autocmd FileType tex inoremap ;enum \begin{enumerate}<++><Enter>\item <++><Enter>\end{enumerate}
" Itemization
autocmd FileType tex inoremap ;item \begin{itemize}<Enter>\item<++><Enter>\end{itemize}


set secure
