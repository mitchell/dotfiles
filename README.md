# mitchell's dotfiles

This mostly exists for my convenient bootstrapping onto new systems. I would generally recommend
drawing from individual applications' configurations as inspiration for your own dotfiles. However,
the included scripts should be generalized enough to work on anybody's machines.

This repo contains my preferred configurations for:

- fish shell
- neovim
- tmux
- git
- Wez's terminal
- keepassxc
- bspwm (Linux)
- sxhkd (Linux)
- yabaiwm (macOS)
- skhd (macOS)

## Scripts

### `sync`

**Dependencies**

- fish
- git
- neovim
- rsync
- curl

**Description**

Syncs all configuration files found in this repository to your home folder.

To run sync script using curl: `curl https://raw.githubusercontent.com/mitchell/dotfiles/master/sync | fish`

### `upgrade_debian`

**Dependencies**

- fish

**Description**

Upgrade from Debian stable to unstable.

### `provision_linux`

Dependencies

- fish

**Description**

Provision various environments and tools on Debian or Arch linux. Has
commands for terminal_env, desktop_env, and more. Take a peek.
