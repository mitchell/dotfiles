set -gx GOPATH $HOME/Documents/go
set -gx GOBIN $GOPATH/bin
set -gx PATH $PATH $GOBIN \
    $HOME/.pub-cache/bin \
    $HOME/Documents/bash_scripts \
    $HOME/Library/Python/2.7/bin \
    $HOME/.n/bin \
    $HOME/Documents/flutter/bin \
    $HOME/.cargo/bin

set -g fish_escape_delay_ms 10

# The next line updates PATH for the Google Cloud SDK.
if test -f '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; source '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; end
