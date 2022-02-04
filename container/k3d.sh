#/bin/sh
SCRIPT_DIR=$(dirname "$0")

PRIVATE_REPO=${PRIVATE_REPO:-m.cr.io}

save () {
  IMAGE=$1
  TAR_FILENAME=$2
  PRIVATE_IMAGE=${3:-PRIVATE_REPO}/${IMAGE}

  $SCRIPT_DIR/_export_image.sh -rm $IMAGE $TAR_FILENAME $PRIVATE_IMAGE
}

# Get latest k3s release version
VERSION=$(curl -s https://api.github.com/repos/k3s-io/k3s/releases/latest \
  | grep "tag_name" \
  | cut -d '"' -f 4)

# Replace '+' with '-'
  TAG=$(echo $VERSION | sed --expression='s/+/-/g')

# Check if k3s-airgap-images-amd64.tar exists
if [ ! -f k3s-airgap-images-amd64.tar ]; then
  echo Downloading k3s release $VERSION

  echo "Downloading k3s-airgap-images-amd64.tar"

  curl -s https://api.github.com/repos/k3s-io/k3s/releases/latest \
    | grep "browser_download_url.*k3s-airgap-images-amd64.tar\"" \
    | cut -d '"' -f 4  \
    | xargs curl -LO

  # Replace string after colon on first line with $TAG
  sed -i "1s/:.*/:$TAG/" k3d.Dockerfile
fi

IMAGE=k3s-airgap:$TAG
docker build -f k3d.Dockerfile . -t $IMAGE
save $IMAGE k3s-airgap-$TAG.tar p.cr.io

rm -f k3s-airgap-images-amd64.tar

# Download k3d images
VERSION=$(curl -s https://api.github.com/repos/rancher/k3d/releases/latest \
  | grep "tag_name" \
  | cut -d '"' -f 4)

# Remove 'v' from $VERSION
TAG=${VERSION/v/}

docker pull rancher/k3d-tools:$TAG
docker pull rancher/k3d-proxy:$TAG

save rancher/k3d-tools:$TAG rancher-k3d-tools-$TAG.tar
save rancher/k3d-proxy:$TAG rancher-k3d-proxy-$TAG.tar

# Download k3d bin

echo Downlading k3d binaries

DOWNLOAD_DIR=k3d/$VERSION/
DIR=${DOWNLOAD_ROOT_DIR:-../_downloads/}${DOWNLOAD_DIR}
mkdir -p $DIR

curl -s https://api.github.com/repos/rancher/k3d/releases/latest \
    | grep "browser_download_url.*k3d-linux-amd64\"" \
    | cut -d '"' -f 4  \
    | xargs curl -L -o ${DIR}k3d-linux-amd64

curl -s https://api.github.com/repos/rancher/k3d/releases/latest \
    | grep "browser_download_url.*k3d-windows-amd64.exe\"" \
    | cut -d '"' -f 4  \
    | xargs curl -L -o ${DIR}k3d-windows-amd64.exe

echo Create k3d cluster using command 'k3d cluster create --image k3s-airgap:$TAG'
