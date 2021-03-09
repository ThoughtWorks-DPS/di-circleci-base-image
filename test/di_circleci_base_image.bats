#!/usr/bin/env bats

@test "evaluate installed package versions" {
  run bash -c "docker exec di-circleci-base-image-edge apk -v info"
  [[ "${output}" =~ "bash-5.1.0-r0" ]]
  [[ "${output}" =~ "curl-7.74.0-r0" ]]
  [[ "${output}" =~ "openssl-1.1.1j-r0" ]]
  [[ "${output}" =~ "gnupg-2.2.27-r0" ]]
  [[ "${output}" =~ "docker-20.10.3-r0" ]]
  [[ "${output}" =~ "openrc-0.42.1-r19" ]]
  [[ "${output}" =~ "nodejs-14.16.0-r0" ]]
  [[ "${output}" =~ "npm-14.16.0-r0" ]]
  [[ "${output}" =~ "jq-1.6_rc1-r1" ]]
}

@test "docker health" {
  run bash -c "docker exec di-circleci-base-image-edge docker version"
  [[ "${output}" =~ "20.10.3" ]]
}

@test "secrethub version" {
  run bash -c "docker exec di-circleci-base-image-edge secrethub --version"
  [[ "${output}" =~ "0.41.2" ]]
}

@test "snyk version" {
  run bash -c "docker exec di-circleci-base-image-edge snyk --version"
  [[ "${output}" =~ "1.478.0" ]]
}

@test "conftest version" {
  run bash -c "docker exec di-circleci-base-image-edge conftest --version"
  [[ "${output}" =~ "0.23.0" ]]
}

@test "bats version" {
  run bash -c "docker exec di-circleci-base-image-edge bats -v"
  [[ "${output}" =~ "1.2.1" ]]
}

@test "chamber version" {
  run bash -c "docker exec di-circleci-base-image-edge chamber version"
  [[ "${output}" =~ "2.9.1" ]]
}
