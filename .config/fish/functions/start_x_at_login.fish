function start_x_at_login
    if status is-login
        if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
            startx -- -keeptty
        end
    end
end
