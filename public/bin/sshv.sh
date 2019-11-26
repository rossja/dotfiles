#!/bin/bash
# useful for debugging ssh based git connections
# run like so:
#   GIT_SSH=sshv.sh git push
ssh -vvv "$@"
