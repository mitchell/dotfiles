function toglpulse
    if test -e ~/.config/pulse/client.conf
        rm -rf ~/.config/pulse/client.conf
        ssh venator.lan systemctl --user restart pipewire-pulse; or ssh venator.lan nssm restart pulseaudio
        rebar
    else
        pkill -fi easyeffects; or pkill -fi -9 easyeffects
        echo "default-server = venator.lan" > ~/.config/pulse/client.conf
        systemctl --user stop pipewire pipewire-pulse wireplumber
        rebar
    end
end
