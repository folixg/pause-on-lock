# pause-on-lock
Simple script that pauses your music player, when the screen gets locked and
resumes playback once the screen is un-locked again.

### Supported players

If you have [playerctl](https://github.com/acrisci/playerctl) installed (which I
recommend), it supports all players that playerctl can handle.

Without playerctl the following players are supported:
- [Clementine](https://www.clementine-player.org/)
- [Spotify](https://www.spotify.com/us/download/linux/)
- [Rhythmbox](https://wiki.gnome.org/Apps/Rhythmbox)
- [Quod Libet](https://quodlibet.readthedocs.io/en/latest/)
- [Google Play Music Desktop Player](https://www.googleplaymusicdesktopplayer.com)

Easily extendable for any player that uses the [MPRIS D-Bus Interface](https://specifications.freedesktop.org/mpris-spec/latest/).

### Usage
1. Put ```pause-on-lock.sh``` in any directory of your choosing.
2. Set the executable bit (i.e. ```chmod +x pause-on-lock.sh```).
3. Add the script to [Startup Applications](https://help.ubuntu.com/stable/ubuntu-help/startup-applications.html),
 so it is run every time you log in.
4. Log out and back in again.


Tested with Unity on Ubuntu 16.04 and 17.04.
