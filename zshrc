# Path to oh-my-zsh 
fpath=(~/.zsh $fpath)
export ZSH=$HOME/.oh-my-zsh

## Plugins via oh-my-zsh
plugins=(brew cp osx)
#Look in ~/.oh-my-zsh/themes/
ZSH_THEME="Honukai"
#Timestamp format
HIST_STAMPS="dd.mm.yyyy"

source ~/.common_profile
source $ZSH/oh-my-zsh.sh

