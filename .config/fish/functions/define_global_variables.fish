function define_global_variables -d 'Defines all and exclusively globally exported variables'
    set -gx AWS_SDK_LOAD_CONFIG true

    set -gx DOTNET_ENVIRONMENT Development
    set -gx DOTNET_CLI_TELEMETRY_OPTOUT true

    set -gx EDITOR nvim
    set -gx BROWSER firefox
    set -gx DIFFPROG nvim -d

    set -gx FZF_CTRL_T_COMMAND 'ag --hidden --ignore .git -g ""'
    set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

    set -gx GOPATH $HOME/code/go
    set -gx GOBIN $GOPATH/bin

    set -gx BUN_INSTALL $HOME/.bun

    set -gx LIBVIRT_DEFAULT_URI 'qemu:///system'

    set -gx ANDROID_HOME $HOME/Android/Sdk

    set -gx LIBVA_DRIVER_NAME nvidia

    fish_add_path $GOBIN \
        $HOME/.local/bin \
        $HOME/.pub-cache/bin \
        $HOME/code/scripts \
        $HOME/code/flutter/bin \
        $HOME/.cargo/bin \
        $HOME/.dotnet/tools \
        $BUN_INSTALL/bin \
        $ANDROID_HOME/emulator \
        $ANDROID_HOME/platform-tools \
        $ANDROID_HOME/build-tools/31.0.0 \
        $ANDROID_HOME/tools
end
