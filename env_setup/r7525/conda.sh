#!/bin/sh
set -e

mnt=/mnt

mkdir -p $mnt/miniconda3
# cd $mnt/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $mnt/miniconda3/miniconda.sh
bash $mnt/miniconda3/miniconda.sh -b -u -p $mnt/miniconda3
rm -rf $mnt/miniconda3/miniconda.sh

echo "export PATH=$mnt/miniconda3/bin:$PATH" >> ~/.bashrc

conda init
source ~/.bashrc
conda activate