#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Alias
if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

# PATH
if [ -e $HOME/.bash_extrapathes ]; then
	source $HOME/.bash_extrapathes
fi
