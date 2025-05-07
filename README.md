```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --source=~/.local/share/dotfiles $GITHUB_USERNAME && chezmoi init --source=~/.local/share/dotfiles/chezmoi && chezmoi apply --source=~/.local/share/dotfiles/chezmoi
```
