# dotenv

This repo contains my configs for
- fish
- neovim
- kitty
- tmux
- i3

and a few miscellaneous scripts.

## Install

```bash
./pacman_installs.sh
./install.sh
# ./hpc_install.sh # if required!
```

## Post-Install

### `ssh-agent`

Enable ssh-agent (from <https://wiki.archlinux.org/title/SSH_keys#SSH_agents>):

- in config.fish:

```fish
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
```

- on cmd line:

```bash
systemctl --user enable --now ssh-agent.service
```

### Tailscale

```bash
sudo systemctl enable --now tailscaled
sudo tailscale login
```

### Borgmatic

```bash
sudo pacman -S borgmatic
systemctl --user enable --now borgmatic-jamie.timer
```

### `syncthing`

```bash
sudo pacman -S syncthing
systemctl --user enable --now syncthing.service
```

## Tricks

### Improving GRUB LUKS speed

From <https://wiki.archlinux.org/title/GRUB/Tips_and_tricks#Speeding_up_LUKS_decryption_in_GRUB>

```
cryptsetup luksChangeKey --pbkdf-force-iterations 1000 /dev/sda3
```

### Finding fonts

`fc-list`
