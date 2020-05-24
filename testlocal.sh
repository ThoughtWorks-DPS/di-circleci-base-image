#!/usr/bin/env bash
_() { echo 'cleanup'; docker rm -f "$CID"; docker rmi -f local/di-circleci-base-image:$tag ; }
trap _ EXIT

# use tag arg when provided
# in this example, the .unpinned dockerfile uses unpinned package definitions for
# early detection of upcoming breaking changes
tag=${1:-'local'}
dockerfile='Dockerfile'
if [[ $tag != "local" ]]; then
  dockerfile="$dockerfile.$tag"
fi

echo "build local/di-circleci-base-image:$tag"
docker build -t local/di-circleci-base-image:$tag .

echo "run cis docker benchmark inspec test"

# run the image being tested to support benchmark control 4-8 and image configuration tests
CID=$(docker run -it -d --name cis-test-di-circleci-base-image \
                 --entrypoint "/bin/ash" local/di-circleci-base-image:$tag)

# use docker-benchmark to perform inspec tests
docker run -it --rm \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -e IMAGE_NAME="local/di-circleci-base-image" \
           -e IMAGE_TAG="$tag" \
           -e CID="$CID" \
           feedyard/docker-benchmark distroless

echo "run inspec image configuration test"
# use chef/inspec to perform image configuration tests
docker run -it --rm \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -e CHEF_LICENSE="accept" \
           -v "$(pwd)":/share \
           chef/inspec exec profiles/di-circleci-base-image \
           -t docker://"${CID}"
