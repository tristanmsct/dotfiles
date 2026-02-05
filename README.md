# My dotfiles


```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --source=~/.local/share/dotfiles $GITHUB_USERNAME && chezmoi init --source=~/.local/share/dotfiles/chezmoi && chezmoi apply --source=~/.local/share/dotfiles/chezmoi
```


# TODO


- [ ] Create ansible playbook for the installation.


# Ansible


```bash
# Full setup
ansible-playbook playbook.yml -K

# Only install Hyprland
ansible-playbook playbook.yml -K --tags hyprland

# Skip backup configuration
ansible-playbook playbook.yml -K --skip-tags backup
```
