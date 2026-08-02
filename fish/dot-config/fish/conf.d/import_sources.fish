test -e /opt/homebrew/bin/brew
and /opt/homebrew/bin/brew shellenv | source -

if status is-interactive
    command -q zoxide; and zoxide init fish | source
    command -q fzf; and fzf --fish | source
end

command -q pyenv; and pyenv init - | source
command -q mise; and mise activate fish | source
