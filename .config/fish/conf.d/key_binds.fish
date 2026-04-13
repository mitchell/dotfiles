if status is-interactive
    set --global fish_key_bindings fish_vi_key_bindings

    bind --mode insert comma,a 'ssh_add; commandline -f repaint'
    bind --mode insert .,comma 'nvim; commandline -f repaint'
    bind --mode insert comma,z 'zi; commandline -f repaint'
    bind --mode insert comma,f fzf-file-widget
    bind --mode insert comma,r fzf-history-widget
    bind --mode insert comma,c fzf-cd-widget
    bind --mode insert comma,l 'clear; commandline -f repaint'
    bind --mode insert comma,o 'opencode; commandline -f repaint'
end
