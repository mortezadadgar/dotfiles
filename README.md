# Morteza's Dotfiles
My personal dotfiles that I use mostly on Gentoo and Archlinux based distros.

- shell scripts are in `sh/.local/bin`
- `share/.local/share/fonts` fonts that i use on every device
- configs for:
	- dunst
	- htop
	- mpd
	- mpv
	- ncmpcpp
	- nvim
	- picom
	- zathura
	- imv
	- zsh

## Installation
```bash
make install
```
FYI, you can install configs one by one like:
```bash
stow --target="$HOME" -Rv $folder
```

### Uninstallation
```bash
make uninstall
```


