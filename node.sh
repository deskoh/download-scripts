#/bin/sh

DOWNLOAD_DIR=node/

DIR=${DOWNLOAD_ROOT_DIR:-_downloads/}${DOWNLOAD_DIR}

mkdir -p $DIR

VERSION=`curl -s  https://api.github.com/repos/nodejs/node/releases  | jq -r '[ .[] | select(.tag_name | startswith("v14"))][0].tag_name'`
wget -P $DIR https://nodejs.org/dist/latest-v14.x/node-${VERSION}-x64.msi

VERSION=`curl -s  https://api.github.com/repos/nodejs/node/releases  | jq -r '[ .[] | select(.tag_name | startswith("v12"))][0].tag_name'`
wget -P $DIR https://nodejs.org/dist/latest-v12.x/node-${VERSION}-x64.msi