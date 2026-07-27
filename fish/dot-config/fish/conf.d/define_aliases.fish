if status is-interactive
    alias q exit
    alias cl clear
    alias ls lsd
    alias rcp 'rsync -aP'
    alias ssh-rm 'ssh-keygen -f ~/.ssh/known_hosts -R'
    alias age-p 'age --armor --passphrase'
    alias age-d 'age --decrypt --identity ~/.secrets/id_ed25519'
    alias age-e 'age --armor --recipient (cat ~/.secrets/id_ed25519.pub)'
    alias age-k 'age --decrypt --identity ~/.secrets/id_ed25519 ~/.secrets/age_keys.age'
    alias kp 'keepassxc-cli show -k ~/.secrets/mjfs_keepass_key_file ~/.passwords/mjfs.kdbx'

    switch (uname)
        case Linux
            alias sctl 'sudo systemctl'
            alias uctl 'systemctl --user'
            alias bctl bluetoothctl
            alias fwl 'sudo firewall-cmd'
            alias vv 'virt-viewer'
            alias vi 'virt-install'
            alias vs 'virsh'
            alias vc 'virsh console'
    end
end
