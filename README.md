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
### vim
vim plugins are setup in the vim8 standard way, located at "vim/pack/plugins/"
for compatibility with vim7, pathogen is used to mirror these plugins.
