function jmpv -d 'Open jellyfin-mpv-shim in a tmux session of its own'
    tmux new-session -s jmpv jellyfin-mpv-shim
    or tmux attach-session -t jmpv
end
