# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
fi


# Put your fun stuff here.
complete -cf sudo

# Incremental search.
# See: https://sites.google.com/site/hashemian/home/tips-and-tricks/the-blog/amoreconvenientincrementalsearchinterminalbashlinux
# https://sites.google.com/site/hashemian/home/tips-and-tricks/convenient-terminal-search
export HISTFILESIZE=10000               # Max number of lines in HISTFILE
export HISTSIZE=10000                   # Number of lines to save from current session
shopt -s histappend                     # Append to history file rather than overwriting
export HISTCONTROL=erasedups    # Don't store duplicate commands
