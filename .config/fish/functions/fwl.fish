function fwl -d 'Function to simplify interacting with firewalld'
    argparse --ignore-unknown \
        p/permanent \
        r/reset \
        'z/zone=' \
        'o/policy=' \
        's/service=' \
        -- $argv

    if set -q _flag_reset
        echo 'Resetting fwl ...'
        _fwl_reset
        return
    end

    if set -q _flag_permanent
        if set -q _fwl_perm
            set -ge _fwl_perm
        else
            set -g _fwl_perm --permanent
        end
    end

    if set -q _flag_zone
        set -g _fwl_mode "--zone=$_flag_z"
    else if set -q _flag_policy
        set -g _fwl_mode "--policy=$_flag_o"
    else if set -q _flag_service
        set -g _fwl_mode "--service=$_flag_s"
    end

    echo fwl_mode={$_fwl_perm} $_fwl_mode

    test -z "$argv"; and return

    switch $argv
        case i info
            set argv --list-all
        case a all
            set argv --list-all-zones
        case on all-on
            set argv --get-active-zones
        case s services
            set argv --get-services
    end

    sudo firewall-cmd {$_fwl_perm} {$_fwl_mode} $argv
end

function _fwl_reset -d 'Reset fwl global variables'
    set -ge _fwl_mode
    set -ge _fwl_perm
    return 0
end
