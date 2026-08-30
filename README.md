# nhartland/dotfiles

My dotfiles, installation via:


- [dotbot](https://github.com/anishathalye/dotbot)
- [strap](https://github.com/MikeMcQuaid/strap)

which are setup as submodules.

### Installing/updating 

```Shell
# dotbot
./install
# When on macOS
cd strap && bash bin/strap.sh
```

### neovim

`nvim/` is symlinked to `~/.config/nvim`. Requires neovim >= 0.11; plugins
(lazy.nvim) and LSP servers (Mason) install on first launch.

### Linux

Debian (bookworm or newer), shell sessions only:

```Shell
git clone https://github.com/nhartland/dotfiles ~/dotfiles
~/dotfiles/scripts/bootstrap-debian.sh
```
