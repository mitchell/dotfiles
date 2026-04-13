function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
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
    set suffix '>'
    if test $fish_key_bindings = fish_vi_key_bindings
        switch "$fish_bind_mode"
            case insert
                set suffix (set_color brblue) $suffix (set_color normal)
            case default
                set suffix '<'
            case visual
                set suffix (set_color bryellow) v (set_color normal)
        end
    end

    # Set user_prefix, based on whether or not inside of ssh session.
    if test -n "$SSH_CLIENT"
        set user_prefix $USER @ (prompt_hostname) ' '
    end

    # Show current git branch.
    if set -l cur_branch (git branch --show-current 2>/dev/null)
        if test -z "$cur_branch"
            set cur_branch detached
        end

        set git_branch ' on ' (set_color $fish_color_cwd) $cur_branch (set_color normal)
    end

    # Combine all prompt variables
    set -l cwd (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    set -l top_prompt $cwd $git_branch
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
