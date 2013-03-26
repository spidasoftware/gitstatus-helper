#!/bin/bash
# tputcolors

LOGSTRING=log.log
exec 2>$LOGSTRING

for D in `find . -maxdepth 1 -type d`
do
  if [[ "$D" != "." ]]; then
    cd "$D"
    STATUS=`git status | grep "nothing to commit"`
    ERROR=`git status | sed -n 1p`
    ISREPO="false"
    if [[ "$ERROR" != "" ]]; then
      ISREPO="true"
    fi
    BRANCH=`git status | sed -n 1p`
    BRANCH=${BRANCH:12}
    if [[ "$ISREPO" = "true" ]]; then
        #statements
      if [[ "$STATUS" != "" ]]; then
        #echo " $(tput setaf 1)Text$(tput sgr0)"
        STATUS="$(tput setaf 2)✓$(tput sgr0)"
      else  
        STATUS="$(tput setaf 1)✗$(tput sgr0)"
      fi
      echo "$(tput setaf 6)$D$(tput sgr0) - $(tput setaf 5)$BRANCH$(tput sgr0): $STATUS"
    fi
    cd ..
    rm -f log.log
  fi
done