#!/bin/bash

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias srcinfo='makepkg --printsrcinfo > .SRCINFO'
alias ssh='TERM=xterm-256color ssh'
alias vim='nvim'
alias vi='nvim'
alias fssh='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

# add local bin to path
grep -q "$HOME/.local/bin" <<< "$PATH" \
	|| export PATH="$HOME/.local/bin:$PATH"

# add cargo bin to path
grep -q "$HOME/.local/share/cargo/bin" <<< "$PATH" \
	|| export PATH="$HOME/.local/share/cargo/bin:$PATH"

# xdg
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

# java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# rust cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# less
export LESSHISTFILE=-

# libice
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority

# arduino-cli
export ARDUINO_DIRECTORIES_USER="$XDG_DATA_HOME"/arduino

# pylint
export PYLINTHOME="$XDG_CACHE_HOME"/pylint

# cuda
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

# gtk2
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkr

# gpg
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg

# go
export GOPATH="$XDG_DATA_HOME"/go

show_color() {
    perl -e 'foreach $a(@ARGV){print "\e[48:2::".join(":",unpack("C*",pack("H*",$a)))."m \e[49m "; print "$a\n"};print "\n"' "$@"
}
