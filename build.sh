#!/bin/bash
apt-get update
apt-get install -y openjdk-11-jdk git-core build-essential zip curl git-lfs
mkdir -p ~/.bin
PATH="/root/.bin:$PATH"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo
mv ~/.bin/repo /usr/local/bin/repo
git config --global user.name 'shifty-d'
git config --global user.email 'ffoxy2870@gmail.com'
repo init -u https://github.com/LineageOS/android.git --git-lfs -b lineage-18.1 --depth=1
repo sync -c -j 16
git clone https://github.com/parixxshit/android_device_xiaomi_spes -b 11.0 device/xiaomi/spes
git clone https://github.com/Jabiyeff/android_vendor_xiaomi_spes --depth=1 -b 11.0 vendor/xiaomi/spes
git clone https://github.com/muralivijay/kernel_xiaomi_sm6225 --depth=1 kernel/xiaomi/spes
git clone https://github.com/LineageOS/android_hardware_xiaomi --depth=1 -b lineage-18.1 hardware/xiaomi
cd device/xiaomi/spes && git revert 1e3b219 && cd ../../../
source build/envsetup.sh
lunch lineage_spes-eng
mka bacon -j$(nproc --all)
