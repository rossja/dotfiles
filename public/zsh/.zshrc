# --------------------------------------------------
# MY POWER IS > 9000!
# --------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel9k/powerlevel9k"

# if font == sourcecode-pro+powerline+awesome
#BIG_ARROW="\u2b81"
# if font == nerdfonts
BIG_ARROW="\uf105"

export POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$BIG_ARROW"
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir newline vcs)

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  dotenv
  git
  github
  jsontools
  osx
  sudo
)

source $ZSH/oh-my-zsh.sh

# --------------------------------------------------
# General Config
# --------------------------------------------------

# default editor
export EDITOR='vim'

# source aliases if one exists
[[ -f ~/.aliases.zsh ]] && . ~/.aliases.zsh

# set the function path
fpath=( "$HOME/.zsh.d" "${fpath[@]}" )

# get the homebrew zsh completions for hub
if (( ! ${fpath[(I)/usr/local/share/zsh/site-functions]} )); then
  FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi

# autoload functions
autoload docker-killall docker-rmstale docker-rmvols
