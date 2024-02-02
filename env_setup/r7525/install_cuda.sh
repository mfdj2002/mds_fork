#!/bin/sh
set -e

# sudo mkfs.ext4 /dev/sdb #will be quite different if on a different machine
sudo mkfs.ext4 /dev/sda4
# sudo mount /dev/sdb /mnt
sudo mount /dev/sda4 /mnt #for r7525

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install Python development packages and pip
sudo apt install python3-dev python3-pip -y

sudo mkdir /mnt/tmp && sudo chmod 1777 /mnt/tmp
cd /mnt/tmp

mnt=/mnt

group=$(id -gn)

sudo chown -R $USER:$group $mnt

for dir in .vscode-server .debug .cache .local; do
    sudo mkdir -p $mnt/$dir
    sudo chown -R $USER:$group $mnt/$dir
    rm -rf ~/$dir
    ln -s $mnt/$dir ~/$dir
done

# set up env vars
echo 'export TMPDIR=/mnt/tmp' >> ~/.bashrc
echo 'export TRANSFORMERS_CACHE=/mnt/tmp' >> ~/.bashrc
echo "export PATH=/usr/local/cuda/bin:$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export PATH=$PATH:/users/jf3516/.local/bin" >> ~/.bashrc

wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda_12.1.0_530.30.02_linux.run
sudo sh cuda_12.1.0_530.30.02_linux.run --installpath=/mnt/cuda --tmpdir=/mnt/tmp

rm cuda_12.1.0_530.30.02_linux.run

sudo dkms autoinstall && sudo modprobe nvidia && sudo reboot





# deepspeed --num_gpus=1 --hostfile /mnt/finetune-gpt2xl/hostfile.txt /mnt/finetune-gpt2xl/run_clm.py\
# --deepspeed /mnt/finetune-gpt2xl/ds_config.json --model_name_or_path gpt2 --train_file /users/jf3516/finetune-gpt2xl/train.csv --validation_file /users/jf3516/finetune-gpt2xl/validation.csv --do_train --do_eval --fp16 --overwrite_cache --evaluation_strategy="steps" --output_dir /mnt/tmp/finetuned --eval_steps 200 --num_train_epochs 1 --gradient_accumulation_steps 2 --per_device_train_batch_size 8


# deepspeed --num_gpus=1 --hostfile /mnt/finetune-gpt2xl/hostfile.txt /mnt/finetune-gpt2xl/run_clm.py \
# --deepspeed /mnt/finetune-gpt2xl/ds_config.json \
# --model_name_or_path gpt2 \
# --train_file /mnt/finetune-gpt2xl/train.csv \
# --validation_file /mnt/finetune-gpt2xl/validation.csv \
# --do_train \
# --do_eval \
# --fp16 \
# --overwrite_cache \
# --evaluation_strategy="steps" \
# --output_dir /mnt/finetune-gpt2xl/finetuned \
# --eval_steps 200 \
# --num_train_epochs 1 \
# --gradient_accumulation_steps 2 \
# --per_device_train_batch_size 8


# deepspeed --num_gpus=1 --hostfile /users/jf3516/finetune-gpt2xl/hostfile.txt /users/jf3516/finetune-gpt2xl/run_clm.py \
# --deepspeed /users/jf3516/finetune-gpt2xl/ds_config.json \
# --model_name_or_path gpt2 \
# --train_file /users/jf3516/finetune-gpt2xl/train.csv \
# --validation_file /users/jf3516/finetune-gpt2xl/validation.csv \
# --do_train \
# --do_eval \
# --fp16 \
# --overwrite_cache \
# --evaluation_strategy="steps" \
# --output_dir finetuned \
# --eval_steps 200 \
# --num_train_epochs 1 \
# --gradient_accumulation_steps 2 \
# --per_device_train_batch_size 8



# deepspeed --num_gpus=1 --hostfile /users/jf3516/finetune-gpt2xl/hostfile.txt /users/jf3516/finetune-gpt2xl/run_clm.py --deepspeed /users/jf3516/finetune-gpt2xl/ds_config.json --model_name_or_path gpt2 --train_file /users/jf3516/finetune-gpt2xl/train.csv --validation_file /users/jf3516/finetune-gpt2xl/validation.csv --do_train --do_eval --fp16 --overwrite_cache --evaluation_strategy="steps" --output_dir finetuned --eval_steps 200 --num_train_epochs 1 --gradient_accumulation_steps 2 --per_device_train_batch_size 8