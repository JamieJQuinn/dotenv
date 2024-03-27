# dotenv

This repo contains my configs for
- fish
- neovim
- kitty
- tmux

and a few miscellaneous scripts.

## Tricks

Enable ssh-agent (from <https://wiki.archlinux.org/title/SSH_keys#SSH_agents>):

- in config.fish:

```fish
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
```

- on cmd line:

```bash
systemctl --user enable --now ssh-agent.service
```
