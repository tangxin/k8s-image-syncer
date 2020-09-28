#!/bin/bash

set -x
for dockerfile in $(ls dockerfiles); do
    {
        _image=${dockerfile/.Dockerfile/}
        image=${_image%%,*}
        # tag=${_image##*,}
        tag=$(grep FROM dockerfiles/${dockerfile}  | head -n 1 | awk -F'[: ]' '{print $3}')
        

        docker buildx build --push --platform=linux/amd64,linux/arm64 \
            --tag=kubeimages/${image}:${tag} \
            --file=dockerfiles/${dockerfile} \
            --build-arg=TAG=${tag} .

    }
done
