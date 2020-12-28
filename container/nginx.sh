#/bin/sh

mkdir -p ${CONTAINER_ROOT_DIR:-./}

BASE_IMAGE=nginx
OUT=${CONTAINER_ROOT_DIR}_push_nginx.sh

echo '#!/bin/sh' > $OUT

#########

BASE_TAG=stable
docker pull ${BASE_IMAGE}:${BASE_TAG}
VERSION=`docker run --rm -i --entrypoint '' ${BASE_IMAGE}:${BASE_TAG} sh -c 'nginx -v 2>&1 | grep -o [0-9.]*$'`

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

########

BASE_TAG=stable-alpine
docker pull ${BASE_IMAGE}:${BASE_TAG}
VERSION=`docker run --rm -i --entrypoint '' ${BASE_IMAGE}:${BASE_TAG} sh -c 'nginx -v 2>&1 | grep -o [0-9.]*$'`-alpine

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

BASE_TAG=latest
docker pull ${BASE_IMAGE}:${BASE_TAG}
VERSION=`docker run --rm -i --entrypoint '' ${BASE_IMAGE}:${BASE_TAG} sh -c 'nginx -v 2>&1 | grep -o [0-9.]*$'`

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

BASE_TAG=alpine
docker pull ${BASE_IMAGE}:${BASE_TAG}
VERSION=`docker run --rm -i --entrypoint '' ${BASE_IMAGE}:${BASE_TAG} sh -c 'nginx -v 2>&1 | grep -o [0-9.]*$'`-alpine

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
