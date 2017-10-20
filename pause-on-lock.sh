#!/usr/bin/env bash

dbus-monitor --session "type='signal',interface='com.canonical.Unity.Session'" | \
(
  # variable to check, whether we paused on lock
  PAUSED_PLAYER="none"

  while true; do
    read X
    # pause on lock
    if echo "$X" | grep 'Locked' &> /dev/null; then
      # with playerctl
      if [ "$(playerctl --version 2>/dev/null)" ]; then
        # get list of running players
        read -a players <<< $(playerctl --list-all)
        # check whether a player is playing
        for player in "${players[@]}"
        do
          if [ "$(playerctl --player="$player" status)" = "Playing" ] ; then
            # and pause it
            playerctl --player="$player" pause
            PAUSED_PLAYER=$player
          fi
        done
      # without playerctl  
      else
        if  dbus-send --print-reply --dest=org.mpris.MediaPlayer2.rhythmbox /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' 2>/dev/null | grep 'Playing' &> /dev/null; then
          dbus-send --print-reply --dest=org.mpris.MediaPlayer2.rhythmbox /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause &> /dev/null
          PAUSED_PLAYER="rhythmbox"
        fi
      fi
    fi
    # resume on unlock
    if echo "$X" | grep 'Unlocked' &> /dev/null; then
      # with playerctl
      if [ "$(playerctl --version 2>/dev/null)" ]; then
        # did we pause a player on lock?
        if [ "$PAUSED_PLAYER" != "none" ]; then
          playerctl --player="$PAUSED_PLAYER" play
        fi
      # without playerctl
      else
        # did we pause on lock?
        if [ "$PAUSED_PLAYER" = "rhythmbox" ] ; then
          dbus-send --print-reply --dest=org.mpris.MediaPlayer2.rhythmbox /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play &> /dev/null
        fi
      fi
      # reset PAUSED_PLAYER variable
      PAUSED_PLAYER="none"
    fi
  done
)
