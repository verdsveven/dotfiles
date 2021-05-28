install:
	stow */ -t ${HOME}/

uninstall:
	stow */ -Dt ${HOME}/

reinstall:
	stow */ -Rt ${HOME}/
