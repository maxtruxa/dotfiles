# dotfiles

Tested on Debian 10 (Buster) and Debian 11 (Bullseye).

```sh
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

If you are not me, make sure to update `~/.config/git/config` or even better,
add your desired changes to `~/.config/git/config`:
```sh
git config -f ~/.config/git/config.local user.name 'Your Name'
git config -f ~/.config/git/config.local user.email 'you@example.com'
# If you sign your commits:
git config -f ~/.config/git/config.local user.signingKey 'your-gpg-key'
# If you don't sign your commits:
git config -f ~/.config/git/config.local user.signingKey ''
git config -f ~/.config/git/config.local commit.gpgSign false
```

## TODO

- Merge `~/.config/zsh/bootstrap` into `install`.
- Enable `wget -qO - https://.../install | sh`.
- Check tmux version to link either `~/.config/tmux/config` or `~/.tmux.conf` if
  the version is <3.1.
- Implement "update check"?
- Implement `dotfiles` command for simpler management, allowing the user to
  select which files to update/keep.
- Detect and rename existing config files that are moved through env vars.
  Depending on the program either the one in `~/` or the one in `~/.config`
  takes precedence which is *very* confusing.
- Support offline mode.

## Customization Points

Git: `.config/git/config.local`

Neovim: `.config/nvim/init.vim.d/*.vim`

tmux: `.config/tmux/config.local`

Zsh: `.config/zsh/{zlogin,zlogout,zprofile,zshenv,zshrc}.d/*.zsh`

The Zsh customization points have some special handling:
- The scripts in each subdirectory are executed in lexical order.
- A file with the `.local.zsh` extension masks a `.zsh` file with the same
  basename (e.g. `10-foo.local.zsh` masks `10-foo.zsh`). This can be used to
  change or disable any part of the configuration with very little effort.
- You can also modify Oh My Zsh directly (custom plugins, etc.):
  `.local/share/oh-my-zsh`
