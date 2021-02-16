function push -a message -d 'Send a push notification to your phone via pushover (optional delay as second arg)'
    argparse 'u/url=' 'p/priority=' -- $argv

    set -l host (cat /etc/hostname)

    if test -z "$_flag_p"
        set _flag_p '0'
    end

    set payload \
        "{
  \"token\": \"$pushover_token\",
  \"user\": \"$pushover_user\",
  \"title\": \"Push from $host\",
  \"url\": \"$_flag_u\",
  \"priority\": $_flag_p,
  \"message\": \"$message\"
}"

    curl \
        -X POST \
        -H 'Content-Type: application/json' \
        -d "$payload" \
        https://api.pushover.net/1/messages.json
end
