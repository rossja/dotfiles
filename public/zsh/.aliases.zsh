# -------------------------------------------------
# ls tweaks
# -------------------------------------------------
#alias ls="gls --color=auto" # requires coreutils on mac osx
alias ll="ls -alhF"
alias la="ls -A"
alias l="ls -CF"
alias l.="ls -la"

# -------------------------------------------------
# brew maintenance
# -------------------------------------------------
alias brewup="brew update; brew upgrade; brew cleanup --prune-prefix; brew cleanup; brew doctor"

# -------------------------------------------------
# header curl (useful for web app testing)
# -------------------------------------------------
alias hcurl="curl -s -o /dev/null -L -D - -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'"

# preserve color output from grep across pipes
alias grepc="grep --color=always"

# -------------------------------------------------
# vscode handy helper
# updated to include vscodium because telemetry sux
# -------------------------------------------------
[[ -x /usr/local/bin/code ]] && alias edit="/usr/local/bin/code"
[[ -x /usr/local/bin/code-insiders ]] && alias edit="/usr/local/bin/code-insiders"
[[ -x /usr/local/bin/vscodium ]] && alias edit="/usr/local/bin/vscodium"
[[ -x /bin/vscodium ]] && alias edit="/bin/vscodium"

# -------------------------------------------------
# handy for getting to the dotfiles dirs quickly
# -------------------------------------------------
alias cdot="cd $HOME/Documents/dotfiles"
alias pubdot="cd $HOME/Documents/dotfiles/public"
alias privdot="cd $HOME/Documents/dotfiles/private"

# -------------------------------------------------
# git fun
# -------------------------------------------------
alias yolo='git commit -a -m "$(curl -s https://cb.pe/yolo)" && git push'
alias guppy='git checkout master && git pull && git checkout json-dev && git pull'

# -------------------------------------------------
# I hate typing
# CLIENT_WORK_DIR is set in .zshrc.priv
# -------------------------------------------------
alias cdc="cd $CLIENT_WORK_DIR"
alias cdcd="cd $CLIENT_WORK_DIR/docs"
alias cdct="cd $CLIENT_WORK_DIR/testing"
alias cdcs="cd $CLIENT_WORK_DIR/src"

# -------------------------------------------------
# docker stuff I find useful
# -------------------------------------------------
alias di="docker images|sort -n"
alias dps="docker ps -a"
# this next bit lets you build a docker image passing in
# tons of args via a .env file, like so:
# `docker build -t rails-toolbox -f Dockerfile.rails $(args) .`
alias args='for var in `cat .env`; do out+="--build-arg ${var} "; done; echo ${out}; out=""'

# vault things
alias vault="docker exec -i $(docker ps|awk '/vault:latest/ {print $1}') vault"
alias openvault="vault operator unseal $Unseal_Key_1; vault operator unseal $Unseal_Key_2; vault operator unseal $Unseal_Key_3"
alias file2vault="cat $1| vault kv put $2 value=-" # arg1=filepath  arg2=vaultpath
alias cip="docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}'" # pass in a container ID to get the IP for it
alias cips="docker ps -q |xargs docker inspect --format '{{.Name}} : {{range .NetworkSettings.Networks}}{{.IPAddress}}, {{end}}'" # get all the IPs for every container
alias dockershell="docker exec -it ${1} ${2}"

# -------------------------------------------------
# random other stuff
# -------------------------------------------------

# use app-specific mongo
alias amongo="mongo -u $appDbUser -p appDbPass $appDbName"

# bladeRF firmware load
alias bladerunner="bladeRF-cli -l ~/.bladeRF/hostedx40-latest.rbf; bladeRF-cli -i"

# get rid of command number and timestamp from history
alias histrim="history | cut -c 26-"

# a fun way to make random passwords
alias randpw="openssl rand 60 | openssl base64 -A"

# google cloud stuff
alias gcpls='gcloud compute instances list | grep ${1}'

# check ciphers and key lengths of SSH keys
#export KEYSREGEX="${HOME}/.ssh/*.pub"
alias keyscan="for key in ${KEYSREGEX}; do echo -e \"\${key}\"; ssh-keygen -l -f \"\${key}\" 2> /dev/null; echo -e \"\\n\";  done | uniq"

# microk8s aliases -- counterintuitive because `which` returns '1' if command not found
#if [[ $(which kubectl) ]]; then
#  alias kubectl='microk8s kubectl'
#fi
#if [[ $(which helm) ]]; then
#  alias helm='microk8s helm3'
#fi

# python3 ftw
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3
