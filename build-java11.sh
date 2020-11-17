#!/bin/bash

export DOCKER_CONTENT_TRUST=1
GRAALVM_VERSION=20.2.0
JAVA_VERSION=java11
GRAALVM_MAJOR_VERSION=$(echo $GRAALVM_VERSION | sed 's/\.[0-9].*//1')

TAG=citypay/graal-$JAVA_VERSION:$GRAALVM_VERSION
TAG2=citypay/graal-$JAVA_VERSION:$GRAALVM_MAJOR_VERSION
TAG_LATEST=citypay/graal-$JAVA_VERSION:latest


docker build --pull \
    --build-arg GRAALVM_VERSION=$GRAALVM_VERSION \
    --build-arg JAVA_VERSION=$JAVA_VERSION \
    -t $TAG \
    -t $TAG2 \
    -t $TAG_LATEST .

docker push $TAG
docker push $TAG2
docker push $TAG_LATEST

docker trust sign $TAG
docker trust sign $TAG2
docker trust sign $TAG_LATEST

