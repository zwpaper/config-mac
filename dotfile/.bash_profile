export BASH_CONF='BASH_PROFILE'

export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad


#alias start
alias code='cd ~/Documents/Codes'
alias blog='cd ~/Documents/Codes/zwpaper.github.com'
alias leetcode='cd ~/Documents/Codes/AlgrithmDataStruct/LeetCode'

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'

alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
alias pc4='proxychains4'

# Aria2-rpc
alias aria2rpc='aria2c --conf-path=/Users/paper/.aria2/aria2.conf -D'


# Function alias
cdmk() { mkdir $@ && cd $_ ;}

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

export PATH="/Users/paper/Library/Application Support/GoodSync":$PATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PS1="\h:\[\e[36m\]\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\$ "
