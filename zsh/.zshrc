# Autoload modules
autoload -Uz vcs_info compinit colors

colors
compinit
precmd(){
	vcs_info
}

zstyle ':vcs_info:git*' formats "(%b)"
zstyle ':completion:*' menu select

zmodload zsh/complist

# Prompt
setopt prompt_subst
LP_ENABLE_SHORTEN_PATH=0
PROMPT_DIRTRIM=1
PS1='[%n@%M %1~]${vcs_info_msg_0_}$ '

# Miscellaneous option
export KEYTIMEOUT=1		# Key timeout
comp_options+=(globdots)	# Include hidden files.

# Bindings
bindkey -v
bindkey "^[[P" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[4~" end-of-line

# Files to include
source $HOME/.config/aliasrc
