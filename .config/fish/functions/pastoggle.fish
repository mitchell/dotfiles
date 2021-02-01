function pastoggle -d 'Toggle the pulseaudio server between pc.lan and laptop.lan'
    set -l host 'pc.lan'
    set -l remote 'laptop.lan'
    set -l config $HOME/.config/pulse/client.conf

    if test (hostname) = 'm-laptop'
        set host 'laptop.lan'
        set remote 'pc.lan'
    end

    if test -f "$config"
        rm $config
        and systemctl --user restart pulseaudio.service
        and ssh $remote "echo \"default-server = $host\" >$config; and systemctl --user restart pulseaudio.service"
    else
        ssh $remote "rm $config; and systemctl --user restart pulseaudio.service"
        and echo "default-server = $remote" >$config
        and systemctl --user restart pulseaudio.service
    end
end
