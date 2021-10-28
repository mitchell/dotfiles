function define_aliases -a uname -d 'Defines aliases for commonly used commands'
    alias rcp 'rsync -aP'
    alias dm 'docker-machine'
    alias v 'nvim +FZF'
    alias j 'joplin'
    alias vg 'vagrant'
    alias tf 'terraform'
    alias tocb 'xclip -in -selection clipboard'
    alias fromcb 'xclip -out -selection clipboard'
    alias ssh-rm 'ssh-keygen -f ~/.ssh/known_hosts -R'
    alias wiki 'nvim +VimwikiIndex'
    alias age-p 'age --armor --passphrase'
    alias age-d 'age --decrypt --identity ~/.secrets/id_ed25519'
    alias age-e 'age --armor --recipient (cat ~/.secrets/id_ed25519.pub)'
    alias age-k 'age --decrypt --identity ~/.secrets/id_ed25519 ~/.secrets/age_keys.age'

    switch "$uname"
        case 'Linux'
            alias goland 'command goland'
            alias rider 'command rider'
            alias webstorm 'command webstorm'
            alias sctl 'sudo systemctl'
            alias uctl 'systemctl --user'
            alias bctl 'bluetoothctl'
        case 'Darwin'
            alias goland 'open -a Goland'
            alias rider 'open -a Rider'
            alias webstorm 'open -a Webstorm'

            alias get 'brew install'
            alias getu 'brew upgrade'
            alias gets 'brew search'
            alias getr 'brew uninstall'
    end

    # Linux distro specific aliases below

    set -l distro

    for line in (cat /etc/os-release)
        set -l items (string split --max 1 '=' $line)

        if test $items[1] = 'ID'
            set distro $items[2]
        end
    end

    switch "$distro"
        case 'arch'
            alias get 'pikaur -S'
            alias getu 'pikaur -Syu'
            alias gets 'pikaur'
            alias getr 'pikaur -Rsu'
        case 'debian'
            alias get 'sudo apt update; and sudo apt install'
            alias getu 'sudo apt update; and sudo apt upgrade; and sudo apt autoremove; and sudo apt autoclean'
            alias gets 'sudo apt update; and apt search'

            function getr -d 'Alias for apt uninstall and autoremove'
                sudo apt purge $argv; and sudo apt autoremove
            end
    end
end
