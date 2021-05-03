# Steam Big Picture Mode session based on Valve's [`gamescope`](https://github.com/Plagman/gamescope)

This project is not affiliated with GamerOS (wide inspiration was taken from
their awesome work), nor Valve. It's just a personal experiment to make a couch
gaming experience similar to GamerOS without lightDM and a pure
Wayland/Xwayland session started by systemd.

Might work for you and you are encouraged to test it. Don't report to Valve or
GamerOS folks for this project. It might kill your kittens.

## Installation

A PKGBUILD will be available Soon(tm)

## Basic manual setup

First you'll need to make a template for the session (that way you can start
it in any console you want). This is a service file located in
`/etc/systemd/system/gamescope@.service`. Use the provided one. Thanks to the
[cage project](https://github.com/Hjdskes/cage/wiki/Starting-Cage-on-boot-with-systemd)
for the -shameless copy- inspiration.

Then you'll need to write a PAM file for the session. Copy the provided file to
`/etc/pam.d/gamescope`.

Then you'll need the executable file for the session. Copy the provided file to
`/usr/bin/gamescope-session`

Copy the configuration file to `/etc/gamescope-session.conf`. Then if you want
to configure your monitor resolution, just change the variables inside that
file.

Disable any other display manager you may have (i.e. `# systemctl disable
lightdm.service`) and then enable this one with `# systemctl enable
gamescope@tty1.service`. Reboot and you are done.

# License

I think this needs one, not sure which one but as long as you don't infringe
any of the projects's linked here licenses this is licensed under the
[WTFPL](http://www.wtfpl.net/). If you want to contribute, just do so and 
thank you.
