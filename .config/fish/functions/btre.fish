function btre -a device -d 'Reconnect to a known bluetooth device'
    set -l devices CC:98:8B:3E:6B:9D 00:1B:66:E3:07:3A
    set -l index 1

    switch device
        case sony
            set index 1
            return
        case senn
            set index 2
            return
        case '*'
            test -n "$device"; and set index $device
    end

    bluetoothctl power on

    and bluetoothctl remove $devices[$index]

    echo \n"--- Press enter to continue ---"\n
    bluetoothctl scan on &
    read -P ''

    bluetoothctl pair $devices[$index]
    or return $status
    read -p 'echo \n"--- Press enter to continue ---"\n'

    bluetoothctl trust $devices[$index]
    and bluetoothctl connect $devices[$index]
    or return $status
    read -p 'echo \n"--- Press enter to continue ---"\n'

    kill %1
end
