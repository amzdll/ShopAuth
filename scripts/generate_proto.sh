#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

DIR_NAME=$1
FILE_NAME=$(echo $DIR_NAME | sed 's/_v[0-9]*$//')

mkdir -p pkg/$DIR_NAME

protoc --proto_path=api/$DIR_NAME \
    --go_out=./pkg/$DIR_NAME \
    --go_opt=paths=source_relative \
    --plugin=protoc-gen-go=bin/protoc-gen-go \
    --go-grpc_out=./pkg/$DIR_NAME \
    --go-grpc_opt=paths=source_relative \
    --plugin=protoc-gen-go-grpc=./bin/protoc-gen-go-grpc \
    api/$DIR_NAME/$FILE_NAME.proto