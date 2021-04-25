#!/bin/bash

set -e

apt update
apt install -y libxcb-xfixes0-dev jq

VERSION=`curl -sL https://api.github.com/repos/alacritty/alacritty/releases/latest | jq -r .tag_name`
URL="https://github.com/alacritty/alacritty/archive/refs/tags/" \

wget $URL$VERSION.zip
unzip $VERSION.zip

DIR=`ls | grep alacritty`

cd $DIR

cargo build --release

cp target/release/alacritty /export/

cp extra/logo/alacritty-simple.svg /export/

cp extra/linux/Alacritty.desktop /export/
