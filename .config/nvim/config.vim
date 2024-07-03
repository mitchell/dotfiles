set colorcolumn=100
set cursorline
set showmatch
set hlsearch
set mouse=a
set mousemodel=extend
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

inoremap jj <Esc>

let mapleader = ','
nnoremap <leader>f <cmd>ALEFix<cr>
nnoremap <leader>a <cmd>ALEToggle<cr>
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

tnoremap <Esc> <C-\><C-n>

" Allows you to use // in order to search for the visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

colorscheme gruvbox

let g:neovide_scale_factor = 0.7

let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 0

let g:pencil#map#suspend_af = 'K'

let g:ale_linters = {
    \ 'javascript': ['eslint', 'stylelint'],
    \ 'typescript': ['eslint', 'stylelint'],
    \ 'javascriptreact': ['eslint', 'stylelint'],
    \ 'typescriptreact': ['eslint', 'stylelint'],
    \ 'go': ['golint', 'go vet'],
    \ 'vue': ['eslint', 'stylelint'],
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
    \ 'javascript': ['prettier'],
    \ 'typescript': ['prettier'],
    \ 'javascriptreact': ['prettier'],
    \ 'typescriptreact': ['prettier'],
    \ 'vue': ['prettier'],
    \ 'css': ['prettier'],
    \ 'yaml': ['prettier'],
    \ 'json': ['prettier'],
    \ 'dart': ['dartfmt'],
    \ 'html': ['prettier'],
    \ 'markdown': ['prettier'],
    \ 'make': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'elixir': ['mix_format'],
    \ 'terraform': ['terraform'],
    \ 'ruby': ['rubocop'],
    \ 'python': ['black'],
    \ 'lua': ['stylua'],
    \ }

augroup ft_fish
  au!
  autocmd FileType fish set tabstop=4
augroup END

augroup term
  au!
  autocmd TermOpen * set nonumber
augroup END
