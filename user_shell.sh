#!/usr/bin/env bash

#
# ~/UserData/
# .
# ├── apps
# │   ├── 3DModeling
# │   ├── Academic
# │   ├── AI
# │   ├── Container
# │   ├── DevOps
# │   ├── Medical
# │   ├── OA
# │   └── OS
# ├── code
# │   ├── DevOps
# │   └── ccv
# ├── dms
# │   ├── 3d_models
# │   ├── dataset_ml
# │   ├── dataset_slam
# │   ├── hf_hub -> ~/.cache/huggingface/hub
# │   ├── models_ml
# │   ├── models_train
# │   └── torch_hub -> ~/.cache/torch/hub
# ├── docs
# │   └── TeX
# └── user_shell.sh -> code/DevOps/user_shell.sh
#


export CG_DATA_HOME="${HOME}/UserData"

export CG_APP_ROOT="${CG_DATA_HOME}/apps"
export CG_DM_ROOT="${CG_DATA_HOME}/dms"

export CG_CONDA_ENVS="${CG_APP_ROOT}/DevOps/anaconda3/envs"
export CG_THIRDPARTY="${CG_APP_ROOT}/DevOps/3rdparty/release"


export PATH=$HOME/.local/bin/:$PATH

os_name=$(uname)
if [[ "$os_name" == "Darwin" ]]; then
    echo "macOS System"
elif [[ "$os_name" == "Linux" ]]; then
    os_id=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
    os_codename=$(grep '^VERSION_CODENAME' /etc/os-release | cut -d '=' -f2)
    
    if [[ "$os_codename" == "focal" ]]; then
        echo "Ubuntu 20.04 (Focal Fossa)"
    elif [[ "$os_codename" == "jammy" ]]; then
        echo "Ubuntu 22.04 (Jammy Jellyfish)"
    else
        echo "Linux System, ID: $os_id ,code name: $os_codename"
    fi
else
    echo "Unknown OS: $os_name"
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${CG_APP_ROOT}/DevOps/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "${CG_APP_ROOT}/DevOps/anaconda3/etc/profile.d/conda.sh" ]; then
    . "${CG_APP_ROOT}/DevOps/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="${CG_APP_ROOT}/DevOps/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

# conda config --set auto_activate_base false

# ROS
if [[ "$os_id" == "ubuntu" ]]; then
  if [[ "$os_codename" == "focal" ]]; then
    if [ -n "$BASH_VERSION" ]; then
      alias sc_ros1="source /opt/ros/noetic/setup.bash"
      alias sc_ros2="source /opt/ros/foxy/setup.bash"
    elif [ -n "$ZSH_VERSION" ]; then
      alias sc_ros1="source /opt/ros/noetic/setup.zsh"
      alias sc_ros2="source /opt/ros/foxy/setup.zsh"
    fi
  elif [[ "$os_codename" == "jammy" ]]; then
    if [ -n "$BASH_VERSION" ]; then
      alias sc_ros2="source /opt/ros/humble/setup.bash"
    elif [ -n "$ZSH_VERSION" ]; then
      alias sc_ros2="source /opt/ros/humble/setup.zsh"
    fi
  fi
fi
# export ROS_MASTER_URI=http://jet02.local:11311
# export ROS_IP=$(hostname).local

# NVIDIA
if command -v nvidia-smi &>/dev/null && nvidia-smi &>/dev/null; then
  # NV CUDA
  export CUDA_HOME=/usr/local/cuda
  export PATH=$PATH:$CUDA_HOME/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64

  # NV cuDNN
  export CUDNN_ROOT=${CG_APP_ROOT}/DevOps/nv/cudnn-linux-x86_64-8.8.1.3_cuda11-archive
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDNN_ROOT/lib
  export CPATH=$CUDNN_ROOT/include:$CPATH

  # NV TRT
  export TRT_ROOT=${CG_APP_ROOT}/DevOps/nv/TensorRT-8.5.3.1
  export PATH=$PATH:$TRT_ROOT/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TRT_ROOT/lib
  export CPATH=$TRT_ROOT/targets/x86_64-linux/include:$CPATH
fi

# JDK
export JAVA_HOME=${CG_APP_ROOT}/DevOps/jdk/jdk-21.0.2
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib
export PATH=$JAVA_HOME/bin:$PATH

# Node.js
export N_PREFIX=$HOME/.local
export PATH=$HOME/.npm-global/bin:$PATH

# fnm
FNM_PATH="${HOME}/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="${HOME}/.local/share/fnm:$PATH"
  eval "$(fnm env)"
fi

# rvm
export PATH="$PATH:$HOME/.rvm/bin"

# bun completions
if [ -d "${HOME}/.bun" ]; then
  [ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# op
export PATH="$CG_APP_ROOT/OA/op/:$PATH"
if [ -f "$CG_APP_ROOT/OA/op/op.sh" ]; then
  source "$CG_APP_ROOT/OA/op/op.sh"
fi

# fzf
alias ff='find * -type f | fzf > selected'

# Docker
if [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
fi

# SSL
export OPENSSL_ROOT_DIR=/usr/
export OPENSSL_CRYPTO_LIBRARY=/usr/lib/ssl/
export OPENSSL_INCLUDE_DIR=/usr/include/openssl/

# SSH
alias ssh_jet="ssh jetson@192.168.55.1"
alias ssh_rpi="ssh pi@raspberrypi.local"

# Python
alias ex_pypath="export PYTHONPATH=$PYTHONPATH:`pwd`"
alias ruff-fix="ruff check --fix . && ruff format ."

# Rockchip
export RK_ROOT="${CG_APP_ROOT}/DevOps/rockchip"
export RK_TOOL_CHAIN="${RK_ROOT}/rk_toolchain"
export PATH=$PATH:${RK_TOOL_CHAIN}/bin

# Espressif
export ESP_ROOT="${CG_APP_ROOT}/DevOps/espressif"
# export ESP_TOOL_CHAIN="${ESP_ROOT}/xtensa-esp32-elf"
export ESP_TOOL_CHAIN="${HOME}/.espressif/tools/xtensa-esp32s3-elf"
export PATH="$PATH:${ESP_TOOL_CHAIN}/bin"
alias sc_esp_idf=". ${ESP_ROOT}/esp-idf/export.sh"

# AI Apps
if [[ "$(uname -s)" == "Linux" ]]; then
  export PATH="$PATH:${HOME}/.lmstudio/bin"
elif [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="$PATH:${HOME}/.cache/lm-studio/bin"
fi
# export OLLAMA_MODELS="${CG_DM_ROOT}/models_ml/ollama/models"
export LLAMA_CPP_LIB_PATH="${CG_APP_ROOT}/AI/llama.cpp/build/bin"
export PATH="${LLAMA_CPP_LIB_PATH}:$PATH"
export LD_LIBRARY_PATH="${LLAMA_CPP_LIB_PATH}:$LD_LIBRARY_PATH"

# HF
export HF_HUB_ENABLE_HF_TRANSFER=1
export HF_ENDPOINT=https://hf-mirror.com

# Dataset
export CITYSCAPES_DATASET=$CG_DM_ROOT/dataset_ml/cityscapes
