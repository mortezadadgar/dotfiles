#!/bin/bash

usage() {
	printf "Usage: %s: [ install ] [ uninstall ]\n" "${0##*/}"
	exit 2
}

excludeDirs=(
	"suckless"
	".git"
	"root"
	"."
)

findargs=()
for dir in "${excludeDirs[@]}"; do
	findargs+=("-not" "-name" "$dir")
done

read -ra dirs < <(find . -maxdepth 1 -type d "${findargs[@]}" -printf "%f ")

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
