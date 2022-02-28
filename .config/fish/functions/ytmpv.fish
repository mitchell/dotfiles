function ytmpv -d 'A script to help queue youtube videos on MPV'
    if not set -Uq _ytmpv_video_queue
        set -U _ytmpv_video_queue
    end

    while read -P 'url(s)/command (play)> ' -l video
        switch $video
            case cl clear
                clear
            case c copy
                set -l video (fromcb)
                set -U _ytmpv_video_queue $_ytmpv_video_queue (string split ' ' $video)
            case d destroy
                set -Ue _ytmpv_video_queue
            case f fg
                tmux attach -t ytmpv
            case h help
                functions ytmpv
            case l list
                string split ' ' $_ytmpv_video_queue
            case p play
                break
            case q quit
                return
            case '*'
                test -z "$video"; and break
                set -U _ytmpv_video_queue $_ytmpv_video_queue (string split ' ' $video)
        end
    end

    tmux attach -t ytmpv
    tmux new-session -s ytmpv -- mpv --save-position-on-quit $_ytmpv_video_queue
    ytmpv
end
