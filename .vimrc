if &shell =~# 'fish$'
  set shell=sh
endif

syntax enable
filetype plugin on
execute pathogen#infect()

set t_Co=256
set colorcolumn=100
set autoindent
set showcmd
set cursorline
set wildmenu
set showmatch
set lazyredraw
set incsearch
set hlsearch
set laststatus=2
set mouse=a
set nowrap
set number
set expandtab
set runtimepath+=/usr/local/opt/fzf
set textwidth=100
set noshowmode
set background=dark

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let mapleader = 'j'
inoremap <leader>j <Esc>

let mapleader = ','
nnoremap <leader>n :NERDTree<cr>
nnoremap <leader>w <C-w>
nnoremap <C-p> :FZF<cr>

let g:gruvbox_italic=1
colorscheme gruvbox

let g:ackprg = 'ag --nogroup --nocolor --column'

let g:lightline = {
\   'colorscheme': 'gruvbox',
\}

let g:ale_linters = {
\   'javascript': ['tsserver'],
\   'css': ['csslint'],
\   'go': ['golint', 'go vet', 'gopls'],
\   'typescript': ['tslint', 'tsserver', 'typecheck'],
\   'make': ['checkmake'],
\   'proto': ['protoc-gen-lint'],
\   'dockerfile': ['hadolint'],
\   'dart': ['language_server', 'dartanalyzer'],
\   'fish': ['fish'],
\   'vim': ['vint'],
\   'elixir': ['credo', 'elixir-ls'],
\}


let g:ale_fixers = {
\   'go': ['goimports', 'remove_trailing_lines', 'trim_whitespace'],
\   'graphql': ['prettier'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'css': ['prettier'],
\   'yaml': ['prettier'],
\   'json': ['prettier'],
\   'dart': ['dartfmt'],
\   'html': ['prettier'],
\   'make': ['remove_trailing_lines', 'trim_whitespace'],
\   'elixir': ['mix_format'],
\}

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 500

