function redisco
    set -l to_kill discord

    if test -n "$argv"
        set to_kill $argv
    end

    pgrep -fia $to_kill
    or return

    read -P 'continue? [Y/n]> ' -l confirm

    if test "$confirm" = 'n'
        return
    end

    pkill -fi $to_kill

    nohup $to_kill &> /dev/null & disown
end
