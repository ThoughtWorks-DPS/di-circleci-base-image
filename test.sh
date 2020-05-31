#!/usr/bin/env bash
_() { echo 'cleanup'; docker rm -f di-circleci-base-image-edge; docker rmi -f twdps/di-circleci-base-image:edge ; }
trap _ EXIT

docker run -it -d --name di-circleci-base-image-edge --entrypoint "/bin/ash" twdps/di-circleci-base-image:edge
bats test
