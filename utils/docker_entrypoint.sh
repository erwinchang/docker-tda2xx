#!/bin/bash
set -e

#https://github.com/kylemanna/docker-aosp/blob/master/utils/docker_entrypoint.sh 

# Reasonable defaults if no USER_ID/GROUP_ID environment variables are set.
if [ -z ${USER_ID+x} ]; then USER_ID=1000; fi
if [ -z ${GROUP_ID+x} ]; then GROUP_ID=1000; fi

# ccache
#[ ! -z ${CCACHE_DIR} ] && {
#	export CCACHE_DIR=${CCACHE_DIR}
#	export USE_CCACHE=1
#}

msg="docker_entrypoint: Creating user UID/GID [$USER_ID/$GROUP_ID]" && echo $msg
groupadd -g $GROUP_ID -r aosp && \
useradd -u $USER_ID --create-home -r -g aosp aosp
echo "$msg - done"

cp /root/.gitconfig /home/aosp/.gitconfig
cp /root/aosp_bashrc.sh /home/aosp/aosp_bashrc.sh
chmod +x /home/aosp/aosp_bashrc.sh

echo ". /home/aosp/aosp_bashrc.sh" >> /home/aosp/.bashrc
chown aosp:aosp /home/aosp/.gitconfig /home/aosp/.bashrc /home/aosp/aosp_bashrc.sh

export HOME=/home/aosp
exec sudo -E -u aosp /bin/bash
