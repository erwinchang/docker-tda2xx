#!/bin/bash

[ "${USER}" == "aosp" ] && exit 0

dirx="${PWD:${#HOME}}"		# remove /ssd2/workspace/erwin-hud/hud_bsp
dirx=${dirx#/}			# remove /
ssdx="${dirx:0:4}"
name=$(echo "$dirx" | sed 's/\//./g')
#dirx=${dirx#*/}			# remove ssd2
vdir="/mnt/aosp/$dirx"
cdir="$vdir/ccache"


echo "docker run -e WORK_DIR=$vdir -v $HOME:/mnt/aosp -it --rm --name $name erwinchang/tda2xx /bin/bash"
docker run -e WORK_DIR=$vdir -v $HOME:/mnt/aosp -it --rm --name $name erwinchang/tda2xx /bin/bash
