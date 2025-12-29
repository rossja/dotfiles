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
[[ -x /opt/homebrew/bin/code-insiders ]] && alias edit="/opt/homebrew/bin/code-insiders"
[[ -x /snap/bin/code ]] && alias edit="/snap/bin/code"
[[ -x /snap/bin/code-insiders ]] && alias edit="/snap/bin/code-insiders"
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
# alias yolo='git commit -a -m "$(curl -s https://whatthecommit.com/index.txt)" && git push'
alias gitid='git rev-parse --short HEAD'

# -------------------------------------------------
# docker stuff I find useful
# -------------------------------------------------
alias di="docker images |sort -n |grep -v REPOSITORY |awk '{print \$1\":\"\$2\" \(\" \$3\"\)\"}'"
alias dps="docker ps -a"
# this next bit lets you build a docker image passing in
# tons of args via a .env file, like so:
# `docker build -t rails-toolbox -f Dockerfile.rails $(args) .`
alias args='for var in `cat .env`; do out+="--build-arg ${var} "; done; echo ${out}; out=""'

# docker vault things
alias vault="docker exec -i $(docker ps|awk '/vault:latest/ {print $1}') vault"
alias openvault="vault operator unseal $Unseal_Key_1; vault operator unseal $Unseal_Key_2; vault operator unseal $Unseal_Key_3"
alias file2vault="cat $1| vault kv put $2 value=-" # arg1=filepath  arg2=vaultpath
alias cip="docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}'" # pass in a container ID to get the IP for it
alias cips="docker ps -q |xargs docker inspect --format '{{.Name}} : {{range .NetworkSettings.Networks}}{{.IPAddress}}, {{end}}'" # get all the IPs for every container
alias dockershell="docker exec -it ${1} ${2}"

# -------------------------------------------------
# random other stuff
# -------------------------------------------------

# get rid of command number and timestamp from history
alias histrim="history | cut -c 26-"

# a fun way to make random passwords
alias randpw="openssl rand 60 | openssl base64 -A"

# google cloud stuff
alias gcpls='gcloud compute instances list | grep ${1}'

# check ciphers and key lengths of SSH keys
export KEYSREGEX="${HOME}/.ssh/keys./*.pub"
alias keyscan="for key in ${KEYSREGEX}; do echo -e \"\${key}\"; ssh-keygen -l -f \"\${key}\" 2> /dev/null; echo -e \"\\n\";  done | uniq"

# for when i figure out a command line trick i want to keep forever
alias keeper='echo $(history -p !!) >>~/.keeper.txt'

# ag with ignore
alias agi='ag --ignore test --ignore node_modules --ignore lib --ignore test --ignore shared-labels-std --ignore shared-labels --ignore tests --ignore __tests__ --ignore mocks'
