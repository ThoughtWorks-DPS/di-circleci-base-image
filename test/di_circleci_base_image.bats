#!/usr/bin/env bats

@test "evaluate installed package versions" {
  run bash -c "docker exec di-circleci-base-image-edge apk -v info"
  [[ "${output}" =~ "bash-5.0.17-r0" ]]
  [[ "${output}" =~ "curl-7.69.1-r1" ]]
  [[ "${output}" =~ "openssl-1.1.1g-r0" ]]
  [[ "${output}" =~ "gnupg-2.2.23-r0" ]]
  [[ "${output}" =~ "docker-19.03.12-r0" ]]
  [[ "${output}" =~ "openrc-0.42.1-r11" ]]
  [[ "${output}" =~ "libstdc++-9.3.0-r2" ]]
  [[ "${output}" =~ "nodejs-12.18.4-r0" ]]
  [[ "${output}" =~ "npm-12.18.4-r0" ]]
  [[ "${output}" =~ "jq-1.6_rc1-r1" ]]
}

@test "docker health" {
  run bash -c "docker exec di-circleci-base-image-edge docker version"
  [[ "${output}" =~ "19.03.12" ]]
}

@test "secrethub version" {
  run bash -c "docker exec di-circleci-base-image-edge secrethub --version"
  [[ "${output}" =~ "0.41.2" ]]
}

@test "snyk version" {
  run bash -c "docker exec di-circleci-base-image-edge snyk --version"
  [[ "${output}" =~ "1.434.2" ]]
}

@test "conftest version" {
  run bash -c "docker exec di-circleci-base-image-edge conftest --version"
  [[ "${output}" =~ "0.21.0" ]]
}

@test "bats version" {
  run bash -c "docker exec di-circleci-base-image-edge bats -v"
  [[ "${output}" =~ "1.2.1" ]]
}
