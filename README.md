# Dotfiles
* There is really not too much to say, these are just my dotfiles, but below are the main points that you need to know
* These are work in progress btw

## .vimrc
* There is a script that automatically downloads the vim-plug plugin manager if it is not already installed (I got this from the github of the developer: https://github.com/junegunn/vim-plug)
* My .vimrc contains plugins that I personally use (with vim-plug as a plugin manager), but the list is easily editable and expandable.   
* It also contains some useful scripts to autcompile LaTeX documents with automatic bibliography creation with biber. There is also a script to open the generated pdf in zathura for live viewing. The mappings for these are easily changed; feel free to do so.
* There is also a script which loads .Xresources mapped to f5 for the xdefaults filetype

## .Xresources with dwm and st
* I use dwm and the suckless terminal with the colourschemes from the .Xresources file which imports the the colours from pywal; this makes ricing them so much easier :)
* I have an autostart.sh script for dwm which essentially runs everything I need on startup (I don't use Xinit and therefore need it to run the compositor and the xsetroot for dwm as an example)

## Picom
* This used to be compton instead; this config also works for it, but you need to change the filename and the directory.
* I haven't changed too much on this config except set the refresh rate manually and enabled shadows (cuz they are aesthetic :D)

### Closing statement:
* That's it, there is probably more coming in the future. Please feel free to let me know if anything can be improved or if there is a better way to do something; I would appreciate that gravely!
