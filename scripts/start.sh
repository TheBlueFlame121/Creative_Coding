#!/bin/bash

if [ -z "$1" ]; then
    docker exec -it openframe bash
elif [ $1 == "detach" ]; then
    docker exec -t -d openframe bash -c /root/source_this.sh
fi
