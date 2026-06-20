function jmpv -d 'Open jellyfin-mpv-shim in a tmux session of its own'
    if command --query prime-run
        set --function --export __NV_PRIME_RENDER_OFFLOAD 1
        set --function --export __GLX_VENDOR_LIBRARY_NAME nvidia
    end

    tmux new-session -s jmpv jellyfin-mpv-shim
    or tmux attach-session -t jmpv
end
