call plug#begin('~/.vim/plugged')

" Contains lots of sensible configurations, which I have in turn omitted from this file
Plug 'tpope/vim-sensible'

" Always enabled, non-language plugins
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

" Conditionally loaded plugins
Plug 'tpope/vim-fugitive', { 'on': ['G', 'Git'], 'for': 'gitcommit' }
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'reedes/vim-pencil', { 'on': ['HardPencil', 'SoftPencil'] }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'junegunn/fzf', { 'on': 'FZF' }

" Language specific plugins
Plug 'dart-lang/dart-vim-plugin'
Plug 'elixir-editors/vim-elixir'
Plug 'dag/vim-fish'
Plug 'fatih/vim-go'
Plug 'jparise/vim-graphql'
Plug 'pangloss/vim-javascript'
Plug 'vim-ruby/vim-ruby'
Plug 'cespare/vim-toml'
Plug 'OmniSharp/omnisharp-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'fsharp/vim-fsharp', { 'do': './make' }
Plug 'b4b4r07/vim-hcl'
Plug 'hashivim/vim-terraform'
Plug 'PProvost/vim-ps1'
Plug 'vmchale/dhall-vim'

call plug#end()

set colorcolumn=100
set cursorline
set showmatch
set lazyredraw
set hlsearch
set mouse=a
set number
set noshowmode
set background=dark
set nowrap
set tabstop=2
set shiftwidth=0
set expandtab
set textwidth=100

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
nnoremap <leader>z :Goyo 101x100%<cr>
nnoremap <leader>Z :Goyo<cr>

" Allows you to use // in order to search for the visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" next line is necessary to prevent background rendering bug with kitty term
let &t_ut=''

let g:gruvbox_italic=1
colorscheme gruvbox

highlight Normal ctermbg=None

let g:ackprg = 'ag --nogroup --nocolor --column'

let g:lightline = {
\   'colorscheme': 'gruvbox',
\}

let g:ale_linters = {
\   'javascript': ['tsserver', 'eslint', 'stylelint'],
\   'go': ['golint', 'go vet', 'gopls'],
\   'typescript': ['eslint', 'tsserver', 'typecheck', 'stylelint'],
\   'make': ['checkmake'],
\   'proto': ['protoc-gen-lint'],
\   'dockerfile': ['hadolint'],
\   'dart': ['language_server', 'dartanalyzer'],
\   'fish': ['fish'],
\   'vim': ['vint'],
\   'elixir': ['credo', 'elixir-ls'],
\   'cs': ['OmniSharp'],
\   'terraform': ['terraform', 'tflint'],
\   'ruby': ['rubocop', 'solargraph'],
\   'css': ['stylelint'],
\}


let g:ale_fixers = {
\   'go': ['goimports', 'remove_trailing_lines', 'trim_whitespace'],
\   'graphql': ['prettier'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'css': ['prettier', 'stylelint'],
\   'yaml': ['prettier'],
\   'json': ['prettier'],
\   'dart': ['dartfmt'],
\   'html': ['prettier'],
\   'make': ['remove_trailing_lines', 'trim_whitespace'],
\   'elixir': ['mix_format'],
\   'terraform': ['terraform'],
\   'ruby': ['rubocop'],
\}

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 100
let g:ale_elixir_elixir_ls_release = expand('~/code/elixir-lsp/elixir-ls/bin')

let g:OmniSharp_server_stdio = 1

let g:pencil#map#suspend_af = 'K'

let g:vimwiki_list = [{'path': '/keybase/private/mjfs/wiki'}]

augroup js_ft
  au!
  autocmd BufNewFile,BufRead *.jsx	set ft=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx	set ft=typescript.tsx
augroup END

augroup wiki_ft
  au!
  autocmd BufNewFile,BufRead *.wiki	set tw=70 cc=70
augroup END

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
