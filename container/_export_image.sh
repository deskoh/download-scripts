#!/bin/bash
# Export image as private repo images and generate script that import and push private repo images.
# Usage: $SCRIPT_DIR/_export_image.s.sh  [-rm] IMAGE TAR_FILENAME PRIVATE_IMAGE [PRIVATE_IMAGE_1] [PRIVATE_IMAGE_2] ...
# Options:
#   -rm: to remove IMAGE after exporting

if [[ "$1" == "-rm" ]]; then
  REMOVE_IMAGE=true
  shift
else
  REMOVE_IMAGE=false
fi

if [[ "$#" -lt 3 ]]; then
  printf "\n\e[31m\e[1mUsage: ./_export_image.sh [-rm] IMAGE TAR_FILENAME PRIVATE_IMAGE [ALT_PRIVATE_IMAGE]\n\n"
  printf "Example:\n  ./_export_image.sh node:15 node-15.tar m.cr.io/node:15 m.cr.io/node:latest\e[0m\n\n"
  exit 1
fi

IMAGE=$1
TAR_FILENAME=$2
PRIVATE_IMAGE=$3

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

for ALT_PRIVATE_IMAGE in "${@:4}"
do
  echo >> $LOAD_SCRIPT
  echo "docker tag $PRIVATE_IMAGE $ALT_PRIVATE_IMAGE" >> $LOAD_SCRIPT
  echo "docker push $ALT_PRIVATE_IMAGE" >> $LOAD_SCRIPT
  echo "docker image rm $ALT_PRIVATE_IMAGE" >> $LOAD_SCRIPT
done

echo >> $LOAD_SCRIPT
echo "docker image rm $PRIVATE_IMAGE" >> $LOAD_SCRIPT

printf "\n"
