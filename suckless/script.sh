#!/bin/bash
set -eu


B="\033[1m"
b="\033[0m"

# TODO: pin git commit
readonly repos=(
	"git://git.suckless.org/dmenu" 
	"git://git.suckless.org/slock"
	"git://git.suckless.org/st"
)

for repo in "${repos[@]}"; do
	repo_name="${repo/#*\//}"
	patches_dir="repos/${repo_name}/patches"

	echo -e "---- ${B}${repo_name}${b} ---"
	if [ ! -d "repos/$repo_name" ]; then
		if git submodule add --force "$repo" "repos/$repo_name"; then
			echo -e "Added repo"
		fi
	else
		echo -e "Repo already exists"
	fi

	if [ ! -d  "$patches_dir" ]; then
		mkdir "$patches_dir"
	fi

	for file in patches/"$repo_name"/*.patch; do
		patch="${file##*/}"

		if [ ! -f "$patches_dir/$patch" ]; then
			cp "$file" "$patches_dir"
			if git -C "repos/$repo_name" am --quit -3 "patches/$patch"; then
				echo -e "Applied patch: $patch"
			fi
		else
			echo -e "Excluded patch: $patch"
		fi
	done

	# build and install
	if sudo make -s -C "repos/$repo_name" install; then
		echo -e "Installed binary"
	fi
done
