function do -d 'Repeat the command for each given argument'
    set command (string split ' ' $argv[1])
    and set args $argv[2..]
    or return 1
    
    for arg in $args
        $command $arg
    end
end
