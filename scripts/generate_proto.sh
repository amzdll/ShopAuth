#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

VERSION=$1
SHORT_VERSION=$(echo $VERSION | sed 's/_v[0-9]*$//')

mkdir -p src/pkg/$VERSION

protoc --proto_path=api/$VERSION \
    --go_out=./pkg/$VERSION \
    --go_opt=paths=source_relative \
    --plugin=protoc-gen-go=bin/protoc-gen-go \
    --go-grpc_out=./pkg/$VERSION \
    --go-grpc_opt=paths=source_relative \
    --plugin=protoc-gen-go-grpc=$(pwd)/bin/protoc-gen-go-grpc \
    api/$VERSION/$SHORT_VERSION.proto