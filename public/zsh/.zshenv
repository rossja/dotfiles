# --------------------------------------------------
# set locale
# --------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# set zsh home to oh-my-zsh if it's installed
[[ -d $HOME/.oh-my-zsh ]] && export ZSH="$HOME/.oh-my-zsh"

# --------------------------------------------------
# set up PATH
# --------------------------------------------------
# all your base...
export PATH="/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin"

# coreutils
if [ -d /usr/local/opt/coreutils ]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# --------------------------------------------------
# dev opts
# --------------------------------------------------

# golang
if [ -d /usr/local/opt/go/ ]; then
    export PATH=$PATH:/usr/local/opt/go/libexec/bin
    export GOROOT=/usr/local/opt/go/libexec/
fi
export GOPATH="$HOME/src/go"
[[ -d $GOPATH ]] && export PATH=$GOPATH/bin:$PATH

# prefer gnu getopt
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

# --------------------------------------------------
# Compiler Settings
# --------------------------------------------------
export ARCHFLAGS="-arch x86_64"

# set openssl first (over Apple's TLS libs)
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

# --------------------------------------------------
# my own bin uber alles
# --------------------------------------------------
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"