function push_tasks -d 'Push tasks as a notification to your phone'
    set tasks (task +READY export |
                   jq 'sort_by(.urgency) |
                       reverse |
                       map(@text "\(.description)\nLink: \(.link)\nWiki: http://wiki.m/\(.wiki)\nDue: \(.due)") |
                       join("\n\n")')
    send_push $tasks
end
