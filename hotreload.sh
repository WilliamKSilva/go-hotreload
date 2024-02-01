#!/bin/bash

# Use this for development purposes only #
# Its so boring to call GO interpreter everytime # 

ROOTDIR=$(dirname "$0")

# Add your Golang entrypoint file path here #
ENTRYPOINT="${ROOTDIR}/main.go"
GIT='git --git-dir='$PWD'/.git'
GOCOMPILER='which go'

LAST_CHANGES_SIZE=0
while true
do
    CHANGES=$($GIT diff)
    CHANGES_OUTPUT_LENGTH=$(printf "%s" "$CHANGES" | wc -c)
    if (($CHANGES_OUTPUT_LENGTH == $LAST_CHANGES_SIZE));
    then
        continue
    fi

    LAST_CHANGES_SIZE=$CHANGES_OUTPUT_LENGTH

    if (($CHANGES_OUTPUT_LENGTH > 0));
    then
        echo "Recompiled!"
        $($GOCOMPILER run $ENTRYPOINT_SERVER) &
    fi
done