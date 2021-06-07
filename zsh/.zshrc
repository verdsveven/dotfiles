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
unset PROMPT_SP
setopt prompt_subst
LP_ENABLE_SHORTEN_PATH=0
PROMPT_DIRTRIM=1
PS1='[%n@%M %1~]${vcs_info_msg_0_}$ '

# Miscellaneous option
export KEYTIMEOUT=1		# Key timeout
export HISTFILE=~/.zsh_history	# History file
export SAVEHIST=10000		# History file
setopt INC_APPEND_HISTORY	# Append to history with each command
setopt HIST_IGNORE_ALL_DUPS	# Ignore all duplicate commands in history
comp_options+=(globdots)	# Include hidden files.

# Bindings
bindkey -v
bindkey "^[[P" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[4~" end-of-line

# Files to include
source $HOME/.config/aliasrc

# Install antigen
[ -f ~/.zsh/antigen.zsh ] || curl -L git.io/antigen --create-dirs -o ~/.zsh/antigen.zsh
source ~/.zsh/antigen.zsh

# Antigen plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen apply
