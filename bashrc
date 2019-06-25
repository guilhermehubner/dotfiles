# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PS1="\[$(tput bold)\]\[\033[32m\][\W]\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \\$\[$(tput sgr0)\] "
export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH=$PATH:/usr/local/go/bin:~/go/bin
export GTK_THEME=Adwaita:dark

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_functions ] && . ~/.bash_functions
[ -f ~/.bash_local ] && . ~/.bash_local

[ -f ~/.fzf.bash ] && . ~/.fzf.bash
[ -f ~/.nvm.bash ] && . ~/.nvm.bash
