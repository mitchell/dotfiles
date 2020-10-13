function repeat -a count -d 'Repeat the given action the given number of times'
    for i in (seq $count)
        $argv[2..-1]
    end
end
