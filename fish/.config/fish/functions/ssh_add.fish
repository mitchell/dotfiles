function ssh_add -d 'Shortcut for adding keys to ssh agent'
    read --prompt-str='e/r/s? ' args

    argparse --max-args 1 's/seedly' 'r/rsa' -- $args

    switch $args
        case s seedly
            ssh-add ~/.secrets/seedly_ed25519
        case r rsa
            ssh-add ~/.secrets/id_rsa
        case '*'
            ssh-add ~/.secrets/id_ed25519
    end
end
