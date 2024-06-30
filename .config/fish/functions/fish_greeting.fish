function fish_greeting -d "What's up, fish?"
    set_color $fish_color_autosuggestion

    set uname (uname -nor)

    command -s uptime >/dev/null
    and if test (uname) = Linux
        and set uptime '; ' (uptime --pretty)
    else
        and set uptime '; ' (uptime)
    end

    echo -s $uname $uptime

    set_color normal
end
