" =============================================================================
" Neovim Configuration File
" =============================================================================

" -----------------------------------------------------------------------------
" UI Settings
" -----------------------------------------------------------------------------
set colorcolumn=100
set cursorline
set showmatch
set number
set noshowmode
set background=dark
set nowrap
set cmdheight=2
set shortmess+=c
set termguicolors

" Folding settings
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable " Disable folding at startup.

" -----------------------------------------------------------------------------
" Editor Behavior
" -----------------------------------------------------------------------------
set mouse=a
set mousemodel=extend
set tabstop=2
set shiftwidth=0
set expandtab
set textwidth=100

" -----------------------------------------------------------------------------
" Search Settings
" -----------------------------------------------------------------------------
set hlsearch
set ignorecase
set smartcase

" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------
" Quick escape from insert mode
inoremap jj <Esc>

" Terminal escape
tnoremap <Esc> <C-\><C-n>

" Search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" ALE (Linting/Fixing)
nnoremap <leader>f <cmd>ALEFix<cr>
nnoremap <leader>a <cmd>ALEToggle<cr>

" File Navigation
nnoremap <leader>nn <cmd>Neotree toggle show git_status<cr>
nnoremap <leader>np <cmd>Neotree float reveal_force_cwd<cr>
nnoremap <leader>t <cmd>Telescope<cr>
nnoremap <leader>p <cmd>Telescope git_files<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>s <cmd>Telescope treesitter<cr>
nnoremap <leader>ga <cmd>Telescope grep_string<cr>

" LSP Integration
nnoremap <leader>gg <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>gr <cmd>Telescope lsp_references<cr>
nnoremap <leader>gi <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>gd <cmd>Telescope lsp_type_definitions<cr>

" UI Toggles
nnoremap <leader>o <cmd>SymbolsOutline<cr>
nnoremap <leader>z <cmd>ZenMode<cr>
nnoremap <leader>l <cmd>Twilight<cr>

" Buffer Management
nnoremap <silent><leader>j <cmd>BufferLinePick<cr>
nnoremap <silent><leader>J <cmd>BufferLinePickClose<cr>

" Code Companion
nnoremap <silent><leader>c <cmd>CodeCompanionChat<cr>

" -----------------------------------------------------------------------------
" Neovide GUI Settings
" -----------------------------------------------------------------------------
let g:neovide_scale_factor = 0.75
let g:neovide_transparency = 0.7
let g:neovide_cursor_vfx_mode = 'sonicboom'

" -----------------------------------------------------------------------------
" Plugin Configurations
" -----------------------------------------------------------------------------
" ALE (Linting)
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 0

" Pencil
let g:pencil#map#suspend_af = 'K'

" ALE Linters Configuration
let g:ale_linters = {
    \ 'javascript': ['eslint', 'stylelint', 'biome'],
    \ 'typescript': ['eslint', 'stylelint', 'biome'],
    \ 'javascriptreact': ['eslint', 'stylelint', 'biome'],
    \ 'typescriptreact': ['eslint', 'stylelint', 'biome'],
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

" ALE Fixers Configuration
let g:ale_fixers = {
    \ 'go': ['goimports', 'remove_trailing_lines', 'trim_whitespace'],
    \ 'graphql': ['prettier'],
    \ 'javascript': ['prettier', 'biome'],
    \ 'typescript': ['prettier', 'biome'],
    \ 'javascriptreact': ['prettier', 'biome'],
    \ 'typescriptreact': ['prettier', 'biome'],
    \ 'vue': ['prettier'],
    \ 'css': ['prettier'],
    \ 'yaml': ['prettier', 'biome'],
    \ 'json': ['prettier', 'biome'],
    \ 'dart': ['dartfmt'],
    \ 'html': ['prettier', 'biome'],
    \ 'markdown': ['prettier', 'biome'],
    \ 'make': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'elixir': ['mix_format'],
    \ 'terraform': ['terraform'],
    \ 'ruby': ['rubocop'],
    \ 'python': ['black'],
    \ 'lua': ['stylua'],
    \ }

" -----------------------------------------------------------------------------
" Autocommands
" -----------------------------------------------------------------------------
" Fish filetype settings
augroup ft_fish
  au!
  autocmd FileType fish set tabstop=4
augroup END

" Terminal settings
augroup term
  au!
  autocmd TermOpen * set nonumber
augroup END

