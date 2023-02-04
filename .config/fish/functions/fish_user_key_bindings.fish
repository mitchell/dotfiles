function fish_user_key_bindings
    bind --mode insert jj "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char repaint-mode; end"
    bind --mode insert ,a 'ssh_add; commandline -f repaint'
    bind --mode insert ,j 'joplin; commandline -f repaint'
    bind --mode insert ,p 'nvim +"Telescope git_files"; commandline -f repaint'
    bind --mode insert ,f 'nvim +"Telescope find_files"; commandline -f repaint'
    bind --mode insert ,n 'n; commandline -f repaint'
    bind --mode insert ,s 'sysz; commandline -f repaint'
end
