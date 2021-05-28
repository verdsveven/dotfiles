# Dotfiles
* Just my dotfiles, but below are the main points that you need to know
* These are work in progress; so keep that in mind

## Some notes on installation
* The (re/un)install process is automated with a very simple Makefile utilising GNU stow commands (see Makefile)

### General instructions:
* Clone the repository with git clone (wherever you prefer)
* cd into the directory wherein the repository was cloned and run the following commands depending on use case:

### To install:
```sh
make install
```

### To uninstall:
```sh
make uninstall
```

### To apply changes after pulling (reinstall):
```sh
make reinstall
```

## .vimrc
* This includes a script that automatically downloads the vim-plug plugin manager if it is not already installed (I got this from the github of the developer: https://github.com/junegunn/vim-plug)
* My .vimrc contains plugins that I personally use (with vim-plug as a plugin manager), but the list is easily editable and expandable.   
* It also contains some useful scripts to autcompile LaTeX documents with automatic bibliography creation with biber. There is also a script to open the generated pdf in zathura for live viewing. The mappings for these are easily changed; feel free to do so.
	* Additional bindings for compiling pandoc markdown to different formats (see .vimrc)
	* Newly-included bindings for compiling lilypond scores
* There is also a script which loads .Xresources mapped to f5 for the xdefaults filetype
	* i.e. when .Xresources is edited, one can apply the changes with f5

## .Xresources with dwm and st
* I use dwm and the suckless terminal with the colourschemes from the .Xresources file which imports the the colours from pywal
* autostart.sh script for dwm -- runs everything I need on startup
	* Relies on some scripts from my useful_scripts repository; namely script_lnchr.sh

## Picom
* This used to be compton instead; this config also works for it, but you need to change the filename and the directory.
* Needs rework!
