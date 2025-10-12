# My dotfiles


```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --source=~/.local/share/dotfiles $GITHUB_USERNAME && chezmoi init --source=~/.local/share/dotfiles/chezmoi && chezmoi apply --source=~/.local/share/dotfiles/chezmoi
```


# TODO


- [ ] Create ansible playbook for the installation.
- [ ] Brave : meets screen share looks weirds (probably wayland issue).

- [ ] Figlet art for eww menus
- [ ] For steam, set its pki dir as a symlink to .local/share/pki
- [ ] Give chromium a fake home
