syntax on

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,default,sjis,euc-jp,latin1
set noswapfile
set nobackup
set noundofile
set nowrap
set noerrorbells
set noshowmode
set nocompatible

set number

call plug#begin('~/.vim/plugged')
Plug 'puremourning/vimspector'
call plug#end()

let g:vimspector_install_gadgets = [ 'vscode-cpptools', 'CodeLLDB' ]
" func! CustomiseUI()
"   call win_gotoid( g:vimspector_session_windows.code )
"   " Clear the existing WinBar created by Vimspector
"   nunmenu WinBar
"   " " Cretae our own WinBar
"   " nnoremenu WinBar.Kill :call vimspector#Stop()<CR>
"   " nnoremenu WinBar.Continue :call vimspector#Continue()<CR>
"   " nnoremenu WinBar.Pause :call vimspector#Pause()<CR>
"   " nnoremenu WinBar.Step\ Over  :call vimspector#StepOver()<CR>
"   " nnoremenu WinBar.Step\ In :call vimspector#StepInto()<CR>
"   " nnoremenu WinBar.Step\ Out :call vimspector#StepOut()<CR>
"   " nnoremenu WinBar.Restart :call vimspector#Restart()<CR>
"   " nnoremenu WinBar.Exit :call vimspector#Reset()<CR>
" endfunction
" 
" augroup MyVimspectorUICustomistaion
"   autocmd!
"   autocmd User VimspectorUICreated call s:CustomiseUI()
" augroup END

let g:vimspector_sidebar_width = 80
let g:vimspector_code_minwidth = 85
let g:vimspector_terminal_minwidth = 75

function! s:CustomiseUI()
  " Customise the basic UI...
  nunmenu WinBar

  " Close the output window
  call win_gotoid( g:vimspector_session_windows.output )
  q
endfunction

function s:SetUpTerminal()
  " Customise the terminal window size/position
  " For some reasons terminal buffers in Neovim have line numbers
  call win_gotoid( g:vimspector_session_windows.terminal )
  set norelativenumber nonumber
endfunction

augroup MyVimspectorUICustomistaion
  autocmd!
  autocmd User VimspectorUICreated call s:CustomiseUI()
  autocmd User VimspectorTerminalOpened call s:SetUpTerminal()
augroup END

colorscheme koehler
hi Normal ctermbg=NONE guibg=NONE
