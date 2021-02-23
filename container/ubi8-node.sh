#/bin/sh
SCRIPT_DIR=$(dirname "$0")

PRIVATE_REPO=${PRIVATE_REPO:-m.cr.io}

download () {
  REPO_URL=$1
  BASE_IMAGE=$2

  IMAGE=$REPO_URL/$BASE_IMAGE
  TAR_FILENAME=$(echo $BASE_IMAGE | tr / -).tar

  docker pull ${IMAGE}
  VERSION=`docker run --rm ${IMAGE} node --version | grep -o [0-9.]*$`

  PRIVATE_IMAGE=${PRIVATE_REPO}/${BASE_IMAGE}:${VERSION}
  ALT_PRIVATE_IMAGE=${PRIVATE_REPO}/${BASE_IMAGE}:latest

  $SCRIPT_DIR/_export_image.sh $IMAGE $TAR_FILENAME $PRIVATE_IMAGE $ALT_PRIVATE_IMAGE $3
}

# Optimize download by removing image later
download "registry.access.redhat.com" "ubi8/nodejs-12"

download "registry.access.redhat.com" "ubi8/nodejs-14" -rm
