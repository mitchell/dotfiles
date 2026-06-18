function ssh_agent_startup -d 'Start ssh agent and set env vars'
    if test -z "$SSH_AUTH_SOCK"; and test -z "$SSH_AGENT_PID"; and test -z "$SSH_CLIENT"
        eval (ssh-agent -c) >/dev/null 2>&1
    end
end
