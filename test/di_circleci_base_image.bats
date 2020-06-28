#!/usr/bin/env bats

@test "evaluate installed package versions" {
  run bash -c "docker exec di-circleci-base-image-edge apk -v info"
  [[ "${output}" =~ "bash-5.0.17-r0" ]]
  [[ "${output}" =~ "curl-7.71.0-r1" ]]
  [[ "${output}" =~ "openssl-1.1.1g-r0" ]]
  [[ "${output}" =~ "gnupg-2.2.20-r0" ]]
  [[ "${output}" =~ "docker-19.03.11-r0" ]]
  [[ "${output}" =~ "openrc-0.42.1-r10" ]]
  [[ "${output}" =~ "libstdc++-9.3.0-r3" ]]
  [[ "${output}" =~ "nodejs-12.18.0-r2" ]]
  [[ "${output}" =~ "npm-12.18.0-r2" ]]
  [[ "${output}" =~ "jq-1.6_rc1-r1" ]]
}

@test "docker health" {
  run bash -c "docker exec di-circleci-base-image-edge docker version"
  [[ "${output}" =~ "19.03.11" ]]
}

@test "secrethub version" {
  run bash -c "docker exec di-circleci-base-image-edge secrethub --version"
  [[ "${output}" =~ "0.39" ]]
}

@test "snyk version" {
  run bash -c "docker exec di-circleci-base-image-edge snyk --version"
  [[ "${output}" =~ "1.346" ]]
}

@test "conftest version" {
  run bash -c "docker exec di-circleci-base-image-edge conftest --version"
  [[ "${output}" =~ "0.19" ]]
}

@test "bats version" {
  run bash -c "docker exec di-circleci-base-image-edge bats -v"
  [[ "${output}" =~ "1.1" ]]
}
