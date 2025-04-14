function fish_user_key_bindings
    bind --mode insert jj "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char repaint-mode; end"
    bind --mode insert comma,a 'ssh_add; commandline -f repaint'
    bind --mode insert comma,p 'nvim +"Telescope git_files"; commandline -f repaint'
    bind --mode insert comma,f 'nvim +"Telescope find_files"; commandline -f repaint'
    bind --mode insert comma,n 'nvim .; commandline -f repaint'
    bind --mode insert comma,s 'sysz; commandline -f repaint'
    bind --mode insert comma,z 'zi; commandline -f repaint'
    bind --mode insert comma,t 'fzf-file-widget'
    bind --mode insert comma,r 'fzf-history-widget'
    bind --mode insert comma,c 'fzf-cd-widget'
end
