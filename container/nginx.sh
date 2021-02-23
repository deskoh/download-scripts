#/bin/sh
SCRIPT_DIR=$(dirname "$0")

PRIVATE_REPO=${PRIVATE_REPO:-m.cr.io}
BASE_IMAGE=nginx


download () {
  IMAGE=$BASE_IMAGE:$1
  TAR_FILENAME=$BASE_IMAGE-$1.tar

  docker pull ${IMAGE}
  VERSION=`docker run --rm -i --entrypoint '' ${IMAGE} sh -c 'nginx -v 2>&1 | grep -o [0-9.]*$'`

  PRIVATE_IMAGE=${PRIVATE_REPO}/${BASE_IMAGE}:${VERSION}$2
  ALT_PRIVATE_IMAGE=${PRIVATE_REPO}/${BASE_IMAGE}:$1

  $SCRIPT_DIR/_export_image.sh -rm $IMAGE $TAR_FILENAME $PRIVATE_IMAGE $ALT_PRIVATE_IMAGE
}

download "stable"
download "stable-alpine" "-alpine"
download "latest"
download "alpine" "-alpine"
