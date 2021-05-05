" Make g:xdg_data_home and g:xdg_state_home available to the rest of the script.
let g:xdg_data_home = $XDG_DATA_HOME
if empty(g:xdg_data_home)
  let g:xdg_data_home = $HOME . '/.local/share'
endif
let g:xdg_state_home = $XDG_STATE_HOME
if empty(g:xdg_state_home)
  let g:xdg_state_home = $HOME . '/.local/state'
endif
