# Dotfiles
* There is really not too much to say, these are just my dotfiles, but below are the main points that you need to know
* These are work in progress; so keep that in mind

## Some notes on installation
* Clone the repository with git clone as usual (wherever you prefer)
* These dotfiles are meant to be installed using stow, more specifically I use:

```
cd dotfiles
stow */
```
* cd into the directory into which you cloned the repository and not the dotfiles directory if you used a different directory
* Utilising stow */ avoids errors because of the README as it only selects directories and not files
* By default, stow installs into the parent directory of the current directory i.e. home if you clone it into home
	* If you don't clone it into the home directory you can use:

```
stow */ -t $HOME/
```

* -t here specifies the target directory. Look at man stow if you want other options

## .vimrc
* This includes a script that automatically downloads the vim-plug plugin manager if it is not already installed (I got this from the github of the developer: https://github.com/junegunn/vim-plug)
* My .vimrc contains plugins that I personally use (with vim-plug as a plugin manager), but the list is easily editable and expandable.   
* It also contains some useful scripts to autcompile LaTeX documents with automatic bibliography creation with biber. There is also a script to open the generated pdf in zathura for live viewing. The mappings for these are easily changed; feel free to do so.
	* Additional bindings for compiling pandoc markdown to different formats (see .vimrc)
	* Newly-included bindings for compiling lilypond scores
* There is also a script which loads .Xresources mapped to f5 for the xdefaults filetype
	* i.e. when .Xresources is edited, one can apply the changes with f5

## .Xresources with dwm and st
* I use dwm and the suckless terminal with the colourschemes from the .Xresources file which imports the the colours from pywal; this makes ricing them so much easier :)
* I have an autostart.sh script for dwm which essentially runs everything I need on startup (I don't use Xinit and therefore need it to run the compositor and the xsetroot for dwm as an example)
	* I have since switched to bspwm full time, but left this in here in the case that I want to come back to dwm at any time (there are actually some features that I miss).

## Picom
* This used to be compton instead; this config also works for it, but you need to change the filename and the directory.
* I haven't changed too much on this config except set the refresh rate manually and enabled shadows (cuz they are aesthetic :D)

## Closing statement:
* That's it, there is probably more coming in the future. Please feel free to let me know if anything can be improved or if there is a better way to do something; I would appreciate that gravely!
