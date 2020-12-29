#/bin/sh

DOWNLOAD_DIR=chrome/

DIR=${DOWNLOAD_ROOT_DIR:-_downloads/}${DOWNLOAD_DIR}

mkdir -p $DIR

VERSION=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
curl -L -o "${DIR}ChromeStandaloneSetup64-$VERSION.exe" "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BFD62DDBC-14C6-20BD-706F-C7744738E422%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe"