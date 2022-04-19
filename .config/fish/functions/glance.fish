function glance -d 'Open glances on a preset of machines'
    tmux new -s glance mosh arch@khetanna.lan -- glances --disable-process --sparkline\; \
        neww mosh arch@kamino.lan -- glances --disable-process --sparkline\; \
        neww mosh arch@marauder.lan -- glances --disable-process --sparkline\; \
        neww mosh serenity.lan -- glances --sparkline\; \
        neww mosh venator.lan -- glances --sparkline
    or tmux attach-session -t glance
end
