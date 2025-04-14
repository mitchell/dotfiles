function import_sources -a uname -d 'Loads any additional fish files needed at init.'
    test -f ~/.asdf/plugins/dotnet-core/set-dotnet-home.fish; and source ~/.asdf/plugins/dotnet-core/set-dotnet-home.fish

    # ASDF configuration code
    if test -z $ASDF_DATA_DIR
        set _asdf_shims "$HOME/.asdf/shims"
    else
        set _asdf_shims "$ASDF_DATA_DIR/shims"
    end

    # Do not use fish_add_path (added in Fish 3.2) because it
    # potentially changes the order of items in PATH
    if not contains $_asdf_shims $PATH
        set -gx --prepend PATH $_asdf_shims
    end
    set --erase _asdf_shims

    test -e /opt/homebrew/bin/brew
    and /opt/homebrew/bin/brew shellenv | source -

    command -q starship; and starship init fish | source
    command -q zoxide; and zoxide init fish | source
    command -q fzf; and fzf --fish | source
    command -q pyenv; and pyenv init - | source

    # The next line updates PATH for the Google Cloud SDK.
    # if test -f '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; source '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; end
end
