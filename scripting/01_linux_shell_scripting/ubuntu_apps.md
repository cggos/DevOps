# Ubuntu Apps

-----

## 软件仓库和包管理

软件仓库是一组文件，其中包含各种软件及其版本的信息，以及校验和等其他一些详细信息。每个版本的 Ubuntu 都有自己的四个官方软件仓库：

* Main - Canonical 支持的自由开源软件。
* Universe - 社区维护的自由开源软件。
* Restricted - 设备的专有驱动程序。
* Multiverse - 受版权或法律问题限制的软件。

包管理器：

* Ubuntu 软件中心
* Synaptic 包管理器：`sudo apt install synaptic`

## PPA

PPA (Personal Package Archive) 表示 个人软件包存档。

Ubuntu 提供了一个名为 Launchpad 的平台，使软件开发人员能够创建自己的软件仓库。终端用户，也就是你，可以将 PPA 仓库添加到 `sources.list` 文件中，当你更新系统时，你的系统会知道这个新软件的可用性，然后你可以使用标准的 `sudo apt install` 命令安装它。

* 添加PPA源
  ```sh
  sudo add-apt-repository ppa:user/ppa-name
  ```
  ```sh
  sudo sh -c \
  '. /etc/lsb-release && echo \
  "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ `lsb_release -cs` main" \
  > /etc/apt/sources.list.d/ros-latest.list'
  ```

* 删除PPA源
  ```sh
  cd /etc/apt/sources.list.d/
  删除源对应文件
  ```

* 使用 PPA 安装应用程序
  ```sh
  sudo add-apt-repository ppa:dr-akulavich/lighttable
  sudo apt-get update
  sudo apt-get install lighttable-installer
  ```

## APT

Advanced Packaging Tool（apt）是Linux下的一款安装包管理工具。

### apt-get

* install apps
  ```sh
  sudo apt-get install <package-name>
  ```

* uninstall apps
  ```sh
  sudo apt remove <package-name> # 卸载一个已安装的软件包（保留配置文件）
  sudo apt purge <package-name>  # 卸载一个已安装的软件包（删除配置文件）
  ```

* update apps
  ```sh
  sudo apt-get upgrade
  ```

* clean
  ```sh
  sudo apt-get clean
  sudo apt-get autoclean
  sudo apt-get autoremove
  ```

### apt-cache

### apt-key

apt-key命令用于管理Debian Linux系统中的软件包密钥。每个发布的deb包，都是通过密钥认证的，apt-key用来管理密钥。

* add a GPG key to the apt sources keyring
  ```sh
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | \
  sudo apt-key add -

  sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' \
  --recv-key F42ED6FBAB17C654
  ```


## Deb

如果使用 DEB 包安装软件，将无法保证在运行 `sudo apt update` 和 `sudo apt upgrade` 命令时，已安装的软件会被更新为较新的版本。

* install & upgrade
  ```sh
  sudo dpkg -i <package-name>
  ```

* uninstall
  ```sh
  sudo dpkg --remove <package-name>
  ```