function push_tasks -a token user -d 'Push tasks as a notification to your phone'
  set tasks (task +READY export | jq 'sort_by(.urgency) | reverse | map(@text "\(.description)\nLink: \(.link)") | join("\n\n")')
  set payload "{\"token\":\"$token\",\"user\":\"$user\",\"title\":\"Tasks\",\"message\":$tasks}"

  curl \
    -X POST \
    -H 'Content-Type: application/json' \
    -d $payload \
    https://api.pushover.net/1/messages.json
end
