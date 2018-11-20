# --------------------------------------------------
# set up PATHs
# --------------------------------------------------
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/bin:$PATH"
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"

MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

ZSH="$HOME/.oh-my-zsh"

export PATH MANPATH ZSH

# --------------------------------------------------
# Compiler Settings
# --------------------------------------------------
export ARCHFLAGS="-arch x86_64"

# set openssl first (over Apple's TLS libs)
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

