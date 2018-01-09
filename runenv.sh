#!/bin/bash

# build it, you'll find the build result in ./binaries
docker run --privileged -it \
	-v $(pwd)/binaries:/binaries \
	-v $(pwd):/911builder 911builder:latest bash

# that's all folks
# https://www.youtube.com/watch?v=b9434BoGkNQ
