ssh_agent_startup

# ASDF config start
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

fish_add_path $_asdf_shims
set --erase _asdf_shims
# ASDF config end

test -e /opt/homebrew/bin/brew
and /opt/homebrew/bin/brew shellenv | source -

if status is-interactive
    command -q zoxide; and zoxide init fish | source
    command -q fzf; and fzf --fish | source
end

command -q pyenv; and pyenv init - | source
