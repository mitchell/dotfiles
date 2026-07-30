# mitchell's dotfiles

This mostly exists for my convenient bootstrapping onto new systems. I would generally recommend
drawing from individual applications' configurations as inspiration for your own dotfiles. But I use
Stow to link each config module into my home dir, and things should be general enough to use
yourself.

This repo contains my preferred configurations for:

- neovim
- fish shell
- zsh shell
- git
- tmux
- ghostty
- wezterm
- bspwm/sxhkd (x11)
- sway (wayland)
- niri (wayland)
- yabai/skhd (macos)

## Scripts

### `install_utils`

**Dependencies**

- git
- bash

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
