#!/usr/bin/env bash

if [ "$1" == "--unity" ] || [ "$1" == "-u" ] ; then
  DBUS_LOCK="interface='com.canonical.Unity.Session'"
  LOCK_SIGNAL="Locked"
  UNLOCK_SIGNAL="Unlocked"
elif [ "$1" == "--gnome" ] ||  [ "$1" == "-g" ] ; then
  DBUS_LOCK="interface='org.gnome.ScreenSaver',member='ActiveChanged'"
  LOCK_SIGNAL="true"
  UNLOCK_SIGNAL="false"
else
echo "Please specify the desktop you are using.
Available options:
 -u --unity : Unity
 -g --gnome : GNOME"

fi
dbus-monitor --session "type='signal',$DBUS_LOCK" | \
(
  # variable to check, whether we paused on lock
  PAUSED_PLAYER="none"
  # D-Bus objects, methods, etc. we need to controll Rhythmbox
  RHYTHMBOX="org.mpris.MediaPlayer2.rhythmbox"
  MEDIAPLAYER="/org/mpris/MediaPlayer2"
  GET_PROPERTIES="org.freedesktop.DBus.Properties.Get"
  PLAYER="org.mpris.MediaPlayer2.Player"
  
  while true; do
    read X
    # pause on lock
    if echo "$X" | grep "$LOCK_SIGNAL" &> /dev/null; then
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
        if  dbus-send --print-reply --dest="$RHYTHMBOX" "$MEDIAPLAYER" \
          "$GET_PROPERTIES" string:$PLAYER string:'PlaybackStatus' | \
          grep 'Playing' &> /dev/null; then
          dbus-send --print-reply --dest="$RHYTHMBOX" "$MEDIAPLAYER" \
            "$PLAYER".Pause &> /dev/null
          PAUSED_PLAYER="rhythmbox"
        fi
      fi
    fi
    # resume on unlock
    if echo "$X" | grep "$UNLOCK_SIGNAL" &> /dev/null; then
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
          dbus-send --print-reply --dest="$RHYTHMBOX" "$MEDIAPLAYER" \
            "$PLAYER".Play &> /dev/null
        fi
      fi
      # reset PAUSED_PLAYER variable
      PAUSED_PLAYER="none"
    fi
  done
)
