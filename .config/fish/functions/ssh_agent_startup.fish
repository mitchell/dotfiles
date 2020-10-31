function ssh_agent_startup -d 'Start ssh agent and set env vars'
    eval (ssh-agent -c) >/dev/null 2>&1
end
