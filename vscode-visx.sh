#/bin/sh

DOWNLOAD_DIR=vscode-vsix/

DIR=${DOWNLOAD_ROOT_DIR:-_downloads/}${DOWNLOAD_DIR}

mkdir -p $DIR

DATA=`curl -s -XPOST 'https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery' \
  --header 'Accept: application/json;api-version=6.1-preview.1' \
  --header 'Content-Type: application/json' \
  --data-binary "{\"assetTypes\": [\"Microsoft.VisualStudio.Services.VSIXPackage\"],\"filters\": [{\"criteria\": [{\"filterType\": 7,\"value\": \"${EXT}\"}]}],\"flags\": 3}"`

EXTNAME=`echo $DATA | jq -r '.results[0].extensions[0].displayName'`
URL=`echo $DATA | jq -r '.results[0].extensions[0].versions[0].files[0].source'`
VERSION=`echo $DATA | jq -r '.results[0].extensions[0].versions[0].version'`

echo Downloading $EXTNAME $VERSION

curl -sL -o "$DIR/${EXTNAME}-${VERSION}.vsix" $URL

mkdir -p $DIR/latest
ln -sf "$DIR/${EXTNAME}-${VERSION}.vsix" "$DIR/latest/${EXTNAME}.vsix"
