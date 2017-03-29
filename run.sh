#!/bin/sh

vol=streisand_files

mkdir -p $vol
docker run --net host --rm -it -v $vol:/output bnaylor/streisander

