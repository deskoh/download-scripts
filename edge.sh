#/bin/sh

DOWNLOAD_DIR=edge/

DIR=${DOWNLOAD_ROOT_DIR:-_downloads/}${DOWNLOAD_DIR}

mkdir -p $DIR

curl -L -o ${DIR}MicrosoftEdgeEnterpriseX64.msi "http://go.microsoft.com/fwlink/?LinkID=2093437"