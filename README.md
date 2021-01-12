### Using this repo as a [bare repository](https://www.atlassian.com/git/tutorials/dotfiles)
Run setup script
```bash
git clone --bare https://github.com/DragonL40/dotfiles $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```

### neovim
> For Arch Linux
install neovim 
```
yay -S neovim-nightly-bin
```
install neovim python module
```
sudo pacman -S python-pynvim
```
install vim-plug
```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
