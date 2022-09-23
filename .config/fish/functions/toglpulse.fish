function toglpulse
    killall slack Discord DiscordCanary

    if test -e ~/.config/pulse/client.conf
        rm -rf ~/.config/pulse/client.conf
        ssh -o StrictHostKeyChecking=no venator.lan systemctl --user restart pipewire-pulse
        or ssh -o StrictHostKeyChecking=no venator.lan nssm restart pulseaudio
        rebar
    else
        killall easyeffects pavucontrol; or killall -9 easyeffects pavucontrol
        echo "default-server = venator.lan" > ~/.config/pulse/client.conf
        systemctl --user stop pipewire pipewire-pulse wireplumber
        rebar
    end
end
