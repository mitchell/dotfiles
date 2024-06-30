function toglpulse
    killall slack Discord DiscordCanary

    if test -e ~/.config/pulse/client.conf
        rm -rf ~/.config/pulse/client.conf
        systemctl --user start pipewire.socket
        rebar
    else
        killall easyeffects pavucontrol; or killall -9 easyeffects pavucontrol
        echo "default-server = 192.168.1.155" >~/.config/pulse/client.conf
        systemctl --user stop pipewire.socket pipewire pipewire-pulse wireplumber
        rebar
    end
end
