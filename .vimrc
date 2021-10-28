call plug#begin('~/.vim/plugged')

" Contains lots of sensible configurations, which I have in turn omitted from this file
Plug 'tpope/vim-sensible'

Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf'
Plug 'reedes/vim-pencil', { 'on': ['HardPencil', 'SoftPencil'] }

if !exists('g:vscode')
  Plug 'morhetz/gruvbox'
  Plug 'w0rp/ale'
  Plug 'autozimu/LanguageClient-neovim', {
       \ 'branch': 'next',
       \ 'do': 'bash install.sh',
       \ }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  Plug 'tpope/vim-fugitive', { 'on': ['G', 'Git'], 'for': 'gitcommit' }
  Plug 'mileszs/ack.vim', { 'on': 'Ack' }
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'mcchrish/nnn.vim', { 'on': 'NnnPicker' }
  Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

  " Language specific plugins
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'elixir-editors/vim-elixir'
  Plug 'georgewitteman/vim-fish'
  Plug 'fatih/vim-go'
  Plug 'jparise/vim-graphql'
  Plug 'pangloss/vim-javascript'
  Plug 'vim-ruby/vim-ruby'
  Plug 'cespare/vim-toml'
  Plug 'OmniSharp/omnisharp-vim'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'ionide/Ionide-vim'
  Plug 'b4b4r07/vim-hcl'
  Plug 'hashivim/vim-terraform'
  Plug 'PProvost/vim-ps1'
  Plug 'vmchale/dhall-vim'
endif

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
set cmdheight=2
set ignorecase
set smartcase

nnoremap <C-p> :FZF<cr>

let mapleader = 'j'
inoremap <leader>j <Esc>

let mapleader = ','
nmap <leader>g <Plug>(lcn-definition)
nmap <leader>r <Plug>(lcn-references)
nmap <leader>m <Plug>(lcn-menu)
nmap <leader>h <Plug>(lcn-hover)
nmap <leader>c <Plug>(lcn-code-lens-action)
nmap <leader>d <Plug>(lcn-explain-error)
nnoremap <leader>ls :LanguageClientStop<cr>
nnoremap <leader>ll :LanguageClientStart<cr>
nnoremap <leader>n :NnnPicker<cr>
nnoremap <leader>p :FZF<cr>
nnoremap <leader>a :Ack<cr>
nnoremap <leader>we :VimwikiAll2HTML<cr>
nnoremap <leader>wz :VimwikiIndex<cr> :Goyo<cr>
nnoremap <leader>wg :VimwikiGoto
nnoremap <leader>z :Goyo 101x100%<cr>

" Allows you to use // in order to search for the visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" next line is necessary to prevent background rendering bug with kitty term
let &t_ut=''

let g:gruvbox_italic=1
colorscheme gruvbox

highlight Normal ctermbg=None

let g:deoplete#enable_at_startup = 1

let g:LanguageClient_autoStart = 0
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'typescript.tsx': ['typescript-language-server', '--stdio'],
    \ 'elixir': ['~/code/elixir-lsp/elixir-ls/bin/language_server.sh'],
    \ 'eelixir': ['~/code/elixir-lsp/elixir-ls/bin/language_server.sh'],
    \ 'go': ['gopls'],
    \ 'fsharp': ['dotnet', '~/code/fsprojects/fsharp-language-server/bin/FSharpLanguageServer.dll'],
    \ 'dhall': ['dhall-lsp-server'],
    \ 'python': ['/home/m/.asdf/shims/pyls'],
    \ }


let g:ackprg = 'ag --nogroup --nocolor --column --hidden'

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ }

let g:ale_linters = {
    \ 'javascript': ['eslint', 'stylelint'],
    \ 'go': ['golint', 'go vet'],
    \ 'typescript': ['eslint', 'stylelint'],
    \ 'make': ['checkmake'],
    \ 'proto': ['protoc-gen-lint'],
    \ 'dockerfile': ['hadolint'],
    \ 'dart': ['dartanalyzer'],
    \ 'fish': ['fish'],
    \ 'vim': ['vint'],
    \ 'elixir': ['credo'],
    \ 'cs': ['OmniSharp'],
    \ 'terraform': ['tflint'],
    \ 'ruby': ['rubocop'],
    \ 'css': ['stylelint'],
    \ 'sh': ['shellcheck'],
    \ 'python': ['pylint'],
    \ }


let g:ale_fixers = {
    \ 'go': ['goimports', 'remove_trailing_lines', 'trim_whitespace'],
    \ 'graphql': ['prettier'],
    \ 'javascript': ['eslint', 'prettier'],
    \ 'typescript': ['eslint', 'prettier'],
    \ 'css': ['prettier', 'stylelint'],
    \ 'yaml': ['prettier'],
    \ 'json': ['prettier'],
    \ 'dart': ['dartfmt'],
    \ 'html': ['prettier'],
    \ 'make': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'elixir': ['mix_format'],
    \ 'terraform': ['terraform'],
    \ 'ruby': ['rubocop'],
    \ 'python': ['black'],
    \ }

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 0

let g:OmniSharp_server_stdio = 1

let g:pencil#map#suspend_af = 'K'

let g:vimwiki_list = [{'path': expand('~/.wiki/')}]

let g:nnn#layout = {'left': '~20%'}
let g:nnn#command = 'nnn -eHo'

augroup ft_jsx
  au!
  autocmd BufNewFile,BufRead *.jsx  set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx  set filetype=typescript.tsx
augroup END

augroup ft_wiki
  au!
  autocmd FileType vimwiki  set textwidth=70 colorcolumn=70
augroup END

augroup ft_fish
  au!
  autocmd FileType fish  set tabstop=4
augroup END

augroup ft_cs
  au!
  autocmd FileType cs  nmap <leader>g <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs  nmap <leader>r <Plug>(omnisharp_find_usages)
  autocmd FileType cs  nmap <leader>h <Plug>(omnisharp_preview_definition)
  autocmd FileType cs  nmap <leader>c <Plug>(omnisharp_code_actions)
augroup END

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
