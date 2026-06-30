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
# │   │   ├── 3rdparty_src
# │   │   ├── app_release
# │   └── ccv
# ├── dms
# │   ├── design
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
export CG_APP_RELEASE="${CG_APP_ROOT}/DevOps/app_release"
export CG_THIRDPARTY=${CG_APP_RELEASE}

export CG_OUTPUT_ROOT="${HOME}/.cache/cgabc"

if [ ! -d "$CG_OUTPUT_ROOT" ]; then
    mkdir -p "$CG_OUTPUT_ROOT"
fi


export PATH=$HOME/.local/bin/:$PATH

os_label="Unknown"
os_name=$(uname)
if [[ "$os_name" == "Darwin" ]]; then
    os_label="macOS System"
elif [[ "$os_name" == "Linux" ]]; then
    os_id=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
    os_codename=$(grep '^VERSION_CODENAME' /etc/os-release | cut -d '=' -f2)
    
    if [[ "$os_codename" == "focal" ]]; then
        os_label="Ubuntu 20.04 (Focal Fossa)"
    elif [[ "$os_codename" == "jammy" ]]; then
        os_label="Ubuntu 22.04 (Jammy Jellyfish)"
    else
        os_label="Linux System, ID: $os_id ,code name: $os_codename"
    fi
else
    echo "Unknown OS: $os_name"
fi

platform_arch=$(uname -m)

cg_trim() {
  sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

cg_simplify_hw_name() {
  sed \
    -e 's/(R)//g' \
    -e 's/(TM)//g' \
    -e 's/CPU//g' \
    -e 's/Processor//g' \
    -e 's/[[:space:]]\+/ /g' \
    -e 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

cg_cpu_info() {
  local cpu_model cpu_threads cpu_cores cpu_sockets cpu_physical cpu_lscpu

  if [[ "$os_name" == "Linux" ]] && command -v lscpu >/dev/null 2>&1; then
    cpu_lscpu=$(lscpu)
    cpu_model=$(printf '%s\n' "$cpu_lscpu" | awk -F: '/Model name:/ {print $2; exit}' | cg_simplify_hw_name)
    cpu_threads=$(printf '%s\n' "$cpu_lscpu" | awk -F: '/^CPU\(s\):/ {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2; exit}')
    cpu_cores=$(printf '%s\n' "$cpu_lscpu" | awk -F: '/Core\(s\) per socket:/ {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2; exit}')
    cpu_sockets=$(printf '%s\n' "$cpu_lscpu" | awk -F: '/Socket\(s\):/ {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2; exit}')
    if [[ -n "$cpu_cores" && -n "$cpu_sockets" ]]; then
      cpu_physical=$((cpu_cores * cpu_sockets))
    fi
  elif [[ "$os_name" == "Darwin" ]] && command -v sysctl >/dev/null 2>&1; then
    cpu_model=$(sysctl -n machdep.cpu.brand_string 2>/dev/null | cg_simplify_hw_name)
    cpu_threads=$(sysctl -n hw.ncpu 2>/dev/null)
    cpu_physical=$(sysctl -n hw.physicalcpu 2>/dev/null)
  fi

  cpu_model=${cpu_model:-Unknown}
  if [[ -n "$cpu_physical" && -n "$cpu_threads" ]]; then
    printf '%s %sC/%sT' "$cpu_model" "$cpu_physical" "$cpu_threads"
  elif [[ -n "$cpu_threads" ]]; then
    printf '%s %sT' "$cpu_model" "$cpu_threads"
  else
    printf '%s' "$cpu_model"
  fi
}

cg_gpu_info() {
  local gpu_lines gpu_count gpu_name gpu_mem gpu_vendors

  if command -v nvidia-smi >/dev/null 2>&1; then
    if command -v timeout >/dev/null 2>&1; then
      gpu_lines=$(timeout 0.3 nvidia-smi --query-gpu=name,memory.total --format=csv,noheader,nounits 2>/dev/null)
    else
      gpu_lines=$(nvidia-smi --query-gpu=name,memory.total --format=csv,noheader,nounits 2>/dev/null)
    fi
    gpu_lines=$(printf '%s\n' "$gpu_lines" | grep -E ',[[:space:]]*[0-9]+$')
    if [[ -n "$gpu_lines" ]]; then
      gpu_count=$(printf '%s\n' "$gpu_lines" | sed '/^[[:space:]]*$/d' | wc -l | tr -d ' ')
      gpu_name=$(printf '%s\n' "$gpu_lines" | awk -F, 'NR == 1 {print $1}' | cg_simplify_hw_name)
      gpu_mem=$(printf '%s\n' "$gpu_lines" | awk -F, 'NR == 1 {gsub(/^[ \t]+|[ \t]+$/, "", $2); print int(($2 + 512) / 1024) "G"}')
      if [[ "$gpu_count" -gt 1 ]]; then
        printf '%sx %s %s' "$gpu_count" "$gpu_name" "$gpu_mem"
      else
        printf '%s %s' "$gpu_name" "$gpu_mem"
      fi
      return
    fi
  fi

  if [[ "$os_name" == "Linux" ]] && command -v lspci >/dev/null 2>&1; then
    gpu_vendors=$(lspci | grep -Ei 'vga|3d|display' | awk '
      /NVIDIA/ && !seen["NVIDIA"]++ {items[++n]="NVIDIA"}
      /AMD|ATI/ && !seen["AMD"]++ {items[++n]="AMD"}
      /Intel/ && !seen["Intel"]++ {items[++n]="Intel"}
      END {
        for (i = 1; i <= n; i++) {
          printf "%s%s", (i > 1 ? "+" : ""), items[i]
        }
      }')
    if [[ -n "$gpu_vendors" ]]; then
      printf '%s' "$gpu_vendors"
      return
    fi
  fi

  printf '-'
}

cg_npu_info() {
  local npu_name

  if [[ "$os_name" == "Linux" ]]; then
    if ls /dev 2>/dev/null | grep -Eiq 'npu|vpu|hailo|davinci|tpu|accel|rknn'; then
      npu_name=$(ls /dev 2>/dev/null | grep -Ei 'npu|vpu|hailo|davinci|tpu|accel|rknn' | head -n 1 | cg_trim)
      printf '%s' "$npu_name"
      return
    fi

    if command -v lspci >/dev/null 2>&1; then
      npu_name=$(lspci | grep -Ei 'npu|neural|vpu|tpu|hailo|ascend|davinchi|gaudi|myriad|rockchip' | head -n 1 | sed 's/^[^:]*: //' | cg_trim)
      if [[ -n "$npu_name" ]]; then
        printf '%s' "$npu_name"
        return
      fi
    fi
  fi

  printf '-'
}

output_content="[CG] ${platform_arch} | ${os_label} | CPU:$(cg_cpu_info) | GPU:$(cg_gpu_info) | NPU:$(cg_npu_info)"

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
    export ROS2_PYTHON_SITE_PACKAGES="/opt/ros/humble/lib/python3.10/site-packages"
  fi
fi

# NVIDIA
if command -v nvidia-smi &>/dev/null && nvidia-smi &>/dev/null; then
  # NV CUDA
  export CUDA_HOME=/usr/local/cuda
  export PATH=$PATH:$CUDA_HOME/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64

  # NV cuDNN (cudnn-linux-x86_64-8.8.1.3_cuda11-archive, cudnn-linux-x86_64-9.2.0.82_cuda12-archive)
  export CUDNN_ROOT=${CG_APP_ROOT}/DevOps/nvidia/cuDNN
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDNN_ROOT/lib
  export CPATH=$CUDNN_ROOT/include:$CPATH

  # NV TRT (TensorRT-8.5.3.1, TensorRT-10.12.0.36)
  export TRT_ROOT=${CG_APP_ROOT}/DevOps/nvidia/TensorRT
  export PATH=$PATH:$TRT_ROOT/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TRT_ROOT/lib
  export CPATH=$TRT_ROOT/targets/x86_64-linux/include:$CPATH
fi

# JDK
export JAVA_HOME=${CG_APP_ROOT}/DevOps/jdk/jdk-21.0.2
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib
export PATH=$JAVA_HOME/bin:$PATH

# npm
export N_PREFIX=$HOME/.local
export PATH=$HOME/.npm-global/bin:$PATH

# fnm
FNM_PATH="${HOME}/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="${HOME}/.local/share/fnm:$PATH"
  __fnm_env="$(fnm env 2>/dev/null)"
  if [ -n "$__fnm_env" ]; then
    eval "$__fnm_env"
  fi
  unset __fnm_env
fi

# rvm
export PATH="$PATH:$HOME/.rvm/bin"

# bun completions
if [ -d "${HOME}/.bun" ]; then
  [ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Gem
export GEM_HOME="$CG_APP_ROOT/DevOps/gems"
export PATH="$PATH:$GEM_HOME/bin"

# brew
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
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

# Python
alias ex_pypath="export PYTHONPATH=$PYTHONPATH:`pwd`"
alias ruff-fix="ruff check --fix . && ruff format ."

# ARM
export ARM_ROOT="${CG_APP_ROOT}/DevOps/arm"
export ARM_NONE_EABI_TOOLCHAIN="${ARM_ROOT}/arm-none-eabi-toolchain"
export PATH=$PATH:${ARM_NONE_EABI_TOOLCHAIN}/bin

# Rockchip
export RK_ROOT="${CG_APP_ROOT}/DevOps/rockchip"
export RK_TOOLCHAIN="${RK_ROOT}/rk_toolchain"
export PATH=$PATH:${RK_TOOLCHAIN}/bin

# Espressif
export ESP_ROOT="${CG_APP_ROOT}/DevOps/espressif"
# export ESP_TOOLCHAIN="${ESP_ROOT}/xtensa-esp32-elf"
export ESP_TOOLCHAIN="${HOME}/.espressif/tools/xtensa-esp32s3-elf"
export PATH="$PATH:${ESP_TOOLCHAIN}/bin"
alias sc_esp_idf=". ${ESP_ROOT}/esp-idf/export.sh"

# FlameGraph
export PATH="${CG_APP_ROOT}/DevOps/FlameGraph":$PATH

# mcap
export PATH="${CG_APP_ROOT}/DevOps/mcap":$PATH

# LM Studio
if [[ "$(uname -s)" == "Linux" ]]; then
  export PATH="$PATH:${HOME}/.lmstudio/bin"
elif [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="$PATH:${HOME}/.cache/lm-studio/bin"
fi

# Ollama (config in ollama.service)
# export OLLAMA_MODELS="${CG_DM_ROOT}/models_ml/ollama/models"

# llama.cpp
export LLAMA_CPP_LIB_PATH="${CG_APP_ROOT}/AI/llama.cpp/build/bin"
export PATH="${LLAMA_CPP_LIB_PATH}:$PATH"
export LD_LIBRARY_PATH="${LLAMA_CPP_LIB_PATH}:$LD_LIBRARY_PATH"

# HF
export HF_HUB_ENABLE_HF_TRANSFER=1
export HF_ENDPOINT=https://hf-mirror.com

# Core dumps
CORE_DUMP_DIR="${CG_OUTPUT_ROOT}/cores"
if [ ! -d "$CORE_DUMP_DIR" ]; then
    mkdir -p "$CORE_DUMP_DIR"
fi
# sudo sysctl -w kernel.core_uses_pid=1
# sudo sysctl -w kernel.core_pattern="${CORE_DUMP_DIR}/core-%h-%t-%e-%p.dump"

# Dataset
export CITYSCAPES_DATASET=$CG_DM_ROOT/dataset_ml/cityscapes


########################## Custom Envs Begin ##########################

# SSH Servers
alias ssh_jet="ssh jetson@192.168.55.1"
alias ssh_rpi="ssh pi@raspberrypi.local"

# ROS1
# export ROS_MASTER_URI=http://jet02.local:11311
# export ROS_IP=$(hostname).local

# ROS2
# export ROS_DOMAIN_ID=55
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

export TURTLEBOT3_MODEL=burger

########################## Custom Envs End ##########################

echo "$output_content"
