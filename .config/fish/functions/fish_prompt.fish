function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l color_cwd
    set -l suffix
    set -l user_prefix
    set -l git_branch
    set -l go_version
    set -l docker_version
    set -l node_version
    set -l ex_version
    set -l dart_version
    set -l flutter_version
    set -l jobs_num
    set -l exit_code

    # Set exit code, based on last command status
    if test $last_status -ne 0
        set exit_code '<' (set_color $fish_color_status) $last_status (set_color normal) '> '
    end

    # Set jobs num, based on exit code of jobs command
    if jobs > /dev/null
        set -l jobs_out (jobs -c)
        set jobs_num '[' (set_color brblack) (count $jobs_out) (set_color normal) '] '
    end

    # Set cwd color and prompt suffix, based on current user and fish_bind_mode.
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end

            set suffix '#~>'

            if test $fish_key_bindings = 'fish_vi_key_bindings'
                switch "$fish_bind_mode"
                case 'insert'
                    set suffix (set_color brblue) $suffix (set_color normal)
                case 'default'
                    set suffix '###'
                case 'visual'
                    set suffix (set_color bryellow) '<~#' (set_color normal)
                end
            end
        case '*'
            set color_cwd $fish_color_cwd
            
            set suffix '~~>'

            if test $fish_key_bindings = 'fish_vi_key_bindings'
                switch "$fish_bind_mode"
                case 'insert'
                    set suffix (set_color brblue) $suffix (set_color normal)
                case 'default'
                    set suffix '<~>'
                case 'visual'
                    set suffix (set_color bryellow) '<~~' (set_color normal)
                end
            end
    end


    # Set user_prefix, based on whether or not inside of ssh session.
    if test -n "$SSH_CLIENT"; set user_prefix $USER @ (prompt_hostname) ' '; end

    # Show current git branch, based on git commands only.
    if git branch --show-current > /dev/null 2> /dev/null
        set -l branch_color green
        set -l git_status (git status)

        if string match 'Changes not staged for commit:' $git_status > /dev/null
                or string match 'Untracked files:' $git_status > /dev/null
            set branch_color red
        else if string match 'Changes to be committed:' $git_status > /dev/null
            set branch_color yellow
        end

        set -l cur_branch (git branch --show-current)
        if test -z $cur_branch; set cur_branch 'detached'; end

        set -l cur_branch_len (string length $cur_branch)
        if test $cur_branch_len -gt 21
            set -l sub_str (string sub -s (math $cur_branch_len - 17) -l 18 $cur_branch)
            set cur_branch "...$sub_str"
        end

        if string match 'Your branch is ahead of*' $git_status > /dev/null
            set cur_branch $cur_branch  \u21A5 
        else if string match 'Your branch is behind*' $git_status > /dev/null
            set cur_branch $cur_branch  \u21A7 
        end

        set git_branch ' on ' (set_color $branch_color) $cur_branch (set_color normal)
    end

    # Set go version, by existence of go mod or dep files
    if test -e ./go.mod; or test -e ./Gopkg.toml
        set -l version_str (string match -r 'go\d+\.\d+\.?\d*' (go version))
        set go_version ' with ' (set_color 8eadaf) $version_str (set_color normal)
    end

    # Set docker version, by existence of Dockerfile
    if test -e ./Dockerfile
        set -l version_str (string match -r '\d+\.\d+\.?\d*' (docker --version))
        set docker_version ' on ' (set_color blue) 'docker' $version_str (set_color normal)
    end

    # Set user prefix, based on docker machine name
    if test -n "$DOCKER_MACHINE_NAME"
        set user_prefix (set_color blue) $DOCKER_MACHINE_NAME (set_color normal) ' '
    end

    # Set node (and ts) version, based on existance of package.json (and tsconfig.json)
    if test -e ./package.json
        set -l version_str (string sub -s 2 (node -v))
        set node_version ' with ' (set_color brgreen) 'node' $version_str (set_color normal)

        if test -e ./tsconfig.json
          set -l version_str (string match -r '\d+\.\d+\.?\d*' (tsc -v))
          set node_version $node_version ' and ' (set_color cyan) 'ts' $version_str (set_color normal)
        end
    end

    # Set elixir version, based on existance of mix.exs
    if test -e ./mix.exs
        set -l version_str (string sub -s 8 (string match -r 'Elixir \d+\.\d+\.?\d*' (elixir -v)))
        set ex_version ' with ' (set_color magenta) 'ex' $version_str (set_color normal)
    end

    # Set dart version, based on existances of pubspec.yaml
    if test -e ./pubspec.yaml
        set -l version_str (string match -r '\d+\.\d+\.?\d*' (dart --version 2>| cat))
        set dart_version ' with ' (set_color brblue) 'dart' $version_str (set_color normal)

        if cat pubspec.yaml | grep flutter > /dev/null
            set -l version_str (string sub -s 9 (string match -r 'Flutter \d+\.\d+\.?\d*' (flutter --version)))
            set flutter_version ' on ' (set_color blue) 'flutter' $version_str (set_color normal)
        end
    end

    # Combine all prompt variables
    set -l cwd (set_color $color_cwd) (prompt_pwd) (set_color normal)
    set -l top_prompt $cwd $git_branch $go_version $ex_version $node_version $dart_version $flutter_version $docker_version
    set -l bottom_prompt $user_prefix $jobs_num $exit_code $suffix ' '

    # Decide whether to insert newline, based on whether the top prompt is only equal to cwd
    if test "$top_prompt" = "$cwd"
        set bottom_prompt ' ' $bottom_prompt
    else
        set bottom_prompt \n $bottom_prompt
    end

    echo -n -s $top_prompt
    echo -n -s $bottom_prompt
end
