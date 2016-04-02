export PS1='\[\033[1;32m\]\u@\h\[\033[0m\] \[\033[1;34m\]\w\[\033[0m\] \[\033[1;31m\]$(__git_ps1 "(%s)")\[\033[0m\] \$ '


## git-completion.sh
source ~/.zsh/git-completion.bash


## git-prompt.sh
source ~/.zsh/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=