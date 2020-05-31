#!/usr/bin/env bats

@test "evaluate installed package versions" {
  run bash -c "docker exec di-circleci-base-image-edge apk -v info"
  [[ "${output}" =~ "bash-5.0.11-r1" ]]
  [[ "${output}" =~ "curl-7.67.0-r0" ]]
  [[ "${output}" =~ "openssl-1.1.1g-r0" ]]
  [[ "${output}" =~ "gnupg-2.2.19-r0" ]]
  [[ "${output}" =~ "docker-19.03.5-r1" ]]
  [[ "${output}" =~ "openrc-0.42.1-r2" ]]
  [[ "${output}" =~ "libstdc++-9.2.0-r4" ]]
  [[ "${output}" =~ "nodejs-12.15.0-r1" ]]
  [[ "${output}" =~ "pm-12.15.0-r1" ]]
  [[ "${output}" =~ "jq-1.6_rc1-r1" ]]
}

@test "docker health" {
  run bash -c "docker exec di-circleci-base-image-edge docker version"
  [[ "${output}" =~ "19.03.5" ]]
}

@test "secrethub version" {
  run bash -c "docker exec di-circleci-base-image-edge secrethub --version"
  [[ "${output}" =~ "0.38" ]]
}

@test "snyk version" {
  run bash -c "docker exec di-circleci-base-image-edge snyk --version"
  [[ "${output}" =~ "1.327" ]]
}

@test "conftest version" {
  run bash -c "docker exec di-circleci-base-image-edge conftest --version"
  [[ "${output}" =~ "0.18" ]]
}
