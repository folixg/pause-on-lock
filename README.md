# pause-on-lock
Simple script that pauses your music player, when the screen gets locked and
resumes playback once the screen is unlocked again.

### Supported desktop environments
Currently [Unity](https://launchpad.net/unity) and [GNOME](https://www.gnome.org/)
are supported. The currently running desktop is detected using
`$XDG_CURRENT_DESKTOP`.

### Supported players

If you have [playerctl](https://github.com/acrisci/playerctl) installed (which is
recommended), it supports all players that playerctl can handle.
Without playerctl the only supported player is [Rhythmbox](https://wiki.gnome.org/Apps/Rhythmbox).

### Usage
1. Download the [latest release](https://github.com/folixg/pause-on-lock/releases/latest)
2. Extract the archive to a directory of your choosing.
3. Add the pause-on-lock executable to [Startup Applications](https://help.ubuntu.com/stable/ubuntu-help/startup-applications.html), so it is run every time you log in.
4. Log out and back in again.


Tested with Ubuntu 16.04, 17.04 and 17.10.
