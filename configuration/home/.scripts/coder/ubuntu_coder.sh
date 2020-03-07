#!/bin/bash
docker run -itd --rm --name code-ubuntu \
	-e PASSWORD=$(cat ~/.pw) \
	-v /home/dreuter/Github:/home/dreuter/Github \
	-v /home/dreuter/.ssh:/home/dreuter/.ssh \
	--network host rojtertech/code-ubuntu
