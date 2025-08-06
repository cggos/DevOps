# Docker

* [Docker](https://docker.com/): Securely build, share and run any application, anywhere
* [Docker Hub](https://hub.docker.com/): the world's easiest way to create, manage, and deliver your teams' container applications
* [docker中文社区](https://docker.org.cn/)

---

## Overview

* the images and containers are stored by Docker in `/var/lib/docker` by default

### Image vs Container

* 镜像 (Images): 可以认为是超级轻量级的虚拟机的快照。镜像会有自己的唯一ID，名字和标签，比如ubuntu, 比如ubuntu:18.04等。通常都是在已有的镜像（多数是Linux操作系统的镜像）的基础上构建自己的具有新功能的镜像。

* 容器 (Containers): 可以认为是超级轻量级的虚拟机，是镜像运行起来所处的可读写的状态。容器里面可以安装、运行程序，还可以把安装好的程序存储起来获得新的镜像。与虚拟机很大的不同在于，一个容器通常只运行一个程序。在Docker中，应用程序和数据文件是分开的，因此可以在不影响数据的情况下快速升级代码或系统。

### Tutorial

* [Docker 菜鸟教程](https://www.runoob.com/docker/docker-tutorial.html)

* [Docker的基本使用-Ubuntu18.04](https://blog.csdn.net/woodcorpse/article/details/80601899)

* [How To Install and Use Docker on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)

* [Real-time and video processing object detection using Tensorflow, OpenCV and Docker](https://towardsdatascience.com/real-time-and-video-processing-object-detection-using-tensorflow-opencv-and-docker-2be1694726e5)
* [基于 TensorFlow 、OpenCV 和 Docker 的实时视频目标检测](https://www.leiphone.com/news/201807/V0dTefBD2QgNPwLj.html)

* [Running GUI apps with Docker](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)

* [Running a graphical app in a Docker container, on a remote server](https://blog.yadutaf.fr/2017/09/10/running-a-graphical-app-in-a-docker-container-on-a-remote-server/)

* [Docker for Computer Vision Researchers](https://kusemanohar.info/2018/10/03/docker-for-computer-vision-researchers/) !!!


## Install

* [Get Docker Engine - Community for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)



## Config & Check

```json
// vim /etc/docker/daemon.json
{
    "registry-mirrors":["https://docker.mirrors.ustc.edu.cn"]
}
```

restart

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

check

```sh
sudo docker info
```

###  VS Code

Error: permission denied while trying to connect to the Docker daemon socket at unix

```bash
sudo chmod 666 /var/run/docker.sock
```


## Image

* view
  ```sh
  sudo docker images
  ```

* get
  ```sh
  sudo docker pull ros

  sudo docker pull ros:kinetic-robot
  ```

* create
  ```sh
  sudo docker build -t <REPO-NAME:TAG>

  sudo docker build -t <REPO-NAME:TAG> -f <path-to-Dockerfile> .
  ```

* modify
  ```sh
  sudo docker tag <IMAGE-ID> <REPO-NAME>:<TAG>
  ```

* delete
  ```sh
  sudo docker rmi <REPO-NAME>/<IMAGE-ID>
  ```

* get
  ```sh
  sudo docker search ubuntu

  sudo docker pull ubuntu
  ```

* run
  ```sh
  sudo docker run --help

  # e.g.
  sudo docker run hello-world
  
  sudo docker run -it <REPO-NAME:TAG> /bin/bash
  # default TAG: latest
  sudo docker run -it <REPO-NAME> /bin/bash
  # e.g.
  sudo docker run -it ubuntu:15.10 /bin/bash
  ```
      * -i: 交互式操作
      * -t: 终端
      * ubuntu:15.10: 这是指用 ubuntu 15.10 版本镜像为基础来启动容器
      * /bin/bash：放在镜像名后的是命令，这里我们希望有个交互式 Shell，因此用的是 /bin/bash

### Run Examples

```bash
sudo docker run -it --rm --privileged \
	-v /dev/bus/usb:/dev/bus/usb \
	-v /home/gavin/projects/ml/rk/:/rknn_tk \
	rknn-toolkit2:1.6.0-cp38 /bin/bash
```

#### with ROS

* ros-kalibr
  ```bash
  sudo docker run --name=ros-kalibr -it --rm -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    davvdg/ros-kalibr \
    /bin/bash
  ```

* [HKUST-Aerial-Robotics/VINS-kidnap](https://github.com/HKUST-Aerial-Robotics/VINS-kidnap)
  ```bash
  docker run --runtime=nvidia -it \
          --add-host `hostname`:172.17.0.1 \
          --env ROS_MASTER_URI=http://`hostname`:11311/ \
          --env ROS_IP=172.17.0.2 \
          --env CUDA_VISIBLE_DEVICES=0 \
          --hostname happy_go \
          --name happy_go  \
          mpkuse/kusevisionkit:vins-kidnap bash
  ```

#### Params

```sh
--net=host

# or
--add-host `hostname`:172.17.0.1 \
--env ROS_MASTER_URI=http://`hostname`:11311/ \
--env ROS_IP=172.17.0.2 \
--hostname happy_go \
--name happy_go  \
```

## Container

* view
  ```sh
   sudo docker ps -a
  ```

* start & stop container
  ```sh
  # start container and enter
  docker start -i <Container-ID>

  # restart
  docker restart <Container-ID>
  
  # stop
  docker stop <Container-ID>
  ```

* we can also open another terminal for a running container with the following command
  ```sh
  docker exec -it <Container-Name/ID> bash
  ```
  or
  ```sh
  docker attach <Container-Name/ID>
  ```

* commit to update IMAGE
  ```sh
  sudo docker commit [-m="update dataset" -a="cggos"] <Container-ID> <REPO-NAME:TAG>
  ```

* history
  ```sh
  sudo docker history <IMAGE-ID>
  ```

* delete
  ```sh
  sudo docker rm <container-name/ID>

  # stop all containers
  sudo docker container stop $(docker container ls -aq)
  # remove all stopped containers
  sudo docker container prune
  ```

* copy file
  ```sh
  # host to container
  docker cp foo.txt <Container-ID>:/foo.txt

  # container to host
  docker cp <Container-ID>:/foo.txt foo.txt
  ```


## Docker Hub

```sh
sudo docker login

sudo docker inspect <USER/REPO-NAME:TAG>

sudo docker push <USER/REPO-NAME:TAG>
```
