"Tabs
set softtabstop=4
set shiftwidth=4
set noexpandtab

"Indentation
set cindent

"Line numbers
set number

"Line highlight
set cursorline

"Remove bar above console
set laststatus=0

"Use 24-bit colour
set termguicolors

"Install plugin manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

"Install plugins
call plug#begin()

Plug 'cocopon/iceberg.vim' "Colour scheme
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Completion
Plug 'jackguo380/vim-lsp-cxx-highlight' "Highlighting

call plug#end()

"Fix colour scheme
autocmd ColorScheme * hi Normal guibg=#04040f
autocmd ColorScheme * hi LineNr guibg=#14141f

"Set colour scheme
colorscheme iceberg

"Completion config
set updatetime=300
set shortmess+=c

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')



""""""""""""""""""""
"Plugins:
"If the plugin manager had to be installed, run :PlugStatus to see the plugins and :PlugInstall to install them (only needs to be done once)
"
"Coc:
"(github.com/clangd/coc-clangd)
"Run :CocConfig and save the file (even if it's empty) in order to create it
":CocInstall coc-clangd
":CocCommand clangd.install (open a .cpp file for the warning to appear if this does not work otherwise)
"Add the following (under clangd.path) to :CocConfig to disable linting (warnings and errors):
"    "clangd.disableDiagnostics": true
"Add the following to enable syntax highlighting:
"    "clangd.semanticHighlighting": true
"
"To specify compilation flags, add the following to CMakeLists.txt to generate compile_commands.json:
"set(CMAKE_EXPORT_COMPILE_COMMANDS on)






