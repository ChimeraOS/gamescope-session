#!/bin/bash

if [[ -d /frzr_root ]]; then
  ### Checking for frzr based deployment and grabbing the build in use.
  ID=$(grep '^ID=' /etc/os-release | awk -F= '{ print $2 }' | sed 's/"//g')
  VERSIONID=$(grep '^VERSION_ID=' /etc/os-release | awk -F= '{ print $2 }' | sed 's/"//g')
  BUILDID=$(grep '^BUILD_ID=' /etc/os-release | awk -F= '{ print $2 }' | sed 's/"//g')

  BUILD="$ID"-"$VERSIONID"_"$BUILDID"
  DEPLOYMENT_PATH="/frzr_root/deployments/$BUILD"
  # Get locked state
  RELOCK=0
  LOCK_STATE=$(btrfs property get -fts "$DEPLOYMENT_PATH")

  if [[ $LOCK_STATE == *"ro=true"* ]]; then
    btrfs property set -fts "${DEPLOYMENT_PATH}" ro false
    RELOCK=1
  else
    echo "Filesystem appears to be unlocked"
  fi
fi
    
if /usr/bin/lspci | grep -i nvidia; then
  if [ -f /usr/share/vulkan/icd.d/nvidia_icd.json.bak ]; then
    mv /usr/share/vulkan/icd.d/nvidia_icd.json.bak /usr/share/vulkan/icd.d/nvidia_icd.json
  fi
else
  if [ -f /usr/share/vulkan/icd.d/nvidia_icd.json ]; then
    mv /usr/share/vulkan/icd.d/nvidia_icd.json /usr/share/vulkan/icd.d/nvidia_icd.json.bak
  fi
fi

if [[ -d /frzr_root ]] && [[ $RELOCK == 1 ]]; then
  btrfs property set -fts "${DEPLOYMENT_PATH}" ro true
fi

