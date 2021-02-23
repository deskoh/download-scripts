#/bin/sh
SCRIPT_DIR=$(dirname "$0")

PRIVATE_REPO=${PRIVATE_REPO:-m.cr.io}
BASE_IMAGE=node

download () {
  IMAGE=$BASE_IMAGE:$1
  TAR_FILENAME=$BASE_IMAGE-$1.tar
  TAG_SUFFIX=$2

  docker pull ${IMAGE}
  VERSION=`docker run --rm ${IMAGE} --version | grep -o [0-9.]*$`
  MAJ_VERSION=`echo $VERSION | cut -f 1 -d .`

  PRIVATE_IMAGE=${PRIVATE_REPO}/${BASE_IMAGE}:$1
  ALT_PRIVATE_IMAGE=${PRIVATE_REPO}/${BASE_IMAGE}:${VERSION}$TAG_SUFFIX
  ALT_PRIVATE_IMAGE_2=${PRIVATE_REPO}/${BASE_IMAGE}:${MAJ_VERSION}$TAG_SUFFIX

  $SCRIPT_DIR/_export_image.sh $3 $IMAGE $TAR_FILENAME $PRIVATE_IMAGE $ALT_PRIVATE_IMAGE $ALT_PRIVATE_IMAGE_2
}

# Optimize download by removing image later
download "lts-slim" "-slim"
download "current-slim" "-slim" "-rm"
docker image rm node:lts-slim

# Optimize download by removing image later
download "lts-alpine" "-alpine"
download "current-alpine" "-alpine" "-rm"
docker image rm node:lts-alpine
