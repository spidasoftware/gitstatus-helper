#!/bin/bash
# tputcolors

GITSTATUSLOGSTRING=log.log
exec 2>$GITSTATUSLOGSTRING

for D in `find . -maxdepth 1 -type d`
do
  if [[ "$D" != "." ]]; then
    cd "$D"
    GITSTATUSSTATUS=`git status | grep "nothing to commit"`
    GITSTATUSERROR=`git status | sed -n 1p`
    GITSTATUSISREPO="false"
    if [[ "$GITSTATUSERROR" != "" ]]; then
      GITSTATUSISREPO="true"
    fi
    GITSTATUSBRANCH=`git status | sed -n 1p`
    GITSTATUSBRANCH=${GITSTATUSBRANCH:12}
    if [[ "$GITSTATUSISREPO" = "true" ]]; then
        #statements
      if [[ "$GITSTATUSSTATUS" != "" ]]; then
        #echo " $(tput setaf 1)Text$(tput sgr0)"
        GITSTATUSSTATUS="$(tput setaf 2)✓$(tput sgr0)"
      else  
        GITSTATUSSTATUS="$(tput setaf 1)✗$(tput sgr0)"
      fi
      echo "$(tput setaf 6)$D$(tput sgr0) - $(tput setaf 5)$GITSTATUSBRANCH$(tput sgr0): $GITSTATUSSTATUS"
    fi
    cd ..
    rm -f log.log
  fi
done