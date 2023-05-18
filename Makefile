.SILENT:
install:
	mkdir -p ${HOME}/.local/share
	stow --target=${HOME} -S */
	echo "Done"
uninstall:
	stow --target=${HOME} -Dv */
	echo "Done"
