function define_global_variables -d 'Defines all and exclusively globally exported variables'
    set -gx AWS_SDK_LOAD_CONFIG true

    set -gx DOTNET_ENVIRONMENT Development
    set -gx DOTNET_CLI_TELEMETRY_OPTOUT true

    set -gx EDITOR nvim
    set -gx BROWSER qutebrowser

    set -gx FZF_CTRL_T_COMMAND 'ag --hidden --ignore .git -g ""'
    set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

    set -gx GOPATH $HOME/code/go
    set -gx GOBIN $GOPATH/bin

    set -gx LIBVIRT_DEFAULT_URI 'qemu:///system'

    set -gx PATH $PATH $GOBIN \
        $HOME/.local/bin \
        $HOME/.pub-cache/bin \
        $HOME/code/scripts \
        $HOME/code/flutter/bin \
        $HOME/.cargo/bin \
        $HOME/.dotnet/tools
end
