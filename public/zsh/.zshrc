# ==================================================
# set locale
# ==================================================
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# set zsh home to oh-my-zsh if it's installed
[[ -d $HOME/.oh-my-zsh ]] && export ZSH="$HOME/.oh-my-zsh"

# ==================================================
# General Config
# ==================================================
ZSH_DISABLE_COMPFIX=true

# Setup some useful vars
export binpub="$HOME/Documents/dotfiles/public/bin"
export binpriv="$HOME/Documents/dotfiles/private/bin"

# source the private config if it exists
[[ -f ~/.zshrc.priv ]] && . ~/.zshrc.priv

# kill the inverse % on non-terminated end of line
export PROMPT_EOL_MARK=""

# default editor
export EDITOR="vim"

# source aliases if one exists
[[ -f ~/.aliases.zsh ]] && . ~/.aliases.zsh
[[ -f ~/.aliases.zsh.priv ]] && . ~/.aliases.zsh.priv

# set the function path
fpath=("$HOME/.zsh.d" "${fpath[@]}")
fpath=($fpath ~/.zsh/completion)

# get the homebrew zsh completions for hub
if (( ! ${fpath[(I)/usr/local/share/zsh/site-functions]} )); then
  fpath=/usr/local/share/zsh/site-functions:$FPATH
fi

# ignore commands that start with a space
# useful when secrets need to be part of a command
setopt HIST_IGNORE_SPACE

# autoload functions
# don't need these as much now that I discovered the
# magic of`docker system prune --volumes`, but still
# are occasionally handy to have
autoload docker-killall docker-rmstale docker-rmvols
autoload -U compinit
compinit

# ==================================================
# set up PATH
# ==================================================
# all your base...
# /usr/local/[bin|sbin] comes first to prefer homebrew apps over mac defaults
export PATH="/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/sbin:/usr/sbin"

# snapcraft on linux
[[ -d  /snap/bin ]] && export PATH="${PATH}:/snap/bin"

# coreutils
if [ -d /usr/local/opt/coreutils ]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# typora on linux
[[ -d /usr/share/typora/Typora ]] && export PATH="/usr/share/typora/Typora:$PATH"

# bladeRF
[[ -d /opt/local/bin/ ]] && export PATH="/opt/local/bin/:$PATH"

# prefer openjdk
[[ -d "/usr/local/opt/openjdk@8/bin" ]]  && export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
export JAVA_HOME="/usr/local/opt/openjdk@8"

# prefer oracle jdk
#[[ -d "$HOME/src/jdk16/Contents/Home/bin" ]]  && export PATH="$HOME/src/jdk16/Contents/Home/bin:$PATH"
#export JAVA_HOME="$HOME/src/jdk16/Contents/Home"

# krew
[[ -d $HOME/.krew ]] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# mactex
[[ -d /usr/local/texlive/2020/bin/x86_64-darwin ]] && export PATH="/usr/local/texlive/2020/bin/x86_64-darwin:$PATH"

# android studio
[[ -d $HOME/Library/Android/sdk/build-tools/30.0.3 ]] && export PATH="$HOME/Library/Android/sdk/build-tools/30.0.3:$PATH"
[[ -d $HOME/Library/Android/sdk/platform-tools ]] && export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
[[ -d $HOME/Library/Android/sdk/tools ]] && export PATH="$HOME/Library/Android/sdk/tools:$PATH"

# python libs on mac
[[ -d $HOME/Library/Python/3.9/bin ]] && export PATH="$PATH:$HOME/Library/Python/3.9/bin"
[[ -d $HOME/Library/Python/3.8/bin ]] && export PATH="$PATH:$HOME/Library/Python/3.8/bin"
[[ -d $HOME/Library/Python/3.7/bin ]] && export PATH="$PATH:$HOME/Library/Python/3.7/bin"
[[ -d $HOME/Library/Python/2.7/bin ]] && export PATH="$PATH:$HOME/Library/Python/2.7/bin"

# dotnet
[[ -d /usr/local/share/dotnet ]] && export PATH="/usr/local/share/dotnet:$PATH"

# ==================================================
# dev opts
# ==================================================

# golang
if [ -d /usr/local/opt/go/ ]; then
    export PATH="$PATH:/usr/local/opt/go/libexec/bin"
    export GOROOT="/usr/local/opt/go/libexec/"
fi
export GOPATH="$HOME/src/golang"
[[ -d $GOPATH ]] && export PATH="$GOPATH/bin:$PATH"

# python virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME="$HOME/.virtualenvs"
    export PROJECT_HOME="$HOME/src/python"
    export VIRTUALENVWRAPPER_SCRIPT="/usr/local/bin/virtualenvwrapper.sh"
    # use python3 as the virtualenv default
    export VIRTUALENVWRAPPER_PYTHON=python3
    [[ -f /usr/local/bin/virtualenvwrapper_lazy.sh ]] && source "/usr/local/bin/virtualenvwrapper_lazy.sh"
fi

# prefer gnu getopt
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

# prefer gnu readline
export LDFLAGS="-L/usr/local/opt/readline/lib $LDFLAGS"
export CPPFLAGS="-I/usr/local/opt/readline/include $CPPFLAGS"
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig:$PKG_CONFIG_PATH"

# prefer brew mysql
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/mysql-client/lib $LDFLAGS"
export CPPFLAGS="-I/usr/local/opt/mysql-client/include $CPPFLAGS"
export PKG_CONFIG_PATH="/usr/local/opt/mysql-client/lib/pkgconfig:$PKG_CONFIG_PATH"

# prefer brew sqlite
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/sqlite/lib $LDFLAGS"
export CPPFLAGS="-I/usr/local/opt/sqlite/include $CPPFLAGS"
export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig:$PKG_CONFIG_PATH"

# prefer brew openblas
export LDFLAGS="-L/usr/local/opt/openblas/lib"
export CPPFLAGS="-I/usr/local/opt/openblas/include $CPPFLAGS"
export PKG_CONFIG_PATH="/usr/local/opt/openblas/lib/pkgconfig:$PKG_CONFIG_PATH"

# prefer openssl (over Apple's TLS libs)
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib $LDFLAGS"
export CPPFLAGS="-I/usr/local/opt/openssl/include $CPPFLAGS"

# prefer openjdk
[[ -d "/usr/local/opt/openjdk@8/include" ]] && export CPPFLAGS="-I/usr/local/opt/openjdk@8/include:$CPPFLAGS"

# dotnet
[[ -d /usr/local/share/dotnet ]] && export PATH="/usr/local/share/dotnet:$PATH"

# opt out of dotnet telemetry
DOTNET_CLI_TELEMETRY_OPTOUT=1

# ==================================================
# Compiler Settings
# ==================================================
export ARCHFLAGS="-arch x86_64"


# ==================================================
# my own bin uber alles
# ==================================================
[[ -d "$HOME/Documents/bin" ]] && export PATH="$HOME/Documents/bin:$PATH"
[[ -d "$HOME/Documents/dotfiles/public/bin" ]] && export PATH="$HOME/Documents/dotfiles/public/bin:$PATH"
[[ -d "$HOME/Documents/dotfiles/private/bin" ]] && export PATH="$HOME/Documents/dotfiles/private/bin:$PATH"


# ==================================================
# Prompt Magic
# THIS SHELL'S POWER IS > 9000!
# ==================================================
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"

# configure general options
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"
HYPHEN_INSENSITIVE="true"

# set up some custom glyphs
ELLIPSIS="\u2026"
GIT_BRANCH_ICON="\uf126"
USER_ICON="\uf2be"
ROOT_ICON="\uf292"
BIG_ARROW="\ue0b1"
SMALL_ARROW="\uf105"
UP_ARROW_HOOK="\u27a6"
DOWN_ARROW_HOOK="\u27a5"
LEFT_ARROW_HOOK="\u21a9"
RIGHT_ARROW_HOOK="\u21aa"
BRACKET_OPEN="\uff3b"
BRACKET_CLOSE="\uff3d"

# set up custom prompt elements
custom_hourglass="echo \uf253"

# color settings
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="grey"
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="white"
POWERLEVEL9K_COLOR_SCHEME="dark"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="grey"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="white"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="black"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="red"
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_BACKGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"
POWERLEVEL9K_DIR_PATH_HIGHLIGHT_BOLD="true"
POWERLEVEL9K_DIR_PATH_HIGHLIGHT_FOREGROUND="white"
POWERLEVEL9K_DIR_PATH_SEPARATOR_FOREGROUND="black"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="red"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="white"
POWERLEVEL9K_STATUS_OK_BACKGROUND="white"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_TIME_BACKGROUND="white"
POWERLEVEL9K_TIME_FOREGROUND="black"

# override default formats
POWERLEVEL9K_TIME_FORMAT="\uf455 %D{%m-%d-%y %H:%M}"

# override default separators
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER="false"
POWERLEVEL9K_DIR_PATH_SEPARATOR="|"
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=""
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=""

# configure directory shortening strategies
POWERLEVEL9K_SHORTEN_DELIMITER="$ELLIPSIS"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"

# set misc vars for various elements
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=3
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_CONTEXT_TEMPLATE="$USER_ICON `hostname -s`"
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_VCS_BRANCH_ICON="$GIT_BRANCH_ICON "

# multiline settings
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$SMALL_ARROW"
POWERLEVEL9K_PROMPT_ON_NEWLINE="true"
POWERLEVEL9K_RPROMPT_ON_NEWLINE="false"

# set the prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context virtualenv newline dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time)


# ==================================================
# oh-my-zsh plugins
# ==================================================
plugins=(
  jsontools
  sudo
  docker
  virtualenv
)

source $ZSH/oh-my-zsh.sh
source $ZSH/plugins/calc/calc.plugin.zsh

# The next line updates PATH for the Google Cloud SDK.
[[ -d /usr/local/Caskroom/google-cloud-sdk/lagtest/google-cloud-sdk ]] && source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
[[ -d /usr/local/Caskroom/google-cloud-sdk/lagtest/google-cloud-sdk ]] && source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

