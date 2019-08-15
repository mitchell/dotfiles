# mitchell's dotfiles

This mostly exists for my convenient bootstrapping onto new systems, but it should be generalized
enough for anyone to use it.

This repo contains my preferred configurations for:
- fish shell
- vim
- tmux
- git

Which also implies they are all dependencies to use the whole configuration.

Other dependencies:
- rsync (for sync script)
- curl (for fisher pkg manager)

To use all of the configurations:
1. Clone this repo with the `--recurse-submodules` flag.
1. `cd` into this repo and run the `sync` script (requires fish).
1. If you haven't already either run `fish` or change your default shell by adding the result of
   `which fish` to `/etc/shells` and running `chsh -s /path/to/fish yourusername` and restart the
   terminal.
1. Once using fish run `fisher` to install all fish plugins.
1. Enjoy!
