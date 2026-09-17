# Tristan's Arch linux Dotfiles

My arch linux dotfiles.

They contain my config for most important software, including Hyprland and Niri and many desktop and user scripts.

## Main features

 - Full configuration for Hyprland and / or Niri
 - Clean configuration for Zsh and Bash
 - Configuration for menus using Rofi, Eww, NWG-panel / drawer
 - Configuration for common tools such as Waybar and Wlogout
 - Some practical user scripts
 - Various desktop automation scripts (Auto color theming with wallust, auto blue light filter)


## Quick start

To install from scratch see my [ansible repo](https://github.com/tristanmsct/ansible-archlinux).

To use only the dotfiles, first install chezmoi.

```bash
sudo pacman -S chezmoi
```

Then ensure the source directory is configured properly in `$HOME/.config/chezmoi/chezmoi.toml`.
```ini
sourceDir = "/home/tristan/.local/share/dotfiles"
```

Then clone and sync the dotfiles.
```bash
git clone git@github.com:tristanmsct/dotfiles.git "$HOME/.local/share/dotfiles"
chezmoi apply
```

## Repository layout

- `Documents` - Simple templates files
- `dot_config` - Base config for most software
- `private_dot_ssh` - Configuration for ssh
- `private_dot_local/bin` - User scripts
- `private_dot_local/private_share/applications` - Desktop files
- `private_dot_local/private_share/fake_home` - Fake home setup to jail some applications
- `private_dot_local/private_share/scripts` - Desktop script for various automation
