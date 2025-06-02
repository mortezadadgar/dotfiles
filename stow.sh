#!/bin/bash

usage() {
	printf "Usage: %s: [ install ] [ uninstall ]\n" "${0##*/}"
	exit 2
}

read -ra dirs < <(find . -maxdepth 1 -type d \
	-not -name "suckless" -not -name ".git" -not -name "." \
	-printf "%f ")

case "$1" in
	install)
		stow --target="${HOME}" -S "${dirs[@]}"
		;;
	uninstall)
		stow --target="${HOME}" -Dv "${dirs[@]}"
		;;
	*)
		usage
		;;
esac
