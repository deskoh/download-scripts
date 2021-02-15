#/bin/sh

mkdir -p ${CONTAINER_ROOT_DIR:-_images/}

BASE_REGISTRY=registry.redhat.io
BASE_IMAGE=ubi8/ubi-minimal
OUT=${CONTAINER_ROOT_DIR:-_images/}_push_ubi8-minimal.sh
TAR_NAME=ubi8-ubi-minimal

echo '#!/bin/sh' > $OUT
#########
# ubi-minimal
# e.g. 8.3
BASE_TAG=`curl -s "https://catalog.redhat.com/api/containers/v1/repositories/registry/registry.access.redhat.com/repository/ubi8/ubi-minimal/images?include=data.repositories.signatures.tags&page_size=1&page=0" | jq -r '.data[].repositories[0].signatures[0].tags[2]'`
docker pull ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}
# e.g. 8.3-230
VERSION=`curl -s "https://catalog.redhat.com/api/containers/v1/repositories/registry/registry.access.redhat.com/repository/ubi8/ubi-minimal/images?include=data.repositories.signatures.tags&page_size=1&page=0" | jq -r '.data[].repositories[0].signatures[0].tags[1]'`

IMAGE=${BASE_IMAGE}:${VERSION}

docker tag ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG} m.cr.io/$IMAGE
docker save -o ${CONTAINER_ROOT_DIR:-_images/}$TAR_NAME-$VERSION.tar m.cr.io/$IMAGE

docker image rm m.cr.io/$IMAGE
docker image rm ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

echo docker load -i $TAR_NAME-$VERSION.tar >> $OUT
echo docker push m.cr.io/$IMAGE >> $OUT
echo docker tag m.cr.io/$IMAGE m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker tag m.cr.io/$IMAGE m.cr.io/${BASE_IMAGE}:latest >> $OUT
echo docker push m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker push m.cr.io/${BASE_IMAGE}:latest >> $OUT
echo docker image rm m.cr.io/$IMAGE >> $OUT
echo docker image rm m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker image rm m.cr.io/${BASE_IMAGE}:latest >> $OUT

#######
# ubi

BASE_IMAGE=ubi8/ubi
OUT=${CONTAINER_ROOT_DIR:-_images/}_push_ubi8.sh
TAR_NAME=ubi8-ubi

# e.g. 8.3
URL="https://catalog.redhat.com/api/containers/v1/repositories/registry/registry.access.redhat.com/repository/ubi8/ubi/images?include=data.repositories.signatures.tags,data.architecture&page_size=100&page=0"
BASE_TAG=`curl -s $URL | jq -r '[.data[] | select(.architecture == "amd64").repositories[].signatures[] | select(.tags[] | contains("latest"))][0].tags[2]'`
docker pull ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}
# e.g. 8.3-230
VERSION=`curl -s $URL | jq -r '[.data[] | select(.architecture == "amd64").repositories[].signatures[] | select(.tags[] | contains("latest"))][0].tags[1]'`

IMAGE=${BASE_IMAGE}:${VERSION}

docker tag ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG} m.cr.io/$IMAGE
docker save -o ${CONTAINER_ROOT_DIR:-_images/}$TAR_NAME-$VERSION.tar m.cr.io/$IMAGE

docker image rm m.cr.io/$IMAGE
docker image rm ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

echo docker load -i $TAR_NAME-$VERSION.tar >> $OUT
echo docker push m.cr.io/$IMAGE >> $OUT
echo docker tag m.cr.io/$IMAGE m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker tag m.cr.io/$IMAGE m.cr.io/${BASE_IMAGE}:latest >> $OUT
echo docker push m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker push m.cr.io/${BASE_IMAGE}:latest >> $OUT
echo docker image rm m.cr.io/$IMAGE >> $OUT
echo docker image rm m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker image rm m.cr.io/${BASE_IMAGE}:latest >> $OUT