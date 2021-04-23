# Move as many dotfiles as possible out of the $HOME directory into the various
# XDG directories.

## zsh
# ~/.zsh_history -> $XDG_STATE_HOME/zsh/history
if [[ -z "$HISTFILE" ]]; then
  HISTFILE="$XDG_STATE_HOME/zsh/history"
  #mkdir -p "${HISTFILE:h}" # created by bootstrap script
fi

## less
# ~/.lesshst -> $XDG_STATE_HOME/less/history
if [[ -z "$LESSHISTFILE" ]]; then
  export LESSHISTFILE="$XDG_STATE_HOME/less/history"
  #mkdir -p "${LESSHISTFILE:h}" # created by bootstrap script
fi

## GnuPG
# ~/.gnupg -> $XDG_DATA_HOME/gnupg (or $XDG_CONFIG_HOME?)
if [[ -z "$GNUPGHOME" ]]; then
  export GNUPGHOME="$XDG_DATA_HOME/gnupg"
fi

## Golang
# ~/go -> $XDG_DATA_HOME/go
if [[ -z "$GOPATH" ]]; then
  export GOPATH="$XDG_DATA_HOME/go"
fi

## Node.js
# ~/.node_repl_history -> $XDG_STATE_HOME/node/repl_history
if [[ -z "$NODE_REPL_HISTORY" ]]; then
  export NODE_REPL_HISTORY="$XDG_STATE_HOME/node/repl_history"
  #mkdir -p "${NODE_REPL_HISTORY:h}" # created by bootstrap script
fi

## NPM
# ~/.npmrc -> $XDG_CONFIG_HOME/npm/config
if [[ -z "$NPM_CONFIG_USERCONFIG" ]]; then
  export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
fi
# ~/.npm -> $XDG_CACHE_HOME/npm
if [[ -z "$NPM_CONFIG_CACHE" ]]; then
  export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
fi
# Keep default for $NPM_CONFIG_TMP (/tmp).

## PostgreSQL
# ~/.psqlrc -> $XDG_CONFIG_HOME/postgresql/psqlrc
if [[ -z "$PSQLRC" ]]; then
  export PSQLRC="$XDG_CONFIG_HOME/postgresql/psqlrc"
fi
# ~/.psql_history -> $XDG_STATE_HOME/postgresql/psql_history
if [[ -z "$PSQL_HISTORY" ]]; then
  export PSQL_HISTORY="$XDG_STATE_HOME/postgresql/psql_history"
  #mkdir -p "${PSQL_HISTORY:h}" # created by bootstrap script
fi
# ~/.pgpass -> $XDG_CONFIG_HOME/postgresql/pgpass
if [[ -z "$PGPASSFILE" ]]; then
  export PGPASSFILE="$XDG_CONFIG_HOME/postgresql/pgpass"
fi
# ~/.pg_service.conf -> $XDG_CONFIG_HOME/postgresql/pg_service.conf
if [[ -z "$PGSERVICEFILE" ]]; then
  export PGSERVICEFILE="$XDG_CONFIG_HOME/postgresql/pg_service.conf"
fi

## Python
# The history file can't be relocated yet... Maybe some day.
# https://github.com/python/cpython/pull/13208

## wget
# ~/.wgetrc -> $XDG_CONFIG_HOME/wget/config
if [[ -z "$WGETRC" ]]; then
  export WGETRC="$XDG_CONFIG_HOME/wget/config"
fi
# ~/.wget-hsts -> $XDG_STATE_HOME/wget/hsts
alias wget='wget --hsts-file="$XDG_STATE_HOME/wget/hsts"'
#mkdir -p "$XDG_STATE_HOME/wget" # created by bootstrap script
