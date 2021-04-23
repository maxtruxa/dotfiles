# Source dircolors.
if (( $+commands[dircolors] )); then
  if [[ -r "$XDG_CONFIG_HOME/coreutils/dircolors" ]]; then
    eval "$(dircolors -b "$XDG_CONFIG_HOME/coreutils/dircolors")"
  else
    eval "$(dircolors -b)"
  fi
fi
