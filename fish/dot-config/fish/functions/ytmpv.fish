function ytmpv -d 'A script to help queue youtube videos on MPV'
    set -l queue ~/.ytmpv_queue
    set -l downloads ~/.ytmpv_downloads/

    if command --query prime-run
        set --function --export __NV_PRIME_RENDER_OFFLOAD 1
        set --function --export __GLX_VENDOR_LIBRARY_NAME nvidia
    end


    if not test -f $queue
        touch $queue
    end

    if not test -d $downloads
        mkdir $downloads
    end

    while read -P 'url(s)/command (play)> ' -l video
        switch $video
            case cl clear
                clear
            case c copy
                set -l video (fromcb)
                string split ' ' $video >>$queue
            case d destroy
                rm -r $queue
                break
            case dd destroy-downloads
                rm -r $downloads
                break
            case e edit
                $EDITOR $queue
            case f fg
                tmux attach -t ytmpv
            case h help
                functions ytmpv
            case l list
                cat $queue
            case q quit
                return
            case dl download
                tmux attach -t ytmpv
                tmux new-session -s ytmpv -- \
                    yt-dlp \
                    --format-sort 'height:1080' \
                    --batch-file $queue \
                    --path $downloads
                break
            case pd play-downloads
                tmux attach -t ytmpv
                tmux new-session -s ytmpv -- \
                    mpv \
                    --ytdl \
                    --save-position-on-quit \
                    $downloads
                break
            case p play
                tmux attach -t ytmpv
                tmux new-session -s ytmpv -- \
                    mpv \
                    --ytdl \
                    --save-position-on-quit \
                    --playlist=$queue
                break
            case pl play-login
                read -P 'username> ' -l username
                read -P 'password> ' -s -l password

                tmux attach -t ytmpv
                tmux new-session -s ytmpv -- \
                    mpv \
                    --ytdl \
                    --ytdl-raw-options=username=$username,password=$password \
                    --save-position-on-quit \
                    --playlist=$queue

                break
            case s stream
                tmux attach -t ytmpv
                tmux new-session -s ytmpv -- \
                    streamlink \
                    --player mpv \
                    (cat $queue) \
                    best
                break
            case dwl destroy-watch-later
                rm -r ~/.local/state/mpv/watch_later/
                break
            case '*'
                if test -z "$video"
                    tmux attach -t ytmpv
                    tmux new-session -s ytmpv -- \
                        mpv \
                        --ytdl \
                        --save-position-on-quit \
                        --playlist=$queue
                    break
                end

                string split ' ' $video >>$queue
        end
    end

    ytmpv
end
