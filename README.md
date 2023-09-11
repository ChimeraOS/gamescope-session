# Steam Big Picture Mode session based on Valve's [`gamescope`](https://github.com/Plagman/gamescope)

This project is not affiliated with Valve (wide inspiration was taken from
their work on the Steam Deck) and is part of the ChimeraOS project. Regardless
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

# License & Contributing

The project is licensed under MIT license. If you want to contribute,
just do so and thank you.
