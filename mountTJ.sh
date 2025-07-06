#!/usr/bin/env sh

mkdir -p /mnt/TJ
mkdir -p /mnt/TJVideos
mkdir -p /mnt/"TJ homes"

if mount -t nfs 192.168.86.84:/volume1/TJ /mnt/TJ; then
  echo "Mounted TJ"
else
  echo "Unable to mount TJ"
fi

if mount -t nfs 192.168.86.84:/volume1/TJVideos /mnt/TJVideos; then
  echo "Mounted TJVideos"
else
  echo "Unable to mount TJVideos"
fi

if mount -t nfs 192.168.86.84:/volume1/homes /mnt/"TJ homes"; then
  echo "Mounted TJ homes"
else
  echo "Unable to mount TJ homes"
fi
