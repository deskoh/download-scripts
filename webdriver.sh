#/bin/sh

DOWNLOAD_DIR=webdriver/

DIR=${DOWNLOAD_ROOT_DIR}${DOWNLOAD_DIR}

mkdir -p $DIR

VERSION=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)

wget -P $DIR https://chromedriver.storage.googleapis.com/$VERSION/chromedriver_win32.zip
wget -P $DIR https://chromedriver.storage.googleapis.com/87.0.4280.88/chromedriver_linux64.zip

MAJ_VERSION=`echo $VERSION | cut -d. -f1`

mkdir -p $DIR$MAJ_VERSION
unzip ${DIR}chromedriver_win32.zip -d ${DIR}$MAJ_VERSION
unzip ${DIR}chromedriver_linux64.zip -d ${DIR}$MAJ_VERSION


rm -f ${DIR}chromedriver_win32.zip
rm -f ${DIR}chromedriver_linux64.zip
