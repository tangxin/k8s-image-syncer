#!/bin/bash
# 
# usage: ./new.sh pause

[ -z $1 ] && exit 1
export target=$1

mkdir -p images/$target
touch images/$target/Dockerfile

mkdir -p .github/workflows/
envsubst <tmpl/workflow.yml >.github/workflows/$target.yml

envsubst < tmpl/dependabot/header.yml > .github/dependabot.yml
for target in $(ls images)
do
{
    envsubst <tmpl/dependabot/body.yml >> .github/dependabot.yml
}
done
