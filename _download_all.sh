# Container images
# export CONTAINER_ROOT_DIR=_images/

./container/nginx.sh
./container/node.sh

# Applications
# export DOWNLOAD_ROOT_DIR=_downloads/

./chrome.sh
./edge.sh
./node.sh
./vscode.sh
./webdriver.sh

# VS Code Extensions

while read line; do
  export EXT=$line
  ./vscode-visx.sh
done <vscode-visx.txt
