"Tabs
set softtabstop=4
set shiftwidth=4
set noexpandtab

"Indentation
set cindent

"Line numbers
set number
set relativenumber

"Line highlight
set cursorline

"Remove bar above console
set laststatus=0

"Use 24-bit colour
set termguicolors

"Scrolling margin
set scrolloff=4

"Disable line wrapping
set nowrap

"Tabline always visible
set showtabline=2

"Tabline labels (from :help setting-tabline)
:set tabline=%!MyTabLine()
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr() " select the highlighting
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let s .= '%' . (i + 1) . 'T' " set the tab page number (for mouse clicks)
    let s .= '%{MyTabLabel(' . (i + 1) . ')} ' " the label is made by MyTabLabel()
  endfor
  let s .= '%#TabLineFill#%T' " after the last tab fill with TabLineFill and reset tab page nr
  if tabpagenr('$') > 1 " right-align the label to close the current tab page
    let s .= '%=%#TabLine#%999Xclose'
  endif
  return s
endfunction
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return a:n . '|' . fnamemodify(bufname(buflist[winnr - 1]), ':t')
endfunction

"Install plugin manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

"Install plugins
call plug#begin()

"Plug 'cocopon/iceberg.vim' "Colour scheme
Plug 'morhetz/gruvbox' "Colour scheme
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Completion
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "Highlighting

call plug#end()

"Colour scheme
"colorscheme iceberg
"autocmd ColorScheme * hi Normal guibg=#04040f
"autocmd ColorScheme * hi LineNr guibg=#14141f
"autocmd ColorScheme * hi LineNr guifg=#8de0c2

"Colour scheme
autocmd ColorScheme * hi Normal guibg=#000000
colorscheme gruvbox

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


"Highlighting config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "cpp",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

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
"
"The whole :CocConfig should look like this (clangd.path might not be needed if clang is in $PATH):
" {
"  "clangd.path": "/home/me/.config/coc/extensions/coc-clangd-data/install/12.0.1/clangd_12.0.1/bin/clangd",
"  "clangd.disableDiagnostics": true,
"}
"To specify compilation flags, add the following to CMakeLists.txt to generate compile_commands.json:
"set(CMAKE_EXPORT_COMPILE_COMMANDS on)






