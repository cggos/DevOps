# Docker

-----

* [Docker的基本使用-Ubuntu18.04](https://blog.csdn.net/woodcorpse/article/details/80601899)

* [Real-time and video processing object detection using Tensorflow, OpenCV and Docker](https://towardsdatascience.com/real-time-and-video-processing-object-detection-using-tensorflow-opencv-and-docker-2be1694726e5)
* [基于 TensorFlow 、OpenCV 和 Docker 的实时视频目标检测](https://www.leiphone.com/news/201807/V0dTefBD2QgNPwLj.html)

* [Running GUI apps with Docker](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)

* [Running a graphical app in a Docker container, on a remote server](https://blog.yadutaf.fr/2017/09/10/running-a-graphical-app-in-a-docker-container-on-a-remote-server/)

```
sudo docker run \
  --name=ros-kalibr \
  -it --rm -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix davvdg/ros-kalibr \
  /bin/bash
```
