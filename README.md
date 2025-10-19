# mitchell's dotfiles

This mostly exists for my convenient bootstrapping onto new systems. I would generally recommend
drawing from individual applications' configurations as inspiration for your own dotfiles. However,
the included scripts should be generalized enough to work on anybody's machines.

This repo contains my preferred configurations for:

- neovim
- fish shell
- git
- tmux
- wezterm (X11/macOS)
- ghostty (X11/Wayland)
- keepassxc
- bspwm (X11)
- sxhkd (X11)
- Niri (Wayland)
- yabaiwm (macOS)
- skhd (macOS)

## Scripts

### `sync`

**Dependencies**

- fish
- git
- rsync
- curl

**Description**

> **Warning:** This will overwrite any existing files by the same name.

Syncs all configuration files found in this repository to your home folder.

To run sync script using curl: `curl https://raw.githubusercontent.com/mitchell/dotfiles/master/sync | fish`

### `install_utils`

**Dependencies**

- git
- fish

**Description**

Installs various CLI utilities based on OS availability. Supports Arch, Debian, Fedora, and macOS
(brew). I recommend quickly reading what you're getting.

### `install_arch`

Dependencies

- fish

**Description**

Performs the final installation steps for Arch Linux **once inside** arch-chroot. This is a highly
specific configuration that makes A LOT of assumptions.

The timezone, hostname, username, network client, and boot mode can be chosen at runtime.

Locale is assumed to be `en_US.UTF-8`.

The created user will be added to the `wheel` group and given sudo permission. The root user will be
locked.

If you choose systemd-networkd as your network manager it only configures a single interface
matching the glob `en*`.

If installing to a UEFI system, it will use the systemd-boot bootloader and the "Boot target" should
be the root partition, like `/dev/vda2`. UEFI mode makes the assumption that the root partition is a
BTRFS partition, with at least one subvolume called `root`.

If installing to a BIOS system (VMs), it will use the Grub bootloader and the "Boot target" should
be the boot drive, like `/dev/vda` (not partition `/dev/vda1`). BIOS mode makes no assumptions about
root filesystem type.
