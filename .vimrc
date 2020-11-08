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
set hlsearch
set backspace=indent,eol,start

call plug#begin('~/.vim/plugged')
Plug 'puremourning/vimspector'
call plug#end()

" Key            | Function                                                    | API
" ---------------|-------------------------------------------------------------|-----------------------------------------------
" F5             | When debugging, continue. Otherwise start debugging.        | vimspector#Continue()
" Shift F5       | Stop debugging.                                             | vimspector#Stop()
" Ctrl Shift F5  | Restart debugging with the same configuration.              | vimspector#Restart()
" F6             | Pause debugee.                                              | vimspector#Pause()
" F9             | Toggle line breakpoint on the current line.                 | vimspector#ToggleBreakpoint()
" Shift F9       | Add a function breakpoint for the expression under cursor   | vimspector#AddFunctionBreakpoint( '<cexpr>' )
" F10            | Step Over                                                   | vimspector#StepOver()
" F11            | Step Into                                                   | vimspector#StepInto()
" Shift F11      | Step out of current function scope                          | vimspector#StepOut()
" # https://github.com/puremourning/vimspector#visual-studio--vscode
let g:vimspector_install_gadgets = [ 'vscode-cpptools', 'CodeLLDB' ]
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
let g:vimspector_sidebar_width = 80
let g:vimspector_code_minwidth = 85
let g:vimspector_terminal_minwidth = 75

sign define vimspectorBP text=@          texthl=WarningMsg
sign define vimspectorBPCond text=@?     texthl=WarningMsg
sign define vimspectorBPDisabled text=@! texthl=LineNr
sign define vimspectorPC text=\ >        texthl=MatchParen
sign define vimspectorPCBP text=@>       texthl=MatchParen

function! s:CustomiseUI()
  " Customise the basic UI...
  call win_gotoid( g:vimspector_session_windows.code )
  nunmenu WinBar

  call win_gotoid( g:vimspector_session_windows.watches )
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
