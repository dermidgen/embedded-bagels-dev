#!/bin/bash

##
# NAND flash helpers
##

ACM_DEVICE="03eb:6124"

check_acm_device ()
{
  echo "Checking for ACM Device: `lsusb | grep -q "\b$ACM_DEVICE\b"`"
  lsusb | grep -q "\b$ACM_DEVICE\b"
}

wait_for_acm_device ()
{
  while ! check_acm_device; do
    sleep 5
  done
}
