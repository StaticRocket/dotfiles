#!/bin/bash

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias srcinfo='makepkg --printsrcinfo > .SRCINFO'
alias ssh='TERM=xterm-256color ssh'
alias vim='nvim'
alias vi='nvim'
alias fssh='ssh \
	-o PreferredAuthentications=password \
	-o PubkeyAuthentication=no \
	-o UserKnownHostsFile=/dev/null \
	-o StrictHostKeyChecking=no'

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

complete -A command fordir
fordir() {
	local dir
	for dir in */; do
		if cd "$dir"; then
			setterm --foreground blue --bold on
			printf "%s\n" "$dir"
			setterm --default
			script -q /dev/null -c "$*" 2>&1 | \
				awk '{gsub("\r","\r  "); print "  " $0}'
			printf '\r'
			cd ..
		fi
	done
}

complete -A file disk-mount
disk-mount() {
	if [ ! -e "$1" ]; then
		printf "%s\n" "Path not valid!"
		return 1
	fi
	sudo partx -a -v "$1"
}

complete -G '/dev/loop[0-9]' disk-umount
disk-umount() {
	if [ ! -e "$1" ]; then
		printf "%s\n" "Path not valid!"
		return 1
	fi
	sudo umount "$1"*
	sudo partx -d -v "$1"
	sudo losetup -d "$1"
}

_disk-extend() {
	mapfile -t COMPREPLY < <(
		compgen -W "$(lsblk -asrno path 2> /dev/null)" -- "$2"
	)
}
complete -F _disk-extend disk-extend
disk-extend() {
	local TARGET_BLOCK PARENT_BLOCK TARGET_NUMBER RELATED_BLOCKS
	mapfile -t RELATED_BLOCKS < <(
		lsblk -asrno path "$1" 2> /dev/null
	)
	TARGET_BLOCK=${RELATED_BLOCKS[0]}
	PARENT_BLOCK=${RELATED_BLOCKS[1]}
	TARGET_NUMBER=${TARGET_BLOCK: -1}
	if [ -z "$TARGET_BLOCK" ] || [ -z "$PARENT_BLOCK" ]; then
		printf "PARENT_BLOCK=%s\n" "${PARENT_BLOCK}"
		printf "TARGET_BLOCK=%s\n" "${TARGET_BLOCK}"
		printf "TARGET_NUMBER=%s\n" "${TARGET_NUMBER}"
		printf "%s\n" "Unable to detect target or parent block device!"
		return 1
	fi
	read -p "Extend $TARGET_BLOCK to cover all free space? [y/N] " \
		-r confirm
	if [ "$confirm" == "y" ]; then
		sudo parted "$PARENT_BLOCK" resizepart "$TARGET_NUMBER" 100%
		sudo fsck -y -f "$TARGET_BLOCK"
		sudo resize2fs "$TARGET_BLOCK"
	else
		printf "%s\n" "Aborting!"
		return 1
	fi
}

git-worktree-reattach() {
	local worktree_path gitdir_path
	if [ ! -f ".git" ]; then
		printf "%s\n" \
			"Not at root of git worktree!"
		return 1
	fi
	worktree_path=$(grep -P -o '(?<=gitdir:\s).*' .git)
	gitdir_path="$worktree_path/gitdir"
	if [ -f "$gitdir_path" ]; then
		printf "%s\n" "$PWD/.git" > "$gitdir_path"
	else
		printf "%s\n" \
			"Unable to find gitdir file at: $gitdir_path"
		return 1
	fi
}

git-tree() {
	git log --graph --simplify-by-decoration --pretty=format:'%d' --all
}

podman-clean-externals() {
	local containers
	if [ -n "$(podman container ls -q)" ]; then
		printf "%s\n" \
			"Please stop all running containers first!"
		return 1
	fi
	containers=$(podman container ls --external --format '{{.ID}}')
	for id in $containers; do
		printf "%s\n" "Removing $id"
		podman container rm -f "$id"
	done
}

complete -A directory arm-chroot
arm-chroot() {
	if [ ! -e "$1" ]; then
		printf "%s\n" "Path not valid!"
		return 1
	fi
	sudo -E systemd-nspawn -q -M "arm-chroot" \
		--bind /usr/bin/qemu-aarch64-static \
		--resolv-conf=copy-host \
		-E TERM=linux \
		-E https_proxy \
		-E http_proxy \
		-E ftp_proxy \
		-E no_proxy \
		-D "$1" \
		/bin/bash
}
