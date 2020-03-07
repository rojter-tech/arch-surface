#!/bin/bash
docker run -itd --rm --name code-debian \
	-e PASSWORD=$(cat ~/.pw) \
	-v /home/dreuter/Github:/home/dreuter/Github \
	-v /home/dreuter/.ssh:/home/dreuter/.ssh \
	--network host rojtertech/code-debian
