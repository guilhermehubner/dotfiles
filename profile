# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# the files are located in the bash-doc package.
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export TERM=xterm-256color

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export GOPATH=$HOME/go
setxkbmap -option caps:swapescape
xdotool key Caps_Lock
