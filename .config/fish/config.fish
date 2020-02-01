set -gx EDITOR vim
set -gx GOPATH $HOME/Documents/go
set -gx GOBIN $GOPATH/bin
set -gx DOTNET_ENVIRONMENT Development
set -gx PATH $PATH $GOBIN \
    $HOME/.pub-cache/bin \
    $HOME/Documents/scripts \
    $HOME/Documents/flutter/bin \
    $HOME/.cargo/bin \
    $HOME/.rbenv/versions/2.7.0/bin \
    $HOME/.dotnet/tools

set -g fish_escape_delay_ms 10

kitty + complete setup fish | source

status --is-interactive; and source (rbenv init -|psub)

# The next line updates PATH for the Google Cloud SDK.
# if test -f '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; source '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; end
