# ls
alias ls='gls --color=auto' # requires coreutils on mac osx
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias l.='ls -la'

# brew maintenance
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'

# header curl (useful for web app testing)
alias hcurl="curl -s -o /dev/null -L -D - -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'"

# vscode handy helper
alias edit='/usr/local/bin/code-insiders'

# handy for getting to the dotfiles dirs quickly
alias cdf='cd $HOME/Documents/dotfiles'
alias cdfp='cd $HOME/Documents/dotfiles/public'
