# Docker

* [Docker](https://www.docker.com/): Securely build, share and run any application, anywhere
* [Docker Hub](https://hub.docker.com/): the world's easiest way to create, manage, and deliver your teams' container applications
* [Docker 菜鸟教程](https://www.runoob.com/docker/docker-tutorial.html)
* [docker中文社区](http://www.docker.org.cn/)

-----

* [Docker的基本使用-Ubuntu18.04](https://blog.csdn.net/woodcorpse/article/details/80601899)

* [How To Install and Use Docker on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)

* [Real-time and video processing object detection using Tensorflow, OpenCV and Docker](https://towardsdatascience.com/real-time-and-video-processing-object-detection-using-tensorflow-opencv-and-docker-2be1694726e5)
* [基于 TensorFlow 、OpenCV 和 Docker 的实时视频目标检测](https://www.leiphone.com/news/201807/V0dTefBD2QgNPwLj.html)

* [Running GUI apps with Docker](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)

* [Running a graphical app in a Docker container, on a remote server](https://blog.yadutaf.fr/2017/09/10/running-a-graphical-app-in-a-docker-container-on-a-remote-server/)

* [Docker for Computer Vision Researchers](https://kusemanohar.info/2018/10/03/docker-for-computer-vision-researchers/) !!!

```
sudo docker run \
  --name=ros-kalibr \
  -it --rm -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix davvdg/ros-kalibr \
  /bin/bash
```

-----

## Basic

* hello-world
  ```sh
  sudo docker run hello-world
  ```

* the images and containers are stored by Docker in `/var/lib/docker` by default

* view containers
  ```sh
  docker ps -a
  ```

* run
  ```sh
  docker run -it <image-name>
  ```

* we can also open another terminal for a running container with the following command
  ```sh
  docker exec -it <container-name/ID> bash
  ```
  or
  ```sh
  docker attach <container-name/ID>
  ```

* restart container
  ```sh
  docker restart <container-ID>
  ```
  restart container and enter
  ```sh
  docker start -i <container-ID>
  ```

* docker cp
  ```sh
  # copy a file from host to container
  docker cp foo.txt 72ca2488b353:/foo.txt

  # copy a file from Docker container to host
  docker cp 72ca2488b353:/foo.txt foo.txt
  ```

## Install

* [Get Docker Engine - Community for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)


## Docker with ROS

* ros
  ```sh
  docker pull ros
  # or
  docker pull ros:kinetic-robot
  ```
  run ros
  ```sh
  docker run -it ros
  ```

* [HKUST-Aerial-Robotics/VINS-kidnap](https://github.com/HKUST-Aerial-Robotics/VINS-kidnap)
  ```sh
  docker run --runtime=nvidia -it \
          --add-host `hostname`:172.17.0.1 \
          --env ROS_MASTER_URI=http://`hostname`:11311/ \
          --env ROS_IP=172.17.0.2 \
          --env CUDA_VISIBLE_DEVICES=0 \
          --hostname happy_go \
          --name happy_go  \
          mpkuse/kusevisionkit:vins-kidnap bash
  ```
