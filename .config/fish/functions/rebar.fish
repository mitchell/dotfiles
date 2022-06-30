function rebar
    pkill -fi polybar; and pkill -fi -9 polybar
    bspc config top_padding -10
    polybar m-bar &> /dev/null & disown
end
