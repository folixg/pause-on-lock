# pause-on-lock
Simple script that pauses your music player, when the screen gets locked and
resumes playback once the screen is unlocked again.

### Supported desktop environments
Currently [Unity](https://launchpad.net/unity), [Cinnamon](https://github.com/linuxmint/Cinnamon)
and [GNOME](https://www.gnome.org/) are supported. The currently running
desktop is detected using `$XDG_CURRENT_DESKTOP`.

### Supported players
By default pause-on-lock supports [Rhythmbox](https://wiki.gnome.org/Apps/Rhythmbox)
and [Spotify](https://www.spotify.com/us/download/linux/).
If you want support for more players, you can install [playerctl](https://github.com/acrisci/playerctl).
If playerctl is installed pause-on-lock supports all players that playerctl
can handle.


### Installation
You can download the [latest release](https://github.com/folixg/pause-on-lock/releases/latest)
as source tarball.
Simply extract the sources to a directory of your choosing
(e.g. `/opt/pause-on-lock`). If you don't want to use the absolute path to run
pause-on-lock, make sure to create a symlink to the executable in a folder
that is in your `$PATH` (e.g. `ln -s /opt/pause-on-lock/pause-on-lock $HOME/bin`). 

### Usage
Simply run `pause-on-lock`, there is no further configuration needed.
I strongly recommend to add the pause-on-lock executable to [Startup Applications](https://help.ubuntu.com/stable/ubuntu-help/startup-applications.html),
so it is run every time you log in.


Should run with all Ubuntu releases >= 16.04
