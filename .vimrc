call plug#begin('~/.vim/plugged')

" Contains lots of sensible configurations, which I have in turn omitted from this file
Plug 'tpope/vim-sensible'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'

Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'reedes/vim-pencil', { 'on': ['HardPencil', 'SoftPencil'] }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'junegunn/fzf', { 'on': 'FZF' }

Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'fatih/vim-go', { 'for': ['go', 'gomod'] }
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['typescript', 'javascript'] }
Plug 'fsharp/vim-fsharp', { 'for': 'fsharp' }
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }

call plug#end()

set colorcolumn=100
set cursorline
set showmatch
set lazyredraw
set hlsearch
set mouse=a
set number
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

nnoremap <C-p> :FZF<cr>

let mapleader = 'j'
inoremap <leader>j <Esc>

let mapleader = ','
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>p :FZF<cr>
nnoremap <leader>g :ALEGoToDefinition<cr>
nnoremap <leader>r :ALEFindReferences<cr>
nnoremap <leader>d :ALEDetail<cr>
nnoremap <leader>h :ALEHover<cr>
nnoremap <leader>a :Ack<cr>
nnoremap <leader>we :VimwikiAll2HTML<cr>
nnoremap <leader>z :Goyo<cr>
nnoremap <leader>Z :Goyo 110x100%<cr>

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
\   'terraform': ['terraform', 'tflint'],
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
\   'terraform': ['terraform'],
\}

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 100
let g:ale_elixir_elixir_ls_release = expand('~/Documents/elixir-ls/bin')

let g:OmniSharp_server_stdio = 1

let g:vimwiki_list = [{'path': '/keybase/private/mjfs/wiki'}]

augroup js_ft
  au!
  autocmd BufNewFile,BufRead *.jsx    set ft=javascript
  autocmd BufNewFile,BufRead *.tsx    set ft=typescript
augroup END
