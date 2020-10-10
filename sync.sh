#!/bin/bash

TARGET=$1
[ -z ${TARGET} ] && exit 1

for dockerfile in $(ls ${TARGET}); do
    {
        # _image=${dockerfile/.Dockerfile/}
        _image=$(basename ${TARGET})
        image=${_image%%,*}
        # tag=${_image##*,}
        tag=$(grep FROM ${TARGET}/${dockerfile} | head -n 1 | awk -F'[: ]' '{print $3}')
        [ -z "${tag}" ] && tag=latest

        docker buildx build --push --platform=linux/amd64,linux/arm64 \
            --tag=kubeimages/${image}:${tag} \
            --file=${TARGET}/${dockerfile} \
            --build-arg=TAG=${tag} .

    }
done
