function vban -d 'Default VBAN startup script'
    tmux new -s vban vban_emitter --ipaddress=192.168.1.155 --port=6980 --streamname=Main --backend=pulseaudio --device=alsa_output.pci-0000_05_00.6.analog-stereo.monitor
    or tmux attach-session -t vban
end
