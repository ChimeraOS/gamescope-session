# Gamescope session plus based on Valve's [`gamescope`](https://github.com/Plagman/gamescope)

This project is not affiliated with Valve (inspiration was taken from
their work on the Steam Deck). It is part of the ChimeraOS project, but
aims to be usable on any distribution. Please report issues to the issue tracker.

Note that this project by itself does not provide any actual user session and only provides the common
files needed by actual sessions such as https://github.com/ChimeraOS/gamescope-session-steam or https://github.com/ShadowBlip/OpenGamepadUI-session.

## Installation

A PKGBUILD for Archlinux is available [in the AUR](https://aur.archlinux.org/packages/gamescope-session-git).

## Basic manual setup

Copy this repository file structure into the appropriate places and you'll be
able to start any available sessions on the Display Manager of your choice.

# User Configuration

The session sources environment from `~/.config/environment.d/*.conf` files.
The easiest way to configure the session is to create `~/.config/environment.d/gamescope-session-plus.conf`
and set variables there:

```sh
# Size of the screen. If not set gamescope will detect native resolution from drm.
SCREEN_HEIGHT=2160
SCREEN_WIDTH=3840

# Override entire client command line
CLIENTCMD="steam -steamos -pipewire-dmabuf -gamepadui"

# Override the entire Gamescope command line
# This will not use screen and render sizes above
GAMESCOPECMD="gamescope -e -f"

# Overwrites only the basic call to composer (useful if composer is on a different path).
# In this case, the remaining arguments are also set automatically.
GAMESCOPECMD_BASE="/usr/bin/gamescope"

#Define this if you want composer to run with this option
ENABLE_GAMESCOPE_WSI=1

#If desired, define an additional command that must be executed before starting the gamescope
BEFORE_GAMESCOPE_SESSION_PLUS="/bin/turn_on_tv.sh"

#If desired, define an additional command that will be executed after the session ends
AFTER_GAMESCOPE_SESSION_PLUS="/bin/turn_off_tv.sh"
```

# Creating a custom session

Let's say we want to create a session that simply plays a video.

First, we create `/usr/share/gamescope-session-plus/sessions.d/video` to define the session.
This file must define `CLIENTCMD` which specific the command to run as the main application of the session.
In this example we add:
`CLIENTCMD="vlc my-video.mp4"`

We can also define the `short_session_recover` function in this file which is called when the session fails to start.

We also need to create `/usr/share/wayland-sessions/gamescope-session-video.desktop`
defining the session so it appears as an option in our Display Manager/Login screen.

In our example, this could be:
```
[Desktop Entry]
Encoding=UTF-8
Name=Video
Comment=A session to play a video
Exec=gamescope-session-plus video
Type=Application
DesktopNames=gamescope
```

Note that the Exec must call `gamescope-session-plus` with the parameter value corresponding to the file that we placed under `/usr/share/gamescope-session-plus/sessions.d/`.


See https://github.com/shadowblip/opengamepadui-session for a real-life example of a gamescope session.


## Window visibility

If you would like to run an arbitrary application in a gamescope session, prepare for a bit of an adventure.

Gamescope embedded mode (which is used by gamescope-session-plus) is tightly integrated with Steam. Your application will have to essentially emulate what Steam does when interacting with gamescope.

Steam interacts with gamescope by setting properties on Xorg windows. By default, if you launch an application with the gamescope session by overriding the `CLIENTCMD` environment variable you may notice that you only see a black screen. That is because gamescope will only show windows when the `STEAM_GAME` property is present on the window. In most cases, all you will need to do is set this property on your application window to any value and the window should appear.

One way to do this is to use the ChimeraOS [gamescope-fg](https://github.com/ChimeraOS/chimera/blob/master/bin/gamescope-fg) tool to launch your application, like so:

`gamescope-fg my-application arg1 arg2 ... argN`

If you are building a launcher or application that will use multiple windows, you should set `STEAM_GAME` to a value of `769` on your main window. This value indicates to gamescope that this is the main application running and is the value used by Steam for its own window.

For any other applications or windows that are opened you must set `STEAM_GAME` to any value (other than `769`) and gamescope will display those windows on top of your main window. Once the new window is closed, the main application will be displayed again. When launching games, Steam sets `STEAM_GAME` to the app id of the Steam game that is launched. There are several hacks in gamescope for specific games that rely on this id.

TODO:
 - document how overlays work: i.e. `STEAM_OVERLAY` and `GAMESCOPE_EXTERNAL_OVERLAY`
 - document how to use multiple xwayland displays


# License & Contributing

The project is licensed under MIT license. If you want to contribute,
just do so and thank you.
