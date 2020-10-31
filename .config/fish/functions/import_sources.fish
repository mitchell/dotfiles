function import_sources -a uname -d 'Loads any additional fish files needed at init.'
    command -q kitty; and kitty + complete setup fish | source

    switch "$uname"
        case 'Linux'
            test -e ~/.asdf/asdf.fish
            and source ~/.asdf/asdf.fish
            and mkdir -p ~/.config/fish/completions
            and cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions
        case 'Darwin'
            command -q brew
            and test -e (brew --prefix asdf)/asdf.fish
            and source (brew --prefix asdf)/asdf.fish
    end

    # The next line updates PATH for the Google Cloud SDK.
    # if test -f '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; source '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; end
end
