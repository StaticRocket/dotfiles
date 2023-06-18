# dotfiles

My configs, packaged for use with [stow](https://www.gnu.org/software/stow/).
Mainly only for my use, but feel free to grab useful stuff if you want.


## Usage

1. Clone this into your home directory
2. `cd dotfiles`
3. `stow <config-dir>`

If you run into issues you may need to remove existing configs. Bash is an
example of this. You will need to delete `.bash{rc,_logout,_profile}` before
running stow.

## Dependency management

These configs may introduce dependencies (waybar configs using particular
fonts, for instance). I'm attempting to track them through the use of config
specific dependency files in `~/.config/dotfile-packages`. These files are a
sorted list of dependencies (currently for Arch Linux), named after the config
that provides it. The goal is to be able to run the following after stowing all
wanted configs on a new machine:

```bash
cat ~/.config/dotfile-packages/* | pacman -S -
```
