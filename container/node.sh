#/bin/sh

PRIVATE_REPO=${PRIVATE_REPO:-m.cr.io}
BASE_IMAGE=node

download () {
  IMAGE=$BASE_IMAGE:$1
  TAR_FILENAME=$BASE_IMAGE-$1.tar

  docker pull ${IMAGE}
  VERSION=`docker run --rm -i --entrypoint '' ${IMAGE} sh -c 'nginx -v 2>&1 | grep -o [0-9.]*$'`
  VERSION=`docker run --rm ${IMAGE} --version | grep -o [0-9.]*$`

  PRIVATE_IMAGE=${PRIVATE_REPO}/${BASE_IMAGE}:${VERSION}$2
  ALT_PRIVATE_IMAGE=${PRIVATE_REPO}/${BASE_IMAGE}:$1

  ./_export_image.sh $IMAGE $TAR_FILENAME $PRIVATE_IMAGE $ALT_PRIVATE_IMAGE $3
}

# Optimize download by removing image later
download "lts-slim" "-slim"
download "current-slim" "-slim" "-rm"
docker image rm node:lts-slim

# Optimize download by removing image later
download "lts-alpine" "-alpine"
download "current-alpine" "-alpine" "-rm"
docker image rm node:lts-alpine
