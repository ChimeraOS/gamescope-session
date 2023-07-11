#!/bin/bash

if /usr/bin/lspci | grep -i nvidia; then
  if [ -f /usr/share/vulkan/icd.d/nvidia_icd.json.bak ]; then
    mv /usr/share/vulkan/icd.d/nvidia_icd.json.bak /usr/share/vulkan/icd.d/nvidia_icd.json
  fi
else
  if [ -f /usr/share/vulkan/icd.d/nvidia_icd.json ]; then
    mv /usr/share/vulkan/icd.d/nvidia_icd.json /usr/share/vulkan/icd.d/nvidia_icd.json.bak
  fi
fi

