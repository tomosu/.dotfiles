export PS1='\[\033[1;32m\]\u@\h\[\033[0m\] \[\033[1;34m\]\w\[\033[0m\] \[\033[1;31m\]$(__git_ps1 "(%s)")\[\033[0m\] \$ '

alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

export PATH=$PATH:/usr/local/bin/

## python3
source ~/virtual_envs/tf_env/bin/activate

## git-completion.sh
source ~/.zsh/git-completion.bash


## git-prompt.sh
source ~/.zsh/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=
