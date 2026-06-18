function sshre -d 'Remove list of hosts from ssh known_hosts'
    alias ssh-rm 'ssh-keygen -f ~/.ssh/known_hosts -R'
    set -l hosts 10.0.0.1 10.0.0.5 git.mjfs.us dns cloud net git
    set -l domains lan m

    if test -n "$argv"
        set hosts $argv
    end

    for host in $hosts
        ssh-rm $host

        for domain in $domains
            ssh-rm $host.$domain
        end
    end
end
