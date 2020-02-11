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

# Colors
black="\[$(tput setaf 0)\]"
red="\[$(tput setaf 1)\]"
green="\[$(tput setaf 2)\]"
yellow="\[$(tput setaf 3)\]"
blue="\[$(tput setaf 4)\]"
magenta="\[$(tput setaf 5)\]"
cyan="\[$(tput setaf 6)\]"
white="\[$(tput setaf 7)\]"
bold="\[$(tput bold)\]"
# Clear attributes
clear_attributes="\[$(tput sgr0)\]"

# Custom bash prompt - "➜  ~ (master) "
prompt_command_func() {
    CODE=$?

    # Record each line as it gets issued
    history -a

    if [ $CODE -eq 0 ]; then \
        export PS1="${bold}${green}➜ ${blue}\W ${cyan}\$(parse_git_branch)${magenta}\\$ ${clear_attributes}"
    else\
        export PS1="${bold}${red}➜ ${blue}\W ${cyan}\$(parse_git_branch)${magenta}\\$ ${clear_attributes}"
    fi
}

PROMPT_COMMAND=prompt_command_func

export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH=$PATH:/usr/local/go/bin:~/go/bin

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

source <(kubectl completion bash)
