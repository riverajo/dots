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

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion


# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend

# Change the window title of X terminals 
case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|interix|tmux*)
        PS1="\[\e[01;32m\]\W \$ \[\e[00m\]"
		;;
	screen*)
		PS1='\[\033k\u@\h:\w\033\\\]'
		;;
	*)
		unset PS1
		;;
esac

# Save each command to the history file as it's executed.  #517342
# This does mean sessions get interleaved when reading later on, but this
# way the history is always up to date.  History is not synced across live
# sessions though; that is what `history -n` does.
# Disabled by default due to concerns related to system recovery when $HOME
# is under duress, or lives somewhere flaky (like NFS).  Constantly syncing
# the history will halt the shell prompt until it's finished.
PROMPT_COMMAND='history -a'

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.
# We run dircolors directly due to its changes in file syntax and
# terminal name patching.
use_color=false
if type -P dircolors >/dev/null ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	LS_COLORS=
	if [[ -f ~/.dir_colors ]] ; then
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -f /etc/DIR_COLORS ]] ; then
		eval "$(dircolors -b /etc/DIR_COLORS)"
	else
		eval "$(dircolors -b)"
	fi
	# Note: We always evaluate the LS_COLORS setting even when it's the
	# default.  If it isn't set, then `ls` will only colorize by default
	# based on file attributes and ignore extensions (even the compiled
	# in defaults of dircolors). #583814
	if [[ -n ${LS_COLORS:+set} ]] ; then
		use_color=true
	else
		# Delete it if it's empty as it's useless in that case.
		unset LS_COLORS
	fi
else
	# Some systems (e.g. BSD & embedded) don't typically come with
	# dircolors so we need to hardcode some terminals in here.
	case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|screen|tmux|cons25|*color) use_color=true;;
	esac
fi

if ${use_color} ; then
	if [[ ${EUID} == 0 ]] ; then
		PS1+='\[\033[01;31m\]\h\[\033[01;34m\] \w \$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	# show root@ when we don't have colors
	PS1+='\u@\h \w \$ '
fi

for sh in /etc/bash/bashrc.d/* ; do
	[[ -r ${sh} ]] && source "${sh}"
done

# Try to keep environment pollution down, EPA loves us.
unset use_color sh
# Put your fun stuff here.
docker-cleanup ()
{
    exited=$(docker ps -a -q -f status=exited);
    [[ -n "${exited}" ]] && docker rm -v ${exited};
    dangling=$(docker images -f "dangling=true" -q);
    [[ -n "${dangling}" ]] && docker rmi ${dangling};
    dangling_volumes=$(docker volume ls -qf dangling=true);
    [[ -n "${dangling_volumes}" ]] && docker volume rm ${dangling_volumes}
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -f "$HOME/.gc/google-cloud-sdk/path.bash.inc" ]] && source "$HOME/.gc/google-cloud-sdk/path.bash.inc"
[[ -f "$HOME/.gc/google-cloud-sdk/completion.bash.inc" ]] && source "$HOME/.gc/google-cloud-sdk/completion.bash.inc"
[[ -f "$HOME/.gc/google-cloud-sdk/path.bash.inc" ]] && source "$HOME/.gc/google-cloud-sdk/path.bash.inc"
[[ -f "$HOME/.gc/google-cloud-sdk/completion.bash.inc" ]] && source "$HOME/.gc/google-cloud-sdk/completion.bash.inc"
HISTCONTROL=ignoreboth

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#PYTHONSTARTUP=~/.pythonrc.py
#export PYTHONSTARTUP

complete -cf sudo
complete -cf man
export LESSCOLOR="always"
export PATH=~/go/bin:~/bin:$PATH
export EDITOR=vim
eval "$(dircolors)"
unset TMOUT
eval `keychain --quiet --eval ~/.ssh/id_rsa ~/.ssh/google_compute_engine F16D7319FB2349B2 --agents gpg,ssh`
set -o vi
set editing-mode vi
set keymap vi-command
set show-all-if-ambiguous on
set keymap vi-insert
eval "$(direnv hook bash)"
# enable autojump if available
[[ -s /usr/share/autojump/autojump.bash ]] && source /usr/share/autojump/autojump.bash
gssh ()
{
    [[ -f $HOME/.ssh/google_compute_engine ]] && ssh-add $HOME/.ssh/google_compute_engine &> /dev/null;
    gcloud compute ssh --ssh-flag="-A" "$@"
}
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi


complete -C /home/jrivera/go/bin/gocomplete go
export CLOUDSDK_PYTHON=python3

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jrivera/google-cloud-sdk/path.bash.inc' ]; then . '/home/jrivera/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/jrivera/google-cloud-sdk/completion.bash.inc' ]; then . '/home/jrivera/google-cloud-sdk/completion.bash.inc'; fi
source <(kubectl completion bash)
eval "$(gh completion -s bash)"
export GOPRIVATE=github.com/hdtradeservices
