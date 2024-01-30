#!/bin/sh
set -e

# Create the user SSH directory, just in case.
# mkdir $HOME/.ssh && chmod 700 $HOME/.ssh

# Retrieve the server-generated RSA private key.
geni-get key > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa

# Derive the corresponding public key portion.
ssh-keygen -y -f $HOME/.ssh/id_rsa > $HOME/.ssh/id_rsa.pub

# If you want to permit login authenticated by the auto-generated key,
# then append the public half to the authorized_keys2 file:
touch $HOME/.ssh/authorized_keys2

grep -q -f $HOME/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys2 || cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys2


# Add the blacklist lines to the file
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
echo "options nouveau modeset=0" | sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf



# Update initramfs
sudo update-initramfs -u

# Reboot the system
sudo reboot
