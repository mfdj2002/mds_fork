FROM nvcr.io/nvidia/pytorch:23.04-py3

ENV DEBIAN_FRONTEND noninteractive

##############################################################################
# Temporary Installation Directory
##############################################################################
ENV STAGE_DIR=/tmp
RUN mkdir -p ${STAGE_DIR}

ENV MLNX_OFED_VERSION=5.4-3.7.5.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    kmod \
    chrpath \
    ethtool \
    udev \
    debhelper \
    bison \
    tk \
    dpatch \
    tcl \
    graphviz \
    libpci-dev \ 
    libmnl-dev \ 
    pciutils \
    flex \
    libfuse2 \
    libusb-1.0-0 \
    swig \
    libltdl-dev \
    libelf-dev \ 
    lsof

# Note: `libpci3` might be a runtime library. `libpci-dev` provides development files and is commonly required for installation.
# `libmnl0` might refer to the runtime library, and `libmnl-dev` is the development package.
# `libelf1` might refer to the runtime library. `libelf-dev` provides the development files.
    

# Note about package names:
# Some package names might slightly vary between different versions of Debian/Ubuntu or might represent the runtime library rather than the development package.
# It's recommended to check for the exact package names if you encounter any issues during installation.

# echo "Installation of required packages is complete."
# RUN cd ${STAGE_DIR} && \
#         wget -q -O - http://www.mellanox.com/downloads/ofed/MLNX_OFED-${MLNX_OFED_VERSION}/MLNX_OFED_LINUX-${MLNX_OFED_VERSION}-ubuntu20.04-x86_64.tgz | tar xzf - && \
#         cd MLNX_OFED_LINUX-${MLNX_OFED_VERSION}-ubuntu20.04-x86_64 && \
#         ./mlnxofedinstall --user-space-only --without-fw-update --all -q && \
#         cd ${STAGE_DIR} && \
#         rm -rf ${STAGE_DIR}/MLNX_OFED_LINUX-${MLNX_OFED_VERSION}-ubuntu20.04-x86_64*

# ##############################################################################
# # nv_peer_mem
# ##############################################################################
# ENV NV_PEER_MEM_VERSION=1.2
# ENV NV_PEER_MEM_TAG=${NV_PEER_MEM_VERSION}-0
# RUN mkdir -p ${STAGE_DIR} && \
#         git clone https://github.com/Mellanox/nv_peer_memory.git --branch ${NV_PEER_MEM_TAG} ${STAGE_DIR}/nv_peer_memory && \
#         cd ${STAGE_DIR}/nv_peer_memory && \
#         ./build_module.sh && \
#         cd ${STAGE_DIR} && \
#         tar xzf ${STAGE_DIR}/nvidia-peer-memory_${NV_PEER_MEM_VERSION}.orig.tar.gz && \
#         cd ${STAGE_DIR}/nvidia-peer-memory-${NV_PEER_MEM_VERSION} && \
#         apt-get update && \
#         apt-get install -y dkms && \
#         dpkg-buildpackage -us -uc && \
#         dpkg -i ${STAGE_DIR}/nvidia-peer-memory_${NV_PEER_MEM_TAG}_all.deb


# RUN pip install --no-cache-dir transformers==4.30.0 \
#     && pip install --no-cache-dir deepspeed==0.13.0 \
#     && python -c "import deepspeed; print(deepspeed.__version__)" \
#     && python -c "import transformers; print(transformers.__version__)"