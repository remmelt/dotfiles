#! /usr/bin/env bash

set -Eeuo pipefail

yawsso
export AWS_PROFILE=infra
CODEARTIFACT_AUTH_TOKEN=$(aws codeartifact get-authorization-token --domain source-ag --query authorizationToken --output text)
export CODEARTIFACT_AUTH_TOKEN
poetry config http-basic.source-python-packages aws ${CODEARTIFACT_AUTH_TOKEN}
