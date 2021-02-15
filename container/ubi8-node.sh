#/bin/sh

mkdir -p ${CONTAINER_ROOT_DIR:-_images/}
OUT=${CONTAINER_ROOT_DIR:-_images/}_push_ubi8-node.sh
echo '#!/bin/sh' > $OUT

BASE_REGISTRY=registry.access.redhat.com

#######

BASE_IMAGE=ubi8/nodejs-12
TAR_NAME=ubi8-nodejs-12

docker pull ${BASE_REGISTRY}/${BASE_IMAGE}
VERSION=`docker run --rm ${BASE_REGISTRY}/${BASE_IMAGE} node --version | grep -o [0-9.]*$`

IMAGE=${BASE_IMAGE}:${VERSION}

docker tag ${BASE_REGISTRY}/${BASE_IMAGE} m.cr.io/$IMAGE
docker save -o ${CONTAINER_ROOT_DIR:-_images/}$TAR_NAME-$VERSION.tar m.cr.io/$IMAGE

docker image rm m.cr.io/$IMAGE
docker image rm ${BASE_REGISTRY}/${BASE_IMAGE}

echo docker load -i $TAR_NAME-$VERSION.tar >> $OUT
echo docker push m.cr.io/$IMAGE >> $OUT
echo docker tag m.cr.io/$IMAGE m.cr.io/${BASE_IMAGE} >> $OUT
echo docker tag m.cr.io/$IMAGE m.cr.io/${BASE_IMAGE}:latest >> $OUT
echo docker push m.cr.io/${BASE_IMAGE} >> $OUT
echo docker push m.cr.io/${BASE_IMAGE}:latest >> $OUT
echo docker image rm m.cr.io/$IMAGE >> $OUT
echo docker image rm m.cr.io/${BASE_IMAGE} >> $OUT
echo docker image rm m.cr.io/${BASE_IMAGE}:latest >> $OUT

#######