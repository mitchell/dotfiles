function import_sources -a uname -d 'Loads any additional fish files needed at init.'
    test -f ~/.asdf/plugins/dotnet-core/set-dotnet-home.fish; and source ~/.asdf/plugins/dotnet-core/set-dotnet-home.fish

    test -e ~/.asdf/asdf.fish
    and source ~/.asdf/asdf.fish
    and mkdir -p ~/.config/fish/completions
    and ln -sf ~/.asdf/completions/asdf.fish ~/.config/fish/completions

    # The next line updates PATH for the Google Cloud SDK.
    # if test -f '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; source '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; end
end
