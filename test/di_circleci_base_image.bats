#!/usr/bin/env bats

@test "evaluate installed package versions" {
  run bash -c "docker exec di-circleci-base-image-edge apk -v info"
  [[ "${output}" =~ "bash-5.0.18-r0" ]]
  [[ "${output}" =~ "curl-7.72.0-r0" ]]
  [[ "${output}" =~ "openssl-1.1.1g-r0" ]]
  [[ "${output}" =~ "gnupg-2.2.23-r0" ]]
  [[ "${output}" =~ "docker-19.03.12-r0" ]]
  [[ "${output}" =~ "openrc-0.42.1-r12" ]]
  [[ "${output}" =~ "libstdc++-10.2.0-r5" ]]
  [[ "${output}" =~ "12.18.3-r0" ]]
  [[ "${output}" =~ "npm-12.18.3-r0" ]]
  [[ "${output}" =~ "jq-1.6_rc1-r1" ]]
}

@test "docker health" {
  run bash -c "docker exec di-circleci-base-image-edge docker version"
  [[ "${output}" =~ "19.03.12" ]]
}

@test "secrethub version" {
  run bash -c "docker exec di-circleci-base-image-edge secrethub --version"
  [[ "${output}" =~ "0.41" ]]
}

@test "snyk version" {
  run bash -c "docker exec di-circleci-base-image-edge snyk --version"
  [[ "${output}" =~ "1.394" ]]
}

@test "conftest version" {
  run bash -c "docker exec di-circleci-base-image-edge conftest --version"
  [[ "${output}" =~ "0.21" ]]
}

@test "bats version" {
  run bash -c "docker exec di-circleci-base-image-edge bats -v"
  [[ "${output}" =~ "1.1" ]]
}
