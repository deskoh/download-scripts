#/bin/sh

mkdir -p ${CONTAINER_ROOT_DIR:-_images/}

BASE_IMAGE=node
OUT=${CONTAINER_ROOT_DIR}_push_node.sh

echo '#!/bin/sh' > $OUT

#########

BASE_TAG=lts-slim
docker pull ${BASE_IMAGE}:${BASE_TAG}
VERSION=`docker run --rm node:lts-alpine --version | grep -o [0-9.]*$`-slim

IMAGE=${BASE_IMAGE}:${VERSION}

docker tag ${BASE_IMAGE}:${BASE_TAG} m.cr.io/$IMAGE
docker save -o $CONTAINER_ROOT_DIR$BASE_IMAGE-$VERSION.tar m.cr.io/$IMAGE

docker image rm m.cr.io/$IMAGE
docker image rm ${BASE_IMAGE}:${BASE_TAG}

echo docker load -i $BASE_IMAGE-$VERSION.tar >> $OUT
echo docker push m.cr.io/$IMAGE >> $OUT
echo docker tag m.cr.io/$IMAGE m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker push m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker image rm m.cr.io/$IMAGE >> $OUT
echo docker image rm m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT

#######

BASE_TAG=lts-alpine
docker pull ${BASE_IMAGE}:${BASE_TAG}
VERSION=`docker run --rm node:lts-alpine --version | grep -o [0-9.]*$`-alpine

IMAGE=${BASE_IMAGE}:${VERSION}

docker tag ${BASE_IMAGE}:${BASE_TAG} m.cr.io/$IMAGE
docker save -o $CONTAINER_ROOT_DIR$BASE_IMAGE-$VERSION.tar m.cr.io/$IMAGE

docker image rm m.cr.io/$IMAGE
docker image rm ${BASE_IMAGE}:${BASE_TAG}

echo docker load -i $BASE_IMAGE-$VERSION.tar >> $OUT
echo docker push m.cr.io/$IMAGE >> $OUT
echo docker tag m.cr.io/$IMAGE m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker push m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker image rm m.cr.io/$IMAGE >> $OUT
echo docker image rm m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT

#######

BASE_TAG=current-slim
docker pull ${BASE_IMAGE}:${BASE_TAG}
VERSION=`docker run --rm node:lts-alpine --version | grep -o [0-9.]*$`-slim

IMAGE=${BASE_IMAGE}:${VERSION}

docker tag ${BASE_IMAGE}:${BASE_TAG} m.cr.io/$IMAGE
docker save -o $CONTAINER_ROOT_DIR$BASE_IMAGE-$VERSION.tar m.cr.io/$IMAGE

docker image rm m.cr.io/$IMAGE
docker image rm ${BASE_IMAGE}:${BASE_TAG}

echo docker load -i $BASE_IMAGE-$VERSION.tar >> $OUT
echo docker push m.cr.io/$IMAGE >> $OUT
echo docker tag m.cr.io/$IMAGE m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker push m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker image rm m.cr.io/$IMAGE >> $OUT
echo docker image rm m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT

#######

BASE_TAG=current-alpine
docker pull ${BASE_IMAGE}:${BASE_TAG}
VERSION=`docker run --rm node:lts-alpine --version | grep -o [0-9.]*$`-alpine

IMAGE=${BASE_IMAGE}:${VERSION}

docker tag ${BASE_IMAGE}:${BASE_TAG} m.cr.io/$IMAGE
docker save -o $CONTAINER_ROOT_DIR$BASE_IMAGE-$VERSION.tar m.cr.io/$IMAGE

docker image rm m.cr.io/$IMAGE
docker image rm ${BASE_IMAGE}:${BASE_TAG}

echo docker load -i $BASE_IMAGE-$VERSION.tar >> $OUT
echo docker push m.cr.io/$IMAGE >> $OUT
echo docker tag m.cr.io/$IMAGE m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker push m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
echo docker image rm m.cr.io/$IMAGE >> $OUT
echo docker image rm m.cr.io/${BASE_IMAGE}:${BASE_TAG} >> $OUT
