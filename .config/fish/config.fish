set -gx EDITOR vim
set -gx GOPATH $HOME/Documents/go
set -gx GOBIN $GOPATH/bin
set -gx DOTNET_ENVIRONMENT Development
set -gx DOTNET_CLI_TELEMETRY_OPTOUT true
set -gx PATH $PATH $GOBIN \
    $HOME/.pub-cache/bin \
    $HOME/Documents/scripts \
    $HOME/Documents/flutter/bin \
    $HOME/.cargo/bin \
    $HOME/.dotnet/tools

command -sq kitty; and kitty + complete setup fish | source
command -sq asdf; and source (brew --prefix asdf)/asdf.fish

# The next line updates PATH for the Google Cloud SDK.
# if test -f '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; source '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; end
