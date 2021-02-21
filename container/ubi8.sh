#/bin/sh

PRIVATE_REPO=${PRIVATE_REPO:-m.cr.io}

download () {
  REPO_URL=$1
  BASE_IMAGE=$2
  BASE_VERSION=$3

  IMAGE=$REPO_URL/$BASE_IMAGE:$BASE_VERSION
  TAR_FILENAME=$(echo $BASE_IMAGE | tr / -).tar

  docker pull ${IMAGE}

  PRIVATE_IMAGE=${PRIVATE_REPO}/${BASE_IMAGE}:${BASE_VERSION}
  ALT_PRIVATE_IMAGE=${PRIVATE_REPO}/${BASE_IMAGE}:$4

  ./_export_image.sh $IMAGE $TAR_FILENAME $PRIVATE_IMAGE $ALT_PRIVATE_IMAGE -rm
}

get_version() {
  if [[ $TAGS =~ *\"latest\"* ]]; then
    echo "Latest not found in tags: $TAGS"
    exit 1
  fi

  # e.g. 8.3
  VERSION=$(echo $TAGS | jq -r '.[0]')
  if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+$ ]]; then
    echo "Unexpected version format: $VERSION"
    exit 1
  fi

  # e.g. 8.3-291
  FULL_VERSION=$(echo $TAGS | jq -r '.[2]')
  if ! [[ $FULL_VERSION =~ ^[0-9]+\.[0-9]+-[0-9]+$ ]]; then
    echo "Unexpected full version format: $FULL_VERSION"
    exit 1
  fi
}


URL="https://catalog.redhat.com/api/containers/v1/repositories/registry/registry.access.redhat.com/repository/ubi8/ubi-minimal/images?include=data.repositories.signatures.tags,data.architecture&page_size=100&page=0"
TAGS=`curl -s $URL | jq -r '[.data[] | select(.architecture == "amd64").repositories[].signatures[] | select(.tags[] | contains("latest"))][0].tags'`
get_version $TAGS
download "registry.access.redhat.com" "ubi8/ubi-minimal" $VERSION $FULL_VERSION

URL="https://catalog.redhat.com/api/containers/v1/repositories/registry/registry.access.redhat.com/repository/ubi8/ubi/images?include=data.repositories.signatures.tags,data.architecture&page_size=100&page=0"
TAGS=`curl -s $URL | jq -r '[.data[] | select(.architecture == "amd64").repositories[].signatures[] | select(.tags[] | contains("latest"))][0].tags'`
get_version $TAGS
download "registry.access.redhat.com" "ubi8/ubi" $VERSION $FULL_VERSION
