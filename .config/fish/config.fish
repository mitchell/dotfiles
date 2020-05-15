set -gx EDITOR nvim

set -gx GOPATH $HOME/code/go
set -gx GOBIN $GOPATH/bin

set -gx DOTNET_ENVIRONMENT Development
set -gx DOTNET_CLI_TELEMETRY_OPTOUT true
set -gx DOTNET_ROOT $HOME/.asdf/installs/dotnet-core/(command -sq dotnet; and dotnet --version)

set -gx PATH $PATH $GOBIN \
    /snap/bin \
    $HOME/bin \
    $HOME/.pub-cache/bin \
    $HOME/code/scripts \
    $HOME/code/flutter/bin \
    $HOME/.cargo/bin \
    $HOME/.dotnet/tools

set -gx UNAME (uname)

command -sq kitty; and kitty + complete setup fish | source

switch "$UNAME"
    case 'Linux'
        test -e ~/.asdf/asdf.fish; and source ~/.asdf/asdf.fish
    case 'Darwin'
        test -e (brew --prefix asdf)/asdf.fish; and source (brew --prefix asdf)/asdf.fish
end

# The next line updates PATH for the Google Cloud SDK.
# if test -f '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; source '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; end

# aliases
function cp; rsync -aP $argv; end

function dm; docker-machine $argv; end

function dm-env; eval (docker-machine env $argv); end

function v; nvim (fzf); end

function vg; vagrant $argv; end

function cat
    switch "$UNAME"
        case 'Linux'
            batcat --theme ansi-dark $argv
        case 'Darwin'
            bat --theme ansi-dark $argv
    end
end

function goland
    switch "$UNAME"
        case 'Linux'
            command goland $argv
        case 'Darwin'
            open -a Goland $argv
    end
end

function rider
    switch "$UNAME"
        case 'Linux'
            command rider $argv
        case 'Darwin'
            open -a Rider $argv
    end
end

function webstorm
    switch "$UNAME"
        case 'Linux'
            command webstorm $argv
        case 'Darwin'
            open -a Webstorm $argv
    end
end

