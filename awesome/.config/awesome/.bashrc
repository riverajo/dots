# If not running interactively, don't do anything
[ -z "$PS1" ] && return
source /etc/bash/bashrc
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
PS1="\[\e[01;32m\]\W \$ \[\e[00m\]"

#PYTHONSTARTUP=~/.pythonrc.py
#export PYTHONSTARTUP

complete -cf sudo
export LESSCOLOR="always"
export PATH=~/bin:$PATH
eval "$(dircolors)"
unset TMOUT
eval `keychain --eval --quiet`
set -o vi
set editing-mode vi
set keymap vi-command
set show-all-if-ambiguous on
set keymap vi-insert
