#!/usr/bin/env bash
_() { echo 'cleanup'; docker rm -f di-circleci-base-image-edge; docker rmi -f twdps/di-circleci-base-image:edge ; }
trap _ EXIT

# use tag arg when provided
# in this example, the .unpinned dockerfile uses unpinned package definitions for
# early detection of upcoming breaking changes
tag=${1:-'local'}
dockerfile='Dockerfile'
if [[ $tag != "local" ]]; then
  dockerfile="$dockerfile.$tag"
fi

echo "build twdps/di-circleci-base-image"
docker build -t twdps/di-circleci-base-image:edge -f $dockerfile .

echo "run cis docker benchmark test"
conftest pull https://raw.githubusercontent.com/ncheneweth/opa-dockerfile-benchmarks/master/policy/cis-docker-benchmark.rego
conftest test Dockerfile --data .opacisrc
rm -rf policy

docker run -it -d --name di-circleci-base-image-edge --entrypoint "/bin/ash" twdps/di-circleci-base-image:edge
docker run -it -v "${PWD}:/code" bats/bats test
