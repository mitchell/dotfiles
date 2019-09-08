# mitchell's dotfiles

This mostly exists for my convenient bootstrapping onto new systems, but it should be generalized
enough for anyone to use it.

This repo contains my preferred configurations for:
- fish shell
- vim
- tmux
- git
- yabai wm
- skhd
- kitty term

Which also implies they are all dependencies to use the whole configuration.

Installation dependencies:
- git
- fish
- rsync (for sync script)
- curl

To install from fish shell: `curl https://raw.githubusercontent.com/mitchell/dotfiles/master/sync | .`

To install all of the configuration from bash and then change default shell:
1. Clone this repo with the `--recurse-submodules` flag.
1. `cd` into your clone and run the `sync` script (requires fish be installed).
1. If you haven't already either run `fish` or change your default shell by appending the result of
   `which fish` to `/etc/shells` and running `chsh -s /path/to/fish yourusername`, then restarting
   the terminal.
1. Enjoy!

Dependencies for fish aliases:
- fzf (used in `v`)
- ag (used in `vs`)

Dependencies for prompt info (only needed in relevant projects):
- golang
- docker
- node
- typescript
- elixir
- dart
- flutter
