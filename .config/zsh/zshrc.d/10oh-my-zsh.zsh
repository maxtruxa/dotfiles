# Path to your oh-my-zsh installation.
export ZSH="$XDG_DATA_HOME/oh-my-zsh"

# Move cache out of $ZSH.
ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"

# Same value as default, but this allows the variable to be referenced before
# sourcing Oh My Zsh. This is important for the bootstrap script to work.
ZSH_CUSTOM="$ZSH/custom"

# Set name of the theme to load.
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Use case-sensitive completion.
# CASE_SENSITIVE="true"

# Use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and
# newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Format of the command execution timestamp shown in the history command output.
HIST_STAMPS="yyyy-mm-dd"

# Save completion dump file to cache directory instead of $ZDOTDIR/$HOME.
ZSH_COMPDUMP="$XDG_CACHE_HOME/zcompdump-${HOST/.*/}-${ZSH_VERSION}"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  git
  gitfast
  sudo
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
  ssh-agent
)

# Load tmux config from custom $XDG_CONFIG_HOME path. Oh My Zsh's tmux plugin
# adds an alias for "tmux" that uses this config file.
ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/config"

# Automatically attach to previous tmux session or start a new one if none was
# found.
ZSH_TMUX_AUTOSTART=true

# Source Oh My Zsh or prompt for automatic installation.
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  >&2 echo "Oh My Zsh is not installed."
  >&2 echo "Do you want to bootstrap your environment? [y/n]"
  read -sk1 do_bootstrap
  if [ "$do_bootstrap" = "y" ]; then
    # Source the script instead of just executing it. Otherwise `exec` at the
    # end of the script doesn't replace the current shell.
    source "$ZDOTDIR/bootstrap"
  else
    >&2 echo "You can bootstrap manually at any time:"
    >&2 echo "  source '$ZDOTDIR/bootstrap'"
  fi
fi
