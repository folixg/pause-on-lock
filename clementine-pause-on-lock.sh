#!/bin/bash

dbus-monitor --session "type='signal',interface='com.ubuntu.Upstart0_6'" | \
(
  PAUSED_ON_LOCK=0 #varibale to check, whether we paused on lock
  while true; do
    read X
    # lock & pause
    if echo $X | grep 'desktop-lock' &> /dev/null; then
      if qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus | grep 'Playing' &> /dev/null; then
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause &> /dev/null
        PAUSED_ON_LOCK=1
      fi
    fi
    # unlock & resume
    if echo $X | grep 'desktop-unlock' &> /dev/null; then
      if [ "$PAUSED_ON_LOCK" -eq "1" ] &> /dev/null; then
        if qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus | grep 'Paused' &> /dev/null; then
          dbus-send --print-reply --dest=org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play &> /dev/null
          PAUSED_ON_LOCK=0
        fi
      fi
    fi
  done
)
