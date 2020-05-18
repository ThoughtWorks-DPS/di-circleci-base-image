#!/usr/bin/env bash
_() { echo 'cleanup'; docker rm -f "$CID"; docker rmi -f local/di-circleci-base-image:latest ; }
trap _ EXIT

echo 'build local/di-circleci-base-image:latest'
docker build -t local/di-circleci-base-image:latest .

echo "run cis docker benchmark inspec test"

# run the image being tested to support benchmark control 4-8 and image configuration tests
CID=$(docker run -it -d --name cis-test-di-circleci-base-image \
                 --entrypoint "/bin/ash" local/di-circleci-base-image:latest)

# use docker-benchmark to perform inspec tests
docker run -it --rm \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -e IMAGE_NAME="local/di-circleci-base-image" \
           -e IMAGE_TAG="latest" \
           -e CID="$CID" \
           feedyard/docker-benchmark distroless

echo "run inspec image configuration test"
# use chef/inspec to perform image configuration tests
docker run -it --rm \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -e CHEF_LICENSE="accept" \
           -v "$(pwd)":/share \
           chef/inspec exec profiles/circleci-base-image \
           -t docker://"${CID}"
