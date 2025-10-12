# My dotfiles


```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --source=~/.local/share/dotfiles $GITHUB_USERNAME && chezmoi init --source=~/.local/share/dotfiles/chezmoi && chezmoi apply --source=~/.local/share/dotfiles/chezmoi
```


# TODO


- [ ] Remove fake home for brave, its useless, .pki is also use by proton apps (update wiki).

- [ ] Create ansible playbook for the installation.
- [ ] Brave : meets screen share looks weirds (probably wayland issue).
- [ ] External only monitor script is super wonky.
- [ ] Try bubblewrap with steam.
