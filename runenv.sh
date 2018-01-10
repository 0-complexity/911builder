#!/bin/bash

# build it, you'll find the build result in ./binaries
docker run --privileged -it \
	-v $(pwd):/911builder 911builder:latest bash
	# -v $(pwd)/binaries:/binaries \

# that's all folks
# https://www.youtube.com/watch?v=b9434BoGkNQ
