# My dotfiles


```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --source=~/.local/share/dotfiles $GITHUB_USERNAME && chezmoi init --source=~/.local/share/dotfiles/chezmoi && chezmoi apply --source=~/.local/share/dotfiles/chezmoi
```


# TODO


- [ ] Create ansible playbook for the installation.
- [ ] Create EWW widgets
    - [X] Brightness slider
    - [X] Sound slider
    - [ ] Brigness + hyprsunset
    - [ ] Colors, saturation & themes
- [ ] Improve rofi monitor menu, add a mirror mode
- [ ] Brave : meets screen share looks weirds (probably wayland issue).
