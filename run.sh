#!/bin/sh

vol=streisand_files

mkdir -p $vol
docker run --rm -it -v $vol:/output bnaylor/streisander

