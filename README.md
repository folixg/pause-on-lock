![logo](header.png)

# pause-on-lock

Automatically pause your music player when the screen gets locked and resume
playback, once the screen is unlocked again.

## Supported desktop environments

Currently [Unity](https://launchpad.net/unity),
[Cinnamon](https://github.com/linuxmint/Cinnamon),
[GNOME](https://www.gnome.org/), [MATE](https://mate-desktop.org/) and 
[KDE](https://kde.org/) are supported. The currently running desktop is
detected using `$XDG_CURRENT_DESKTOP`.

## Supported players

By default pause-on-lock supports
[Rhythmbox](https://wiki.gnome.org/Apps/Rhythmbox) and
[Spotify](https://www.spotify.com/us/download/linux/). If you want support
for more players, you can install
[playerctl](https://github.com/acrisci/playerctl). If playerctl is installed
pause-on-lock supports all players that playerctl can handle.

## Installation

Download the executable for the [latest
release](https://github.com/folixg/pause-on-lock/releases/latest) and run

```
sudo install pause-on-lock /usr/local/bin/
```

If you don't have sudo rights or don't want a system-wide installation, change
the install destination directory to e.g. `$HOME/bin` (and make sure that that
folder is in your `$PATH`).

## Usage

Simply run `pause-on-lock`, there is no further configuration needed.
I strongly recommend to add the pause-on-lock executable to [Startup Applications](https://help.ubuntu.com/stable/ubuntu-help/startup-applications.html),
so it is run every time you log in.

## Compatibility

Should work with all Ubuntu releases >= 16.04
