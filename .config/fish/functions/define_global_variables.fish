function define_global_variables -d 'Defines all and exclusively globally exported variables'
    set -gx AWS_SDK_LOAD_CONFIG true

    set -gx DOTNET_ENVIRONMENT Development
    set -gx DOTNET_CLI_TELEMETRY_OPTOUT true

    set -gx EDITOR nvim
    set -gx BROWSER firefox
    set -gx DIFFPROG nvim -d

    set -gx FZF_CTRL_T_COMMAND 'fd --type f --type d --hidden --exclude ".git/"'
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --type d --hidden --exclude ".git/"'
    set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude ".git/"'

    set -gx GOPATH $HOME/code/go
    set -gx GOBIN $GOPATH/bin

    set -gx GTK_THEME Kanagawa-BL

    set -gx BUN_INSTALL $HOME/.bun

    set -gx LIBVIRT_DEFAULT_URI 'qemu:///system'

    set -gx ANDROID_HOME $HOME/Android/Sdk

    fish_add_path $GOBIN \
        $HOME/.local/bin \
        $HOME/.pub-cache/bin \
        $HOME/code/scripts \
        $HOME/code/flutter/bin \
        $HOME/.cargo/bin \
        $HOME/.dotnet/tools \
        $BUN_INSTALL/bin \
        $ANDROID_HOME/emulator \
        $ANDROID_HOME/platform-tools
end
