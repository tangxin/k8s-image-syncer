#!/bin/bash


cat > README.md <<EOF
# k8s image syncer
sync image to your repo for kubernetes

## $(date +%F)

EOF

for dockerfile in $(ls dockerfiles); do
    {
        _image=${dockerfile/.Dockerfile/}
        image=${_image%%,*}
        # tag=${_image##*,}
        tag=$(grep FROM dockerfiles/${dockerfile}  | head -n 1 | awk -F'[: ]' '{print $3}')
        [ -z "${tag}" ] && tag=latest

        docker buildx build --push --platform=linux/amd64,linux/arm64 \
            --tag=kubeimages/${image}:${tag} \
            --file=dockerfiles/${dockerfile} \
            --build-arg=TAG=${tag} .

        echo "+ [kubeimages/${image}:${tag}](https://hub.docker.com/r/kubeimages/${image}/tags)" | tee -a README.md

    }
done
