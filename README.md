
<div align="center">
	<p>
		<img alt="Thoughtworks Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/thoughtworks_flamingo_wave.png?sanitize=true" width=200 />
    <br />
		<img alt="DPS Title" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/dps_lab_title.png?sanitize=true" width=350/>
	</p>
  <h3>ThoughtWorks DPS Convenience Images</h3>
  <h1>twdps/di-circleci-base-image</h1>
  <a href="https://app.circleci.com/pipelines/github/ThoughtWorks-DPS/di-circleci-base-image"><img src="https://circleci.com/gh/ThoughtWorks-DPS/di-circleci-base-image.svg?style=shield"></a> <a href="https://hub.docker.com/repository/docker/twdps/di-circleci-base-image"><img src="https://img.shields.io/docker/v/twdps/di-circleci-base-image?sort=semver"></a> <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/ThoughtWorks-DPS/di-circleci-base-image"></a>
</div>
<br />

With inspiration from the CircleCI convenience images, `twdps/di-circleci-base-image` is one of a series of CircleCI remote docker executor images built FROM `twdps/di-circleci-remote-docker` that has both alpine and buster-slim variants created with self-hosted runners in mind. This image is designed to serve as a base image and provides the core packages and configuration needed to provide a self-serve, low friction experience for cross functional, independent development teams with a high governance and security profile.  

_difference with cimg libraries._ Enterprise settings often require specific security and configuration testing. The twdps series of convenience images includes common sdlc security practices, including CIS-benchmark testing. The Alpine image will generally not have any cve issues.  
  
**Other images in this series**  

twdps/di-circleci-infra-image  

## Table of Contents

- [Getting Started](#getting-started)
- [What is included in the image](#what-is-included-in-the-image)
- [Development](#development)
- [Contributing](#contributing)

## Getting Started

This image can be used with the CircleCI docker executor.  
For example:

```yaml
jobs:
  build:
    docker:
      - image: twdps/di-circleci-base-image:1.0.3
    steps:
      - checkout
      - setup-remote-docker
      - run: docker build -t 'org/image:tag' .
```

## What is Included in the Image

In addition to the minimum requirements needed to be used as a remote docker executor on CircleCI, the twdps base image includes (with dependencies):  

- sudo (to support use of USER=circleci)
- locale support)
- bash
- curl
- openssl
- gnupg
- docker
- nodejs
- npm
- jq
- secrethub-cli
- snyk
- bats
- conftest (open policy agent)
- chamber (by segment.io)
_See CHANGES.md for current versions_

### Tagging Scheme

These CircleCI executor images have the following tagging scheme:

`edge` - the latest version of the image. Built from the `HEAD` of the `master` branch. Intended to be used as a testing version of the image with the most recent changes however not guaranteed to be all that stable and not recommended for production software.  

`stable` - points to the latest, production ready base image. For projects that want a decent level of stability while automatically recieving software updates. This is similar to using the `:latest` tag and is not a generally recommended practice. Pin the `executor` reference to a specific release and adopt new releases as part of your ci process.  

`0.0.0` - Semantic release version of the image. This is the recommended version for use in a CircleCI pipeline.  


## Development

Images can be built and run locally with this repository.
This has the following requirements:

- local machine of Linux (Alpine tested) or macOS
- modern version of a shell (zsh/bash tested (v4+))
- modern version of Docker Engine (v19.03+)

### Building the Dockerfiles

To build and test the Docker image locally, run the `testlocal.sh` script:

```bash
./testlocal.sh
```
*requirements for testing*  
conftest  
bats  

### Publishing Official Images (for Maintainers only)

Git push will trigger the dev-build pipeline. In addition to the tests performed in testlocal.sh, a snyk scan is done to expose any known vulnerabilities.  

To create a release version, simply tag HEAD with the semnatic release version.

## Contributing

We accept [issues](https://github.com/twdps/di-circleci-remote-docker/issues) and [pull requests](https://github.com/twdps/di-circleci-remote-docker/pulls) against this repository. In order to value your time, here are some things to consider:

1. We won't include just anything in this image. While many of the packges in this base are commonly used by teams using CircleCI, the image is part of a larger delivery platform architecture model designed to exemplify modern cloud native practices and software defined infrastructure. In order for us to add a tool within the base image, it has to be part of  the overall TW DPS reference architecture. Suggest packages based on proposed changes to existing tools or services and include a defense for why an alternative approach is superior.  
1. Issues are generally the best option to report bugs or request additional/removal of tools in this image. PRs for bug  fixes are always welcome.  



Defining a USER for circleci executors can seem counter-intuitive even when using private runners. The intended use includes dynamically installing packages and running other containers. It is also quite common for enterprises to enforce Dockerfile configuration scanning that requires a USER, nonetheless.  

**vulnerability found in sudo < 1.9.5p2-r0**
Description: Off-by-one Error
Info: https://snyk.io/vuln/SNYK-ALPINE314-SUDO-1308042

Snyk began reporting this error with the alpine 3.14 upgrade, even though sudo is at 1.9.7
