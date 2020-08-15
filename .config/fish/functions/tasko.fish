function tasko -a id -d 'Open the link of a taskwarrior task by id'
    set link (task _get $id.link)
    if test -n $link; open $link; end
end
