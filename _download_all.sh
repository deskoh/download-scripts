export CONTAINER_ROOT_DIR=_images/

./container/nginx.sh
./container/node.sh

export DOWNLOAD_ROOT_DIR=_downloads/

./chrome.sh
./edge.sh
./vscode.sh
./webdriver.sh