function pkm -a command -d 'Shortcuts for pacman and apt'
    set -l distro

    for line in (cat /etc/os-release)
        set -l items (string split --max 1 '=' $line)

        if test $items[1] = ID
            set distro $items[2]
            break
        end
    end

    set -l pkm

    switch $distro
        case arch
            if command -q pikaur
                _pacman_commander pikaur $argv
            else
                _pacman_commander 'sudo pacman' $argv
            end
        case debian
            _apt_commander 'sudo apt' $argv
    end
end

function _pacman_commander -a pkm command
    set -l args $argv[3..]

    switch $command
        case i install
            $pkm --sync $args
        case f fetch
            reflector --latest 50 --fastest 3 --sort age --protocol https --thread 4 |
                sudo tee /etc/pacman.d/mirrorlist
            and $pkm --sync --refresh
        case u update
            $pkm --sync --sysupgrade $args
            and sudo env DIFFPROG='nvim -d' checkservices
        case r remove
            $pkm --remove --recursive --unneeded $args
        case s search
            $pkm $args
        case '*'
            $pkm $command $args
    end
end

function _apt_commander -a pkm command
    set -l args $argv[3..]

    switch $command
        case i install
            $pkm install $args
        case f fetch
            $pkm update
        case u update
            $pkm upgrade $args
            and $pkm autoremove
            and $pkm autoclean
        case r remove
            $pkm purge $args
            and $pkm autoremove
        case s search
            $pkm search $args
        case '*'
            $pkm $command $args
    end
end
