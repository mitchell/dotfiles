function fish_user_key_bindings
    bind --mode insert jj "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char repaint-mode; end"
    bind --mode insert ,a 'ssh_add; commandline -f repaint'
    bind --mode insert ,p 'nvim +"Telescope git_files"; commandline -f repaint'
    bind --mode insert ,f 'nvim +"Telescope find_files"; commandline -f repaint'
    bind --mode insert ,n 'nvim +Neotree; commandline -f repaint'
    bind --mode insert ,s 'sysz; commandline -f repaint'
    bind --mode insert ,z 'zi; commandline -f repaint'
    bind --mode insert ,t 'fzf-file-widget'
    bind --mode insert ,r 'fzf-history-widget'
    bind --mode insert ,c 'fzf-cd-widget'
end
