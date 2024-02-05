cd /tmp
git clone https://github.com/NVIDIA/apex
cd apex
git checkout 2386a912164b0c5cfcd8be7a2b890fbac5607c82

pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --config-settings "--build-option=--cpp_ext" --config-settings "--build-option=--cuda_ext" ./
cd /home
