# -------------------------------------------------
# ls tweaks
# -------------------------------------------------
#alias ls='gls --color=auto' # requires coreutils on mac osx
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias l.='ls -la'

# -------------------------------------------------
# brew maintenance
# -------------------------------------------------
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'

# -------------------------------------------------
# header curl (useful for web app testing)
# -------------------------------------------------
alias hcurl="curl -s -o /dev/null -L -D - -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'"

# -------------------------------------------------
# vscode handy helper
# -------------------------------------------------
alias edit='/usr/local/bin/code-insiders'

# -------------------------------------------------
# handy for getting to the dotfiles dirs quickly
# -------------------------------------------------
alias cdf='cd $HOME/Documents/dotfiles'
alias cdfp='cd $HOME/Documents/dotfiles/public'

# -------------------------------------------------
# git fun
# -------------------------------------------------
alias yolo='git commit -a -m "$(curl -s https://cb.pe/yolo)" && git push'

# -------------------------------------------------
# docker stuff I find useful
# -------------------------------------------------

# vault things
alias vault="docker exec -i $(docker ps|awk '/vault:latest/ {print $1}') vault"
alias openvault="vault operator unseal $Unseal_Key_1; vault operator unseal $Unseal_Key_2; vault operator unseal $Unseal_Key_3"
alias file2vault="cat $1| vault kv put $2 value=-" # arg1=filepath  arg2=vaultpath
alias cip="docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}'" # pass in a container ID to get the IP for it
alias cips="docker ps -q |xargs docker inspect --format '{{.Name}} : {{range .NetworkSettings.Networks}}{{.IPAddress}}, {{end}}'" # get all the IPs for every container

# use app-specific mongo
alias amongo="mongo -u $appDbUser -p appDbPass $appDbName"
