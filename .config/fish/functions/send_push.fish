function send_push -a message -d 'Send a push notification to your phone via pushover (optional delay as second arg)'
  if test -n "$argv[2]"; sleep $argv[2]; end

  set payload \
"{
  \"token\": \"$pushover_token\",
  \"user\": \"$pushover_user\",
  \"title\": \"Tasks\",
  \"message\": $message
}"

  curl \
    -X POST \
    -H 'Content-Type: application/json' \
    -d $payload \
    https://api.pushover.net/1/messages.json
end
