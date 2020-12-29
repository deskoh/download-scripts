#/bin/sh

DOWNLOAD_DIR=vscode/

DIR=${DOWNLOAD_ROOT_DIR:-_downloads/}${DOWNLOAD_DIR}

mkdir -p $DIR

curl -LJO "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
curl -LJO "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64"

mv VSCode* $DIR
