set -gx EDITOR nvim
set -gx BROWSER firefox
set -gx DIFFPROG delta

set -gx FZF_CTRL_T_COMMAND 'fd --type f --type d --hidden --exclude ".git/"'
set -gx FZF_DEFAULT_COMMAND 'fd --type f --type d --hidden --exclude ".git/"'
set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude ".git/"'

set -gx GOPATH $HOME/code/go
set -gx GOBIN $GOPATH/bin

set -gx BUN_INSTALL $HOME/.bun
set -gx PNPM_HOME $HOME/.local/share/pnpm

set -gx LIBVIRT_DEFAULT_URI 'qemu:///system'

set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

if test (uname) = Darwin
    set -gx ANDROID_HOME $HOME/Library/Android/Sdk
else
    set -gx ANDROID_HOME $HOME/Android/Sdk
end

set -gx PYENV_ROOT $HOME/.pyenv

fish_add_path --global $GOBIN \
    $HOME/.local/bin \
    $HOME/.pub-cache/bin \
    $HOME/code/scripts \
    $HOME/code/flutter/bin \
    $HOME/.cargo/bin \
    $HOME/.dotnet/tools \
    $BUN_INSTALL/bin \
    $PNPM_HOME/bin \
    $PYENV_ROOT/bin \
    $ANDROID_HOME/emulator \
    $ANDROID_HOME/platform-tools
