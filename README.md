*Notice:* I did a rewrite in python which can handle more players (probably your
 favorite among them) by default and is also able to handle multiple players
 running at the same time (like if your watching a video in your browser and
 listening to music on your spotify or whatever you do). It's still an early
 release and I'd be happy if you gave it a try and let me know if something
 doesn't work for you.
 You can find visit the [github page](https://github.com/folixg/python-pauseonlock)
 or just install via `pip install pauseonlock`

![logo](header.png)

# pause-on-lock

Automatically pause your music player when the screen gets locked and resume
playback, once the screen is unlocked again.

## Supported desktop environments

Currently [Unity](https://launchpad.net/unity),
[Cinnamon](https://github.com/linuxmint/Cinnamon),
[GNOME](https://www.gnome.org/), [MATE](https://mate-desktop.org/),
[KDE](https://kde.org/), [POP!\_OS](https://pop.system76.com) and
[XFCE](https://www.xfce.org) are supported. The currently running desktop is
detected using `$XDG_CURRENT_DESKTOP`.

## Installation

Download the executable for the [latest
release](https://github.com/folixg/pause-on-lock/releases/download/v2.1.0/pause-on-lock)
and run

```
sudo install pause-on-lock /usr/local/bin/
```

If you don't have sudo rights or don't want a system-wide installation, change
the install destination directory to e.g. `$HOME/bin` (and make sure that that
folder is in your `$PATH`).

## Usage

### Rhythmbox and Spotify

By default pause-on-lock supports
[Rhythmbox](https://wiki.gnome.org/Apps/Rhythmbox) and
[Spotify](https://www.spotify.com/us/download/linux/). If you use no other
players, no further configuration is needed, you can simply run
`pause-on-lock`.

### User defined player

With the `--player` or `-p` flag you can provide the name of one additional
player that pause-on-lock will then handle. The player needs to provide a
[MPRIS](http://specifications.freedesktop.org/mpris-spec/latest/) D-Bus
interface (which is the case for most common media players) and the name you
provide needs to match the name used for the D-Bus interface. For example
[vlc](https://videolan.org) provides a D-Bus interface at
`org.mpris.MediaPlayer2.vlc` so all you need to do is call `pause-on-lock -p
vlc` and pause-on-lock will pause any running vlc instance when you lock your
screen.

**tl;dr** `pause-on-lock --player NAME` should work in most cases.

### Playerctl

If you want support for many different players and you have
[playerctl](https://github.com/acrisci/playerctl) installed, you can use the
`--playerctl` or `-c` flag to enable playerctl support in pause-on-lock. Then
all players that playerctl can handle are supported, without the need for
further configuration.

### Autostart

I strongly recommend to add the pause-on-lock executable to [Startup
Applications](https://help.ubuntu.com/stable/ubuntu-help/startup-applications.html)
(or the equivalent for your desktop environment), so it is run every time you
log in.
