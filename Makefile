.SILENT:
install:
	stow --target=${HOME} -S */
	echo "Done"
uninstall:
	stow --target=${HOME} -Dv */
	echo "Done"
