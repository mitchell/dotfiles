function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l color_cwd
    set -l suffix
    set -l user_prefix
    set -l git_branch
    set -l jobs_num
    set -l exit_code

    # Set exit code, based on last command status
    if test $last_status -ne 0
        set exit_code '<' (set_color $fish_color_status) $last_status (set_color normal) '> '
    end

    # Set jobs num, based on exit code of jobs command
    if jobs >/dev/null
        set -l jobs_out (jobs -c)
        set jobs_num '[' (set_color grey) (count $jobs_out) (set_color normal) '] '
    end

    # Set cwd color and prompt suffix, based on current user and fish_bind_mode.
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end

            set suffix '#'

            if test $fish_key_bindings = 'fish_vi_key_bindings'
                switch "$fish_bind_mode"
                    case 'insert'
                        set suffix (set_color brblue) $suffix (set_color normal)
                    case 'visual'
                        set suffix (set_color bryellow) $suffix (set_color normal)
                end
            end
        case '*'
            set color_cwd $fish_color_cwd

            set suffix '>'

            if test $fish_key_bindings = 'fish_vi_key_bindings'
                switch "$fish_bind_mode"
                    case 'insert'
                        set suffix (set_color brblue) $suffix (set_color normal)
                    case 'default'
                        set suffix '^'
                    case 'visual'
                        set suffix (set_color bryellow) 'v' (set_color normal)
                end
            end
    end


    # Set user_prefix, based on whether or not inside of ssh session.
    if test -n "$SSH_CLIENT"
        set user_prefix $USER @ (prompt_hostname) ' '
    end

    # Show current git branch, based on git commands only.
    if git status >/dev/null 2>&1
        set -l branch_color green
        set -l git_status (git status)

        if string match 'Changes not staged for commit:' $git_status >/dev/null
            or string match 'Untracked files:' $git_status >/dev/null
            set branch_color red
        else if string match 'Changes to be committed:' $git_status >/dev/null
            set branch_color yellow
        end

        set -l cur_branch (string sub -s 3 (string match -r '^\* .*$' (git branch)))
        if string match -q '(HEAD detached*' $cur_branch
            set cur_branch 'detached'
        end

        if test -n "$cur_branch"
            set -l cur_branch_len (string length $cur_branch)
            if test $cur_branch_len -gt 21
                set -l sub_str (string sub -l 18 $cur_branch)
                set cur_branch "$sub_str..."
            end
        end

        if string match 'Your branch is ahead of*' $git_status >/dev/null
            set cur_branch $cur_branch \u21A5
        else if string match 'Your branch is behind*' $git_status >/dev/null
            set cur_branch $cur_branch \u21A7
        end

        set git_branch ' on ' (set_color $branch_color) $cur_branch (set_color normal)
    end

    # Set user prefix, based on docker machine name
    if test -n "$DOCKER_MACHINE_NAME"
        set user_prefix (set_color blue) $DOCKER_MACHINE_NAME (set_color normal) ' '
    end

    # Set go version, by existence of go mod or dep files
    if test -e ./go.mod; or test -e ./Gopkg.toml; and command -sq go
        if test -z "$go_version"
            set -l version_str (string match -r 'go\d+\.\d+\.?\d*' (go version))
            set -g go_version ' with ' (set_color 8eadaf) $version_str (set_color normal)
        end
    else
        set -g go_version
    end

    # Set docker version, by existence of Dockerfile
    if test -e ./Dockerfile; and command -sq docker
        if test -z "$docker_version"
            set -l version_str (string match -r '\d+\.\d+\.?\d*' (docker --version))
            set -g docker_version ' on ' (set_color blue) 'docker' $version_str (set_color normal)
        end
    else
        set -g docker_version
    end

    # Set node (and ts) version, based on existance of package.json (and tsconfig.json)
    if test -e ./package.json; and command -sq node
        if test -z "$node_version"
            set -l version_str (string sub -s 2 (node -v))
            set -g node_version ' with ' (set_color brgreen) 'node' $version_str (set_color normal)

            if test -e ./tsconfig.json; and command -sq tsc
                set -l version_str (string match -r '\d+\.\d+\.?\d*' (tsc -v))
                set -g node_version $node_version ' and ' (set_color cyan) 'ts' $version_str (set_color normal)
            end
        end
    else
        set -g node_version
    end

    # Set elixir version, based on existance of mix.exs
    if test -e ./mix.exs; and command -sq elixir
        if test -z "$ex_version"
            set -l version_str (string sub -s 8 (string match -r 'Elixir \d+\.\d+\.?\d*' (elixir -v)))
            set -g ex_version ' with ' (set_color magenta) 'ex' $version_str (set_color normal)
        end
    else
        set -g ex_version
    end

    # Set dart version, based on existances of pubspec.yaml
    if test -e ./pubspec.yaml; and command -sq dart
        if test -z "$dart_version"
            set -l version_str (string match -r '\d+\.\d+\.?\d*' (dart --version 2>| cat))
            set -g dart_version ' with ' (set_color brblue) 'dart' $version_str (set_color normal)
        end
    else
        set -g dart_version
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
