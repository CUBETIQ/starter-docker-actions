#!/bin/bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

echo "$INPUT_RUN" | sed -e 's/\\n/;/g' > semicolon_delimited_script

if [ ! -z $INPUT_DOCKER_NETWORK ];
then INPUT_OPTIONS="$INPUT_OPTIONS --network $INPUT_DOCKER_NETWORK"
fi

if [ -z $INPUT_SHELL ];
then INPUT_SHELL=sh
fi

if [ -z $INPUT_IMAGE ];
then INPUT_IMAGE=docker
fi

if [ -z $semicolon_delimited_script ];
then semicolon_delimited_script="echo $(whoami)"
fi

exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "`cat semicolon_delimited_script`"