#!/bin/bash
# Export image as private repo images and generate script that import and push private repo images.
# Usage: ./_export_image.sh IMAGE TAR_FILENAME PRIVATE_IMAGE [ALT_PRIVATE_IMAGE] [-rm]
# Options:
#   -rm: to remove local image after exporting

if [[ "$#" -lt 3 ]]; then
    printf "\n\e[31m\e[1mUsage: ./_export_image.sh IMAGE TAR_FILENAME PRIVATE_IMAGE [ALT_PRIVATE_IMAGE]\n\n"
    printf "Example:\n  ./_export_image.sh node:15 node-15.tar m.cr.io/node:15 m.cr.io/node:latest\e[0m\n\n"
    exit 1
fi

IMAGE=$1
TAR_FILENAME=$2
PRIVATE_IMAGE=$3

if [[ "$4" != "-rm" ]]; then
  ALT_PRIVATE_IMAGE=$4
else
  ALT_PRIVATE_IMAGE=""
fi

if [[ "$*" =~ \ -rm(\ |$) ]]; then
  REMOVE_IMAGE=true
else
  REMOVE_IMAGE=false
fi

echo "Tagging $IMAGE to $PRIVATE_IMAGE"
docker tag $IMAGE $PRIVATE_IMAGE

echo "Exporting $PRIVATE_IMAGE to $TAR_FILENAME"
docker save -o $TAR_FILENAME $PRIVATE_IMAGE

echo "Removing image $PRIVATE_IMAGE"
docker image rm $PRIVATE_IMAGE

if $REMOVE_IMAGE; then
  echo "Removing image $IMAGE"
  docker image rm $IMAGE
fi

printf "\n"

LOAD_SCRIPT=_load_${TAR_FILENAME}.sh
echo "Generating $LOAD_SCRIPT"
echo "#!/bin/sh" > $LOAD_SCRIPT
echo "docker load -i $TAR_FILENAME" >> $LOAD_SCRIPT
echo "docker push $PRIVATE_IMAGE" >> $LOAD_SCRIPT
if [[ $ALT_PRIVATE_IMAGE != "" ]]; then
  echo "docker tag $PRIVATE_IMAGE $ALT_PRIVATE_IMAGE" >> $LOAD_SCRIPT
  echo "docker push $ALT_PRIVATE_IMAGE" >> $LOAD_SCRIPT
  echo "docker image rm $ALT_PRIVATE_IMAGE" >> $LOAD_SCRIPT
fi
echo "docker image rm $PRIVATE_IMAGE" >> $LOAD_SCRIPT

printf "\n"
