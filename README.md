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

### Linux

Debian (bookworm or newer), shell sessions only:

```Shell
git clone https://github.com/nhartland/dotfiles ~/dotfiles
~/dotfiles/scripts/bootstrap-debian.sh
```
