set -gx GOPATH $HOME/Documents/go
set -gx GOBIN $GOPATH/bin
set -gx PATH $PATH $GOBIN \
    $HOME/.pub-cache/bin \
    $HOME/Documents/scripts \
    $HOME/Documents/flutter/bin \
    $HOME/.cargo/bin

set -g fish_escape_delay_ms 10

# The next line updates PATH for the Google Cloud SDK.
if test -f '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; source '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; end
