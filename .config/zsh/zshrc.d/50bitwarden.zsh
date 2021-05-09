# Status
bws() {
  if ! (( $+commands[bw] )); then
    >&2 echo 'bw is not installed or not in your $PATH.'
    return 1
  fi
  if ! (( $+commands[jq] )); then
    >&2 echo 'jq is not installed or not in your $PATH.'
    return 1
  fi
  # If BW_SESSION is still set after locking, bw status
  # complains about the invalid session key.
  local bw_status_blob="$(bw status 2>/dev/null)"
  local bw_status="$(echo "$bw_status_blob" | jq -r '.status')"
  local bw_last_sync="$(echo "$bw_status_blob" | jq -r '.lastSync')"
  if [ "$bw_status" = 'unauthenticated' ]; then
    echo "\e[31mYou are logged out.\e[m"
    return 1
  elif [ "$bw_status" = 'locked' ]; then
    echo "\e[31mYour vault is locked. [last sync=$bw_last_sync]\e[m"
    return 1
  elif [ "$bw_status" = 'unlocked' ]; then
    echo "\e[32mYour vault is unlocked. [last sync=$bw_last_sync]\e[m"
  else
    echo "\e[33mUnknown Bitwarden status '$bw_status'\e[m"
    return 2
  fi
}

# Login and/or unlock
bwu() {
  if ! (( $+commands[bw] )); then
    >&2 echo 'bw is not installed or not in your $PATH.'
    return 1
  fi
  if ! (( $+commands[jq] )); then
    >&2 echo 'jq is not installed or not in your $PATH.'
    return 1
  fi
  # If BW_SESSION is still set after locking, bw status
  # complains about the invalid session key.
  local bw_status="$(bw status 2>/dev/null | jq -r '.status')"
  local bw_session
  if [ "$bw_status" = 'unauthenticated' ]; then
    bw_session="$(bw login --raw)"
    local err=$?
    [ $err -eq 0 ] || return $err
    export BW_SESSION="$bw_session"
  elif [ "$bw_status" = 'locked' ]; then
    bw_session="$(bw unlock --raw)"
    local err=$?
    [ $err -eq 0 ] || return $err
    export BW_SESSION="$bw_session"
  elif [ "$bw_status" = 'unlocked' ]; then
    >&2 echo '\e[32mYour vault is already unlocked.\e[m'
  else
    >&2 echo '\e[33mBitwarden: Huh?!\e[m'
    return 2
  fi
}

# Lock
bwl() {
  if ! (( $+commands[bw] )); then
    >&2 echo 'bw is not installed or not in your $PATH.'
    return 1
  fi
  bw lock
  unset BW_SESSION
}
