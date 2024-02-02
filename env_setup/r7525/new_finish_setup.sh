#!/bin/sh
set -e

# sudo mount /dev/sdb /mnt
sudo mount /dev/sda4 /mnt #for r7525


# asyncio dependency
sudo apt-get install libaio-dev pdsh -y


sudo apt install python3.8-venv -y
cd /mnt
sudo python3.8 -m venv ds
. /mnt/ds/bin/activate
cd


# git clone https://github.com/microsoft/Megatron-DeepSpeed
cd Megatron-DeepSpeed
python setup.py install
cd ..

git clone https://github.com/EleutherAI/pile-enron-emails
pip install -r pile-enron-emails/requirements.txt


# Install DeepSpeed
pip install --upgrade pip
pip install --upgrade wheel
pip install --upgrade setuptools

pip install torch torchvision torchaudio
pip install --no-cache-dir deepspeed
pip install transformers


git clone https://github.com/NVIDIA/apex
cd apex
git checkout 2386a912164b0c5cfcd8be7a2b890fbac5607c82

pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --config-settings "--build-option=--cpp_ext" --config-settings "--build-option=--cuda_ext" ./
cd
