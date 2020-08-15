function tasktime -a id time -d 'Set a time to check-in on task progress using pushover'
    set half_time (math $time/2)
    set desc (task _get $id.description)

    task $id start

    fish -c "send_push '\"Half-time: $desc\"' $half_time" > /dev/null & disown
    fish -c "send_push '\"Timer over: $desc\"' $time" > /dev/null & disown
end
