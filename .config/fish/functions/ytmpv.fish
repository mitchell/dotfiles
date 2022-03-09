function ytmpv -d 'A script to help queue youtube videos on MPV'
    set -l queue ~/.ytmpv_queue
    set -l downloads ~/.ytmpv_downloads/

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
                string split ' ' $video >> $queue
            case d destroy
                rm -r $queue $downloads
                break
            case dl download
                set -l urls (cat $queue)
                read -P 'username> ' -l username
                read -P 'password> ' -s -l password

                tmux attach -t ytdlp
                tmux new-session -s ytdlp -- \
                    yt-dlp \
                        --username="$username" \
                        --password="$password" \
                        --paths=$downloads \
                        --write-subs \
                        $urls

                break
            case f fg
                tmux attach -t ytmpv
            case h help
                functions ytmpv
            case l list
                cat $queue
            case p play
                tmux attach -t ytmpv
                tmux new-session -s ytmpv -- mpv --save-position-on-quit --playlist=$queue
                break
            case pdl play-downloads
                tmux attach -t ytmpv
                tmux new-session -s ytmpv -- mpv --save-position-on-quit $downloads
                break
            case q quit
                return
            case '*'
                if test -z "$video"
                    tmux attach -t ytmpv
                    tmux new-session -s ytmpv -- mpv --save-position-on-quit --playlist=$queue
                    break
                end

                string split ' ' $video >> $queue
        end
    end

    ytmpv
end
