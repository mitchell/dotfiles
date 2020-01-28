if &shell =~# 'fish$'
  set shell=sh
endif

filetype plugin on
syntax on
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
set textwidth=100
set noshowmode
set background=dark
set tabstop=2
set shiftwidth=2
set expandtab

set runtimepath+=/usr/local/opt/fzf

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

nnoremap <C-p> :FZF<cr>

let mapleader = 'j'
inoremap <leader>j <Esc>

let mapleader = ','
nnoremap <leader>n :NERDTree<cr>
nnoremap <leader>w <C-w>
nnoremap <leader>p :FZF<cr>
nnoremap <leader>g :ALEGoToDefinition<cr>
nnoremap <leader>r :ALEFindReferences<cr>
nnoremap <leader>d :ALEDetail<cr>
nnoremap <leader>h :ALEHover<cr>
nnoremap <leader>a :Ack<cr>
nnoremap <leader>we :VimwikiAll2HTML<cr>
nmap <leader>wk <Plug>VimwikiIndex

" next line is necessary to prevent background rendering bug with kitty term
let &t_ut=''

let g:gruvbox_italic=1
colorscheme gruvbox

let g:ackprg = 'ag --nogroup --nocolor --column'

let g:lightline = {
\   'colorscheme': 'gruvbox',
\}

let g:ale_linters = {
\   'javascript': ['tsserver', 'eslint', 'stylelint'],
\   'go': ['golint', 'go vet', 'gopls'],
\   'typescript': ['tslint', 'tsserver', 'typecheck', 'stylelint'],
\   'make': ['checkmake'],
\   'proto': ['protoc-gen-lint'],
\   'dockerfile': ['hadolint'],
\   'dart': ['language_server', 'dartanalyzer'],
\   'fish': ['fish'],
\   'vim': ['vint'],
\   'elixir': ['credo', 'elixir-ls'],
\   'cs': ['OmniSharp'],
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
let g:ale_elixir_elixir_ls_release = expand('~/Documents/elixir-ls/bin')

let g:OmniSharp_server_stdio = 1

let g:vimwiki_list = [{'path': '/keybase/private/mjfs/wiki'}]

augroup js_ft
  au!
  autocmd BufNewFile,BufRead *.jsx    set ft=javascript
  autocmd BufNewFile,BufRead *.tsx    set ft=typescript
augroup END
