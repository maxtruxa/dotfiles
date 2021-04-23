# Set various environment variables as specified by the XDG Base Directory
# Specification, so any further configuration can rely on these vars to be set.
[[ -z "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME="$HOME/.config"
[[ -z "$XDG_DATA_HOME" ]] && export XDG_DATA_HOME="$HOME/.local/share"
[[ -z "$XDG_STATE_HOME" ]] && export XDG_STATE_HOME="$HOME/.local/state"
[[ -z "$XDG_CACHE_HOME" ]] && export XDG_CACHE_HOME="$HOME/.cache"

# Should have been set already by systemd.
[[ -z "$XDG_RUNTIME_DIR" ]] && export XDG_RUNTIME_DIR="/run/usr/$UID"
if [[ ! -w "$XDG_RUNTIME_DIR" ]]; then
  >&2 echo "\$XDG_RUNTIME_DIR $XDG_RUNTIME_DIR is not writable. Falling back to /tmp."
  export XDG_RUNTIME_DIR="/tmp"
fi
