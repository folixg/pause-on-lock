#!/usr/bin/env bash

dbus-monitor --session "type='signal',interface='com.canonical.Unity.Session'" | \
(
  # variables to check, whether we paused on lock
  CLEMENTINE_PAUSED=0
  SPOTIFY_PAUSED=0
  RHYTHMBOX_PAUSED=0
  QUODLIBET_PAUSED=0

  while true; do
    read X
    # pause on lock
    if echo $X | grep 'Locked' &> /dev/null; then
      # clementine
      if qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus 2>/dev/null | grep 'Playing' &> /dev/null; then
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause &> /dev/null
        CLEMENTINE_PAUSED=1
      fi
      # spotify
      if qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus 2> /dev/null | grep 'Playing' &> /dev/null; then
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause &> /dev/null
        SPOTIFY_PAUSED=1
      fi
      # rhythmbox
      if qdbus org.mpris.MediaPlayer2.rhythmbox /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus 2> /dev/null | grep 'Playing' &> /dev/null; then
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.rhythmbox /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause &> /dev/null
        RHYTHMBOX_PAUSED=1
      fi
      # quod libet
      if qdbus net.sacredchao.QuodLibet /net/sacredchao/QuodLibet net.sacredchao.QuodLibet.IsPlaying 2> /dev/null | grep 'true' &> /dev/null; then
	dbus-send --print-reply --dest=net.sacredchao.QuodLibet /net/sacredchao/QuodLibet net.sacredchao.QuodLibet.Pause &> /dev/null
        QUODLIBET_PAUSED=1
      fi
    fi
    # resume on unlock
    if echo $X | grep 'Unlocked' &> /dev/null; then
      # clemetine
      if [ $CLEMENTINE_PAUSED -eq 1 ] &> /dev/null; then
        if qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus | grep 'Paused' &> /dev/null; then
          dbus-send --print-reply --dest=org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play &> /dev/null
          CLEMENTINE_PAUSED=0
        fi
      fi
      # spotify
      if [ $SPOTIFY_PAUSED -eq 1 ] &> /dev/null; then
        if qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus | grep 'Paused' &> /dev/null; then
          dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play &> /dev/null
          SPOTIFY_PAUSED=0
        fi
      fi
      # rhythmbox
      if [ $RHYTHMBOX_PAUSED -eq 1 ] &> /dev/null; then
        if qdbus org.mpris.MediaPlayer2.rhythmbox /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus | grep 'Paused' &> /dev/null; then
          dbus-send --print-reply --dest=org.mpris.MediaPlayer2.rhythmbox /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play &> /dev/null
          RHYTHMBOX_PAUSED=0
        fi
      fi
      # rhythmbox
      if [ $QUODLIBET_PAUSED -eq 1 ] &> /dev/null; then
        if qdbus net.sacredchao.QuodLibet /net/sacredchao/QuodLibet net.sacredchao.QuodLibet.IsPlaying 2> /dev/null | grep 'false' &> /dev/null; then
	  dbus-send --print-reply --dest=net.sacredchao.QuodLibet /net/sacredchao/QuodLibet net.sacredchao.QuodLibet.Play &> /dev/null
          QUODLIBET_PAUSED=0
        fi
      fi
    fi
  done
)
