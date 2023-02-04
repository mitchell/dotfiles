call plug#begin('~/.vim/plugged')

" Contains lots of sensible configurations, which I have in turn omitted from this file
Plug 'tpope/vim-sensible'

Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'reedes/vim-pencil', { 'on': ['HardPencil', 'SoftPencil'] }

if !exists('g:vscode')
  Plug 'w0rp/ale'
  Plug 'tpope/vim-fugitive', { 'on': ['G', 'Git'], 'for': 'gitcommit' }
  Plug 'mileszs/ack.vim', { 'on': 'Ack' }

  if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'BurntSushi/ripgrep'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'rcarriga/nvim-notify'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-tree/nvim-web-devicons'

    Plug 'ms-jpq/coq_nvim'
    Plug 'folke/noice.nvim'
    Plug 'ggandor/leap.nvim'
    Plug 'folke/zen-mode.nvim'
    Plug 'folke/twilight.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'ellisonleao/gruvbox.nvim'
    Plug 'nvim-neo-tree/neo-tree.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'simrat39/symbols-outline.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 
         \ 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
         \ }
  else
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/fzf'
    Plug 'mcchrish/nnn.vim'

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
    Plug 'b4b4r07/vim-hcl'
    Plug 'hashivim/vim-terraform'
    Plug 'PProvost/vim-ps1'
    Plug 'vmchale/dhall-vim'
    Plug 'baskerville/vim-sxhkdrc'
    Plug 'keith/swift.vim'
  endif
endif

call plug#end()

set colorcolumn=100
set cursorline
set showmatch
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
set shortmess+=c
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable " Disable folding at startup.


let mapleader = 'j'
inoremap <leader>j <Esc>

let mapleader = ','
nnoremap <leader>f <cmd>ALEFix<cr>

if has('nvim')
  nnoremap <leader>n <cmd>Neotree<cr>
  nnoremap <leader>t <cmd>Telescope<cr>
  nnoremap <leader>p <cmd>Telescope git_files<cr>
  nnoremap <C-p> <cmd>Telescope find_files<cr>
  nnoremap <leader>s <cmd>Telescope treesitter<cr>
  nnoremap <leader>ga <cmd>Telescope grep_string<cr>
  nnoremap <leader>gg <cmd>Telescope lsp_definitions<cr>
  nnoremap <leader>gr <cmd>Telescope lsp_references<cr>
  nnoremap <leader>gi <cmd>Telescope lsp_implementations<cr>
  nnoremap <leader>gd <cmd>Telescope lsp_type_definitions<cr>
  nnoremap <leader>o <cmd>SymbolsOutline<cr>
  nnoremap <leader>z <cmd>ZenMode<cr>
  nnoremap <leader>l <cmd>Twilight<cr>
  nnoremap <leader>c <cmd>COQnow<cr>
else
  nnoremap <leader>n <cmd>NnnPicker<cr>
  nnoremap <leader>p <cmd>FZF<cr>
  nnoremap <leader>a <cmd>Ack<cr>
endif

" Allows you to use // in order to search for the visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" next line is necessary to prevent background rendering bug with kitty term
let &t_ut=''

let g:gruvbox_italic=1
colorscheme gruvbox

highlight Normal ctermbg=None

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

let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 0

let g:OmniSharp_server_stdio = 1

let g:pencil#map#suspend_af = 'K'

let g:nnn#layout = {'left': '~20%'}
let g:nnn#command = 'nnn -eHo'

augroup ft_jsx
  au!
  autocmd BufNewFile,BufRead *.jsx  set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx  set filetype=typescript.tsx
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

