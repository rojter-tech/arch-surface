#!/bin/bash
docker run -itd --rm --name debian_coder \
	-e PASSWORD=$(cat ~/.pw) \
	-v /home/dreuter/Github:/root/Github \
	-v /root/.ssh:/root/.ssh \
	-v /opt/code/bin:/usr/local/bin \
	-v /opt/code/data:/root/.local/share/code-server \
	-v /opt/code/entrypoints/install.sh:/install.sh \
	-v /opt/code/entrypoints/debianentry.sh:/debianentry.sh \
	--network host \
	debian bash -c "/debianentry.sh &> /root/entry.log && apt update && apt install git -y"

