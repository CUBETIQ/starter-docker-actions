#!/bin/bash
 
#### Current working directory is: /github/workspace ####
WORKDIR=$(pwd)
echo "Workdir => ${WORKDIR}"
ls $WORKDIR

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
then INPUT_IMAGE=cubetiq/calpine-docker
fi

if [ -z $semicolon_delimited_script ];
then semicolon_delimited_script="echo $(whoami)"
fi

echo "My name is: $(whoami)"

echo "Start executing docker..."

INPUT_OPTIONS="--workdir $WORKDIR -v $WORKDIR:$WORKDIR $INPUT_OPTIONS"
echo $INPUT_OPTIONS

docker ps

docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "`cat semicolon_delimited_script`"

docker ps

exec echo "Hahaha.........."