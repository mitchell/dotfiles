# _define_variables defines all and exclusively globally exported variables
function _define_variables
    set -gx AWS_SDK_LOAD_CONFIG true

    set -gx DOTNET_ENVIRONMENT Development
    set -gx DOTNET_CLI_TELEMETRY_OPTOUT true
    set -gx DOTNET_ROOT $HOME/.asdf/installs/dotnet-core/(command -q dotnet; and dotnet --version)

    set -gx EDITOR nvim

    set -gx FZF_CTRL_T_COMMAND 'ag --hidden --ignore .git -g ""'
    set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

    set -gx GOPATH $HOME/code/go
    set -gx GOBIN $GOPATH/bin

    set -gx LIBVIRT_DEFAULT_URI 'qemu:///system'

    set -gx PATH $PATH $GOBIN \
        /snap/bin \
        $HOME/bin \
        $HOME/.pub-cache/bin \
        $HOME/code/scripts \
        $HOME/code/flutter/bin \
        $HOME/.cargo/bin \
        $HOME/.dotnet/tools
end

# _source_imports loads any additional fish files in at init
function _source_imports -a uname
    command -q kitty; and kitty + complete setup fish | source

    switch $uname
        case Linux
            test -e ~/.asdf/asdf.fish; and source ~/.asdf/asdf.fish
        case Darwin
            command -q brew
            and test -e (brew --prefix asdf)/asdf.fish
            and source (brew --prefix asdf)/asdf.fish
    end

    # The next line updates PATH for the Google Cloud SDK.
    # if test -f '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; source '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; end
end

# _set_aliases sets aliases for commonly used command
function _set_aliases -a uname
    alias cp 'rsync -aP'
    alias dm 'docker-machine'
    alias v  'nvim (fzf)'
    alias vg 'vagrant'
    alias tocb 'xclip -in -selection clipboard'
    alias fromcb 'xclip -out -selection clipboard'

    switch $uname
        case Linux
            alias cat      'batcat --theme ansi-dark'
            alias goland   'command goland'
            alias rider    'command rider'
            alias webstorm 'command webstorm'
        case Darwin
            alias cat      'bat --theme ansi-dark'
            alias goland   'open -a Goland'
            alias rider    'open -a Rider'
            alias webstorm 'open -a Webstorm'
    end
end

# _define_functions defines a couple of small globally available functions
function _define_functions -a uname
    function dm-env; eval (docker-machine env $argv); end

    function temp -a ft
        set -l file "._temp.$ft"

        touch $file
        $EDITOR $file
        rm $file
    end

    function _editcb -a uname ft
        set -l file "._temp.$ft"
        touch $file

        switch $uname
            case Linux
                xclip -out -selection clipboard > $file
            case Darwin
                pbpaste > $file
        end

        $EDITOR $file

        switch $uname
            case Linux
                xclip -in -selection clipboard < $file
            case Darwin
                pbcopy < $file
        end

        rm $file
    end

    alias editcb "_editcb $uname"
end

# Determine OS
set -l uname (uname)

# Begin profile init
_define_variables
_source_imports $uname
_set_aliases $uname
_define_functions $uname
