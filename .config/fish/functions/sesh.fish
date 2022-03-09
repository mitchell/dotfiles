function sesh -a session -d 'Create or attach to session'
    tmux new -s $session -A -D
end
