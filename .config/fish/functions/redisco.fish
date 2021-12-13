function redisco
    while pgrep Discord >/dev/null 2>&1
        pkill Discord
        sleep 1
    end

    discord >/dev/null 2>&1 & disown
end
