function define_aliases -a uname -d 'Defines aliases for commonly used commands'
    alias q exit
    alias cl clear
    alias rcp 'rsync -aP'
    alias vg vagrant
    alias tf terraform
    alias gco 'gcloud compute'
    alias tocb 'xclip -in -selection clipboard'
    alias fromcb 'xclip -out -selection clipboard'
    alias ssh-rm 'ssh-keygen -f ~/.ssh/known_hosts -R'
    alias age-p 'age --armor --passphrase'
    alias age-d 'age --decrypt --identity ~/.secrets/id_ed25519'
    alias age-e 'age --armor --recipient (cat ~/.secrets/id_ed25519.pub)'
    alias age-k 'age --decrypt --identity ~/.secrets/id_ed25519 ~/.secrets/age_keys.age'
    alias bb 'bun --bun'
    alias pn pnpm
    alias nv 'neovide --fork; and clear'
    alias hx helix
    alias ai aichat

    switch "$uname"
        case Linux
            alias goland 'command goland'
            alias rider 'command rider'
            alias webstorm 'command webstorm'
            alias sctl 'sudo systemctl'
            alias uctl 'systemctl --user'
            alias bctl bluetoothctl
        case Darwin
            alias goland 'open -a Goland'
            alias rider 'open -a Rider'
            alias webstorm 'open -a Webstorm'

            alias pkm 'brew search'
            alias pkmi 'brew install'
            alias pkmf 'brew update'
            alias pkmu 'brew upgrade'
            alias pkmr 'brew uninstall'
    end

    # Linux distro specific aliases below

    #set -l distro

    #for line in (cat /etc/os-release)
    #    set -l items (string split --max 1 '=' $line)

    #    if test $items[1] = 'ID'
    #        set distro $items[2]
    #    end
    #end

    #switch "$distro"
    #    case 'arch'
    #    case 'debian'
    #end
end
