# pause-on-lock
Simple script that pauses your music player, when the screen gets locked and
resumes playback once the screen is un-locked again.

### Supported desktop environments
Currently [Unity](https://launchpad.net/unity) and [GNOME](https://www.gnome.org/)
are supported. You have to specify, which desktop your are using, when running the script.
```
# ./pause-on-lock.sh
Please specify the desktop you are using.
Available options:
 -u --unity : Unity
 -g --gnome : GNOME
```

### Supported players

If you have [playerctl](https://github.com/acrisci/playerctl) installed (which is
recommended), it supports all players that playerctl can handle.
Without playerctl the only supported player is [Rhythmbox](https://wiki.gnome.org/Apps/Rhythmbox).

### Usage
1. Put ```pause-on-lock.sh``` in any directory of your choosing.
2. Set the executable bit (i.e. ```chmod +x pause-on-lock.sh```).
3. Add the script to [Startup Applications](https://help.ubuntu.com/stable/ubuntu-help/startup-applications.html) (don't forget to specify your desktop environment) ,
 so it is run every time you log in.
4. Log out and back in again.


Tested with Ubuntu 16.04, 17.04 and 17.10.
