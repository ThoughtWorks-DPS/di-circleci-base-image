docker run -it -v /var/run/docker.sock:/var/run/docker.sock -e "SNYK_TOKEN=$SNYK_TOKEN" \
               -v "${PWD}:/project" \
               snyk/snyk-cli:1.320.0-docker test \
               --org=twdps \
               --severity-threshold=low \
               --docker twdps/di-circleci-base-image:edge \
               --file=Dockerfile
