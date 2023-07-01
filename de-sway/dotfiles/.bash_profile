# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  # Define global variables needed for Sway
  export XDG_DATA_HOME=${HOME}/.local/share
  export XDG_CONFIG_HOME=${HOME}/.config
  export XDG_STATE_HOME=${HOME}/.local/state
  # XDG local bin folder, needs to go into PATH variable - $HOME/.local/bin.
  export XDG_DATA_DIRS=/usr/local/share/:/usr/share/
  export XDG_CONFIG_DIRS=/etc/xdg
  export XDG_CACHE_HOME=${HOME}/.cache
  # XDG_RUNTIME_DIR - Defined by SwayVM
  export XDG_CURRENT_DESKTOP=sway

  # Run sway
  exec sway
fi
