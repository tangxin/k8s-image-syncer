#!/bin/bash

[ -z $1 ] && exit 1
export target=$1

mkdir -p images/$target
touch images/$target/Dockerfile

mkdir -p .github/workflows/
envsubst <workflow.yml.tmpl >.github/workflows/$target.yml
