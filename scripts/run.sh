#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
$SCRIPT_DIR/stop.sh

xhost +local:root

docker run -t -d --privileged --net=host \
--name openframe \
-v $PWD/apps:/home/noroot/openframeworks/apps \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
 openframe:docker
