# Steam Big Picture Mode session based on Valve's [`gamescope`](https://github.com/Plagman/gamescope)

This project is not affiliated with Valve (wide inspiration was taken from
their work on teh SteamDeck) and is part of the ChimeraOS project. Regardless
is generic enough and aims to be usable on any distribution. If you have any
issues with it, just report them on teh issue tracker.

## Installation

A PKGBUILD for Archlinux is available [in the AUR](https://aur.archlinux.org/packages/gamescope-session-git).

## Basic manual setup

Copy this repository file structure into the appropriate places and you'll be
able to start the session on any Display Manager of your choice.

# Configuration

The session sources environment from `~/.config/environment.d/*.conf` files.
The easiest way to configure the session is to create `~/.config/environment.d/gamescope-session.conf`
and set variables there:

```
# Size of the screen. If not set gamescope will detect native resolution from drm.
SCREEN_HEIGHT=2160
SCREEN_WIDTH=3840

# Override entire Steam client command line
STEAMCMD="steam -steamos -pipewire-dmabuf -gamepadui"

# Override the entire Gamescope command line
# This will not use screen and render sizes above
GAMESCOPECMD="gamescope -e -f"
```

# Session switch

A session switcher script is provided to be used by the session to exit to the
Display Manager of choice. The script will look for a special file
`/usr/lib/os-session-select` to handoff the control of the session. If the file
does not exist it will just exit steam.

# Using the session without Steam

If you would like to run an arbitrary application in gamescope-session instead of Steam, prepare for a bit of an adventure.

Firstly, gamescope embedded mode (which is used by gamescope-session) is tightly integrated with Steam. Your application will have to essentially emulate what Steam does when interacting with gamescope.

Steam interacts with gamescope by setting properties on Xorg windows. By default, if you launch an application with the gamescope session by overriding the `STEAMCMD` environment variable you may notice that you only see a black screen. That is because gamescope will only show windows when the `STEAM_GAME` property is present on the window. In most cases, all you will need to do is set this property on your application window to any value and the window should appear.

One way to do this is to use the ChimeraOS [gamescope-fg](https://github.com/ChimeraOS/chimera/blob/master/bin/gamescope-fg) tool to launch your application, like so:

`gamescope-fg my-application arg1 arg2 ... argN`

If you are building a launcher or application that will use multiple windows, you should set `STEAM_GAME` to a value of `769` on your main window. This value indicates to gamescope that this is the main application running and is used by Steam for its own window.

For any other applications or windows that are opened you must set `STEAM_GAME` to any value (other than `769`) and gamescope will display those windows on top of your main window. Once the new window is closed, the main application will be displayed again. When launching games, Steam sets `STEAM_GAME` to the app id of the Steam game that is launched. There are several hacks in gamescope for specific games that rely on this id.

TODO: document how overlays work: i.e. `STEAM_OVERLAY` and `GAMESCOPE_EXTERNAL_OVERLAY`
TODO: document how to use multiple xwayland displays


# License & Contributing

The project is licensed under MIT license. If you want to contribute,
just do so and thank you.
