set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Mappings for terminal mode
tnoremap <Esc> <C-\><C-n>
