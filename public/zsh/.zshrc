# ==================================================
# THIS SHELL'S POWER IS > 9000!
# ==================================================
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"

# configure general options
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

# set up some custom glyphs
BIG_ARROW="\uf105"
ELLIPSIS="\u2026"
LEFT_ARROW_HOOK="\u21a9"
RIGHT_ARROW_HOOK="\u21aa"
DOWN_ARROW_HOOK="\u27a5"
UP_ARROW_HOOK="\u27a6"

# set up custom prompt elements
custom_hourglass="echo \uf253"

# color settings
POWERLEVEL9K_COLOR_SCHEME="dark"
POWERLEVEL9K_DIR_HOME_BACKGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="blue"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"
POWERLEVEL9K_STATUS_OK_BACKGROUND="white"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="red"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="white"
POWERLEVEL9K_TIME_BACKGROUND="white"
POWERLEVEL9K_TIME_FOREGROUND="black"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="grey"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="white"
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="grey"
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="white"

# override default formats
POWERLEVEL9K_TIME_FORMAT="\uf455 %D{%m-%d-%y %H:%M}"

# override default separators
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=""
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=""

# configure directory shortening strategies
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_DELIMITER="$ELLIPSIS"
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"

# configure the prompt elements
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""
POWERLEVEL9K_PROMPT_ON_NEWLINE="true"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$BIG_ARROW"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable_joined vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time)


# ==================================================
# oh-my-zsh plugins
# ==================================================
plugins=(
  dotenv
  git
  github
  jsontools
  osx
  sudo
)

source $ZSH/oh-my-zsh.sh

# ==================================================
# General Config
# ==================================================

# default editor
export EDITOR="vim"

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
