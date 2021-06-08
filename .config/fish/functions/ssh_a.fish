function ssh_a -d 'Shortcut for adding keys to ssh agent'
    argparse --max-args 1 's/seedly' 'r/rsa' -- $argv

    if test -n "$_flag_s"
        ssh-add ~/.secrets/seedly_ed25519
    else if test -n "$_flag_r"
        ssh-add ~/.secrets/id_rsa
    else
        ssh-add ~/.secrets/id_ed25519
    end
end
