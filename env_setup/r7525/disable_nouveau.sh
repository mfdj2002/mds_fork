#!/bin/sh
set -e

# Add the blacklist lines to the file
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
echo "options nouveau modeset=0" | sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf



# Update initramfs
sudo update-initramfs -u

# Reboot the system
sudo reboot
