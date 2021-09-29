function btre -a device -d 'Reconnect to a known bluetooth device'
    set -l devices CC:98:8B:3E:6B:9D 00:1B:66:E3:07:3A
    set -l index 1

    if test -n "$device"
        set index $device
    end

    bluetoothctl power on

    bluetoothctl remove $devices[$index]

    nohup bluetoothctl scan on >/dev/null &
    sleep 2

    bluetoothctl pair $devices[$index]
    bluetoothctl trust $devices[$index]
    bluetoothctl connect $devices[$index]

    pkill bluetoothctl
end
