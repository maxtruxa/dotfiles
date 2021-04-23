# dotfiles

Tested on Debian 10 (Buster) and Debian 11 (Bullseye).

```sh
# Install prerequisites.
sudo apt install -y zsh git neovim
# tmux from buster repos is too old, install from backports.
if [ "$(lsb_release -si)" = "Debian" ] && [ "$(lsb_release -sc)" = "buster"]; then
    sudo apt install -y -t "buster-backports" tmux
else
    sudo apt install -y tmux
fi
# Clone the dotfiles repo to your home directory.
git clone https://github.com/maxtruxa/dotfiles.git ~/.dotfiles
# Run the install script.
sh ~/.dotfiles/install
# Change your default shell to Zsh.
chsh -s /bin/zsh
# Switch your current shell to Zsh.
exec zsh -l
# If prompted, accept the "Do you want to bootstrap your environment?" to
# automatically install Oh My Zsh, Powerlevel10k and related plugins.
```

If you are not me, make sure to update `~/.config/git/config`:
```sh
git config --global user.name 'Your Name'
git config --global user.email 'you@example.com'
# If you sign your commits:
git config --global user.signingKey 'your-gpg-key'
# If you don't sign your commits:
git config --global --unset user.signingKey
git config --global --unset commit.gpgSign
```

## TODO

- Merge `~/.config/zsh/bootstrap` into `install`.
- Install prerequisites from install script to further simplify installation (i.e. to enable `wget -qO - https://... | sh`).
- Check tmux version to link either `~/.config/tmux/config` or `~/.tmux.conf` if the version is <3.1.
- Implement "update check"?
- Implement `dotfiles` command for simpler management, allowing the user to select which files to update/keep.
- Detect and rename existing config files that are moved through env vars. Depending on the program either the one in `~/` or the one in `~/.config` takes precedence which is *very* confusing. For example, Git uses `~/.gitconfig` if it exists falls back to `~/.config/git/config` (which we want). On the other hand, tmux 
- Support offline mode.

## Customization Points

Git: `.config/git/config.local`

Neovim: TODO

tmux: `.config/tmux/config.local`

Zsh: `.config/zsh/{zlogin,zlogout,zprofile,zshenv,zshrc}.d/*.local.zsh`

The Zsh customization points have some special handling:
- The scripts in each subdirectory are executed in lexical order.
- A file with the `.local.zsh` extension masks a `.zsh` file with the same name (e.g. `10-foo.zsh` is masked by `10-foo.local.zsh`). This can be used to change or disable any part of the configuration with very little effort.
- You can also modify Oh My Zsh directly (custom plugins, etc.): `.local/share/oh-my-zsh`
