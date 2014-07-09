#!/bin/bash

if [ "$(id -u)" != "0" ]; then
  echo "You have to be root to run this script"
  exit 1
fi

if [ ! -d /etc/chromium ]
then
  echo "Please, install Chromium before rerunning this script"
  exit 1
fi

if [[ "$1" != "i386" && "$1" != "amd64" ]]
then
  echo "Usage:" 
  echo "sh install_pepperflash_in_chromium_sa.sh <arch>"
  echo "where <arch> can be either i386 or amd64"
  echo "If unsure, you can use 'uname -m' to find out"
  exit 1
fi

if [ ! -d /usr/lib/PepperFlash ]
then
  mkdir /usr/lib/PepperFlash
fi

if [ ! -d /tmp/chrome ]
then
  mkdir /tmp/chrome
else 
  rm -rf /tmp/chrome/*
fi

wget -O /tmp/chrome/google-chrome-stable_current_${1}.deb https://dl.google.com/linux/direct/google-chrome-stable_current_${1}.deb
ar p /tmp/chrome/google-chrome-stable_current_${1}.deb data.tar.lzma | tar -C /tmp/chrome --lzma -x
cp /tmp/chrome/opt/google/chrome/PepperFlash/* /usr/lib/PepperFlash/
rm -rf /tmp/chrome

PEPPER_FLASH_VERSION=$(grep '"version":' /usr/lib/PepperFlash/manifest.json| grep -Po '(?<=version": ")(?:\d|\.)*')
echo 'CHROMIUM_FLAGS="--password-store=detect --ppapi-flash-path=/usr/lib/PepperFlash/libpepflashplayer.so --ppapi-flash-version='$PEPPER_FLASH_VERSION'"' > /etc/chromium/default

echo
echo '(Re)start Chromium'
echo 'Check whether flash '$PEPPER_FLASH_VERSION 'is now under chrome://plugins/'
echo 'You may want to tick "Always allowed"'
echo