#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# PATH
if [ -e $HOME/.bash_extrapathes ]; then
	source $HOME/.bash_extrapathes
fi

# Alias
if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi
