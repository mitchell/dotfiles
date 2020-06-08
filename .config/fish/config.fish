# variables
set -gx AWS_SDK_LOAD_CONFIG true

set -gx DOTNET_ENVIRONMENT Development
set -gx DOTNET_CLI_TELEMETRY_OPTOUT true
set -gx DOTNET_ROOT $HOME/.asdf/installs/dotnet-core/(command -sq dotnet; and dotnet --version)

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

set -g uname (uname)

# source imports 
command -sq kitty; and kitty + complete setup fish | source

switch $uname
    case Linux
        test -e ~/.asdf/asdf.fish; and source ~/.asdf/asdf.fish
    case Darwin
        command -sq brew
        and test -e (brew --prefix asdf)/asdf.fish
        and source (brew --prefix asdf)/asdf.fish
end

# The next line updates PATH for the Google Cloud SDK.
# if test -f '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; source '/Users/m/Documents/google-cloud-sdk/path.fish.inc'; end

# aliases
alias cp 'rsync -aP'
alias dm 'docker-machine'
alias v  'nvim (fzf)'
alias vg 'vagrant'

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

function dm-env; eval (docker-machine env $argv); end

function temp -a ft
  nvim temp.$ft

  switch $uname
      case Linux
          xclip -selection clipboard < temp.$ft
      case Darwin
          pbcopy < temp.$ft
  end

  rm temp.$ft
end
