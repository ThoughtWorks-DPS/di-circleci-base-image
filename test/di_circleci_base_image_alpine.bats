#!/usr/bin/env bats

@test "sudo version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge sudo --version"
  [[ "${output}" =~ "1.9" ]]
}

@test "bash version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge bash --version"
  [[ "${output}" =~ "5.1.4" ]]
}

@test "curl version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge curl --version"
  [[ "${output}" =~ "7.77.0" ]]
}

@test "ssh version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge ssh -V"
  [[ "${output}" =~ "1.1.1k" ]]
}

@test "gpg version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge gpg --version"
  [[ "${output}" =~ "2.2.27" ]]
}

@test "docker health" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge docker version"
  [[ "${output}" =~ "20.10.7" ]]
}

@test "node version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge node -v"
  [[ "${output}" =~ "14.17.1" ]]
}

@test "npm version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge npm -v"
  [[ "${output}" =~ "7.17.0" ]]
}

@test "check locale" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge locale"
  [[ "${output}" =~ "LC_ALL=en_US.UTF-8" ]]
}

@test "secrethub version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge secrethub --version"
  [[ "${output}" =~ "0.42.1" ]]
}

@test "snyk version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge snyk --version"
  [[ "${output}" =~ "1.653.0" ]]
}

@test "bats version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge bats -v"
  [[ "${output}" =~ "1.3.0" ]]
}

@test "conftest version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge conftest --version"
  [[ "${output}" =~ "0.25.0" ]]
}

@test "chamber version" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge chamber version"
  [[ "${output}" =~ "2.10.1" ]]
}

@test "describe user circleci" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge getent passwd | grep circleci"
  [[ "${output}" =~ "circleci:x:3434:3434" ]]
  [[ "${output}" =~ "/home/circleci" ]]
}

@test "describe user circleci group" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge getent group | grep circleci"
  [[ "${output}" =~ "circleci:x:3434:circleci" ]]
}

@test "describe /home/circleci" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge ls -ld /home/circleci"
  [[ "${output}" =~ "circleci circleci" ]]
}

@test "describe /home/circleci/project" {
  run bash -c "docker exec di-circleci-base-image-alpine-edge ls -ld /home/circleci/project"
  [[ "${output}" =~ "circleci circleci" ]]
}
