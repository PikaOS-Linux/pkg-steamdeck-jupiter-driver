#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://github.com/KyleGospo/jupiter-fan-control
git clone https://github.com/KyleGospo/jupiter-hw-support
mkdir -p ./steamdeck-jupiter-driver
cp -rvf ./jupiter-fan-control/usr ./steamdeck-jupiter-driver
cp -rvf ./jupiter-hw-support/etc ./steamdeck-jupiter-driver
cp -rvf ./jupiter-hw-support/usr ./steamdeck-jupiter-driver
cp -rvf ./debian ./steamdeck-jupiter-driver
cd ./steamdeck-jupiter-driver

# Get build deps
apt-get build-dep ./ -y

# Patch
for i in ../patches/*.patch; do patch -Np1 -i $i;done
rm -rfv ./usr/lib/systemd/system/multi-user.target.wants

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
