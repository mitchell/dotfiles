function btre -a device -d 'Reconnect to a known bluetooth device'
    set -l devices 00:1B:66:E3:07:3A CC:98:8B:3E:6B:9D

    bluetoothctl power on

    for device in $devices
        bluetoothctl remove $device
    end

    nohup bluetoothctl scan on >/dev/null &

    for device in $devices
        bluetoothctl pair $device
        sleep 1
        bluetoothctl trust $device
        bluetoothctl connect $device
    end

    pkill bluetoothctl
end
