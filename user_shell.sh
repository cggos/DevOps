# export USER_DATA_HOME="/opt/user_data"
export USER_DATA_HOME="${HOME}/UserData"
export USER_APP_ROOT="${USER_DATA_HOME}/apps"
export USER_DM_ROOT="${USER_DATA_HOME}/dms"

export PATH=$HOME/.local/bin/:$PATH

# echo "${USER_DATA_HOME}/user_shell.sh loaded"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${USER_APP_ROOT}/DevOps/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "${USER_APP_ROOT}/DevOps/anaconda3/etc/profile.d/conda.sh" ]; then
    . "${USER_APP_ROOT}/DevOps/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="${USER_APP_ROOT}/DevOps/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

# conda config --set auto_activate_base false

# ROS
if [ -n "$BASH_VERSION" ]; then
  alias ss_ros1="source /opt/ros/noetic/setup.bash"
  alias ss_ros2="source /opt/ros/foxy/setup.bash"
elif [ -n "$ZSH_VERSION" ]; then
  alias ss_ros1="source /opt/ros/noetic/setup.zsh"
  alias ss_ros2="source /opt/ros/foxy/setup.zsh"
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
  export CUDNN_ROOT=${USER_APP_ROOT}/DevOps/nv/cudnn-linux-x86_64-8.8.1.3_cuda11-archive
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDNN_ROOT/lib
  export CPATH=$CUDNN_ROOT/include:$CPATH

  # NV TRT
  export TRT_ROOT=${USER_APP_ROOT}/DevOps/nv/TensorRT-8.5.3.1
  export PATH=$PATH:$TRT_ROOT/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TRT_ROOT/lib
  export CPATH=$TRT_ROOT/targets/x86_64-linux/include:$CPATH
fi

# JDK
export JAVA_HOME=${USER_APP_ROOT}/DevOps/jdk/jdk-21.0.2
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
export PATH="$USER_APP_ROOT/OA/op/:$PATH"
if [ -f "$USER_APP_ROOT/OA/op/op.sh" ]; then
  source "$USER_APP_ROOT/OA/op/op.sh"
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

# ARM
export TOOL_CHAIN_RK=${USER_APP_ROOT}/DevOps/toolchain/rk_toolchain
export TOOL_CHAIN_ESP=${USER_APP_ROOT}/DevOps/toolchain/xtensa-esp32-elf
export PATH=$PATH:${TOOL_CHAIN_RK}/bin
export PATH=$PATH:${TOOL_CHAIN_ESP}/bin
alias ss_esp_idf=". ${USER_APP_ROOT}/DevOps/esp/esp-idf/export.sh"

# AI Apps
if [[ "$(uname -s)" == "Linux" ]]; then
  export PATH="$PATH:${HOME}/.lmstudio/bin"
elif [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="$PATH:${HOME}/.cache/lm-studio/bin"
fi
# export OLLAMA_MODELS="${USER_DM_ROOT}/models_ml/ollama/models"
export LLAMA_CPP_LIB_PATH="${USER_APP_ROOT}/AI/llama.cpp/build/bin"
export PATH="${LLAMA_CPP_LIB_PATH}:$PATH"
export LD_LIBRARY_PATH="${LLAMA_CPP_LIB_PATH}:$LD_LIBRARY_PATH"

# HF
export HF_HUB_ENABLE_HF_TRANSFER=1
export HF_ENDPOINT=https://hf-mirror.com

# Dataset
export CITYSCAPES_DATASET=$USER_DATASET_ROOT/data_ml/cityscapes
