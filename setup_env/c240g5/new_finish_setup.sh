#!/bin/sh

sudo mount /dev/sdb /mnt
#sudo mount /dev/sda4 /mnt for r7525


mnt=/mnt

group=$(id -gn)

sudo chown -R $USER:$group $mnt

for dir in .vscode-server .debug .cache .local; do
    sudo mkdir -p $mnt/$dir
    sudo chown -R $USER:$group $mnt/$dir
    rm -rf ~/$dir
    ln -s $mnt/$dir ~/$dir
done



# asyncio dependency
sudo apt-get install libaio-dev pdsh -y


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


sudo apt install python3.8-venv -y
cd /mnt
sudo python3.8 -m venv ds
. /mnt/ds/bin/activate
cd


git clone https://github.com/microsoft/Megatron-DeepSpeed
python Megatron-DeepSpeed/setup.py install

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
git checkout 2386a912164b0c5cfcd8be7a2b890fbac5607c82
cd apex
pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --config-settings "--build-option=--cpp_ext" --config-settings "--build-option=--cuda_ext" ./
cd
