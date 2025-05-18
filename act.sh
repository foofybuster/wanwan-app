#!/bin/bash

export TAG=$(eval ./random.sh)
export IMAGE_TAG=nginx:$TAG

git config --global user.email "bot.bot.com"
git config --global user.name "bot"


git clone git@github.com:foofybuster/nonprod-kube-manifests.git

cd nonprod-kube-manifests

yq -i '.spec.template.spec.containers[0].image = strenv(IMAGE_TAG) ' dev/doubutsu-app/wanwan/deployment.yaml

git commit -am "release the previous version to $IMAGE_TAG"

git push origin main
