#!/bin/bash
trap : SIGTERM SIGINT

roscore &
ROSCORE_PID=$!
sleep 1

rviz -d ./rviz/imu_vo_fusion.rviz &
RVIZ_PID=$!

sudo docker run -it --rm \
        --net=host \
        cggos/ubuntu-ros-slam:bionic-melodic \
        /bin/bash -c \
        "cd /root/ws_msf/; \
          catkin config \
            --env-cache \
            --extend /opt/ros/$ROS_DISTRO \
            --cmake-args -DCMAKE_BUILD_TYPE=Release; \
          catkin build; \
          source devel/setup.bash; \
          roslaunch imu_x_fusion imu_vo_fusion.launch est:=ekf rviz:=false bag:=true"

# # also OK!
# sudo docker run -it \
#         --add-host `hostname`:172.17.0.1 \
#         --env ROS_MASTER_URI=http://`hostname`:11311/ \
#         --env ROS_IP=172.17.0.2 \
#         --hostname happy_go \
#         --name happy_go  \
#         ubuntu-ros-slam:bionic-melodic \
#         /bin/bash -c \
#         "cd /root/ws_msf/; \
#            source devel/setup.bash; \
#            roslaunch imu_x_fusion imu_vo_fusion.launch est:=ekf rviz:=false bag:=true"

wait $ROSCORE_PID
wait $RVIZ_PID

if [[ $? -gt 128 ]]
then
    kill $ROSCORE_PID
    kill $RVIZ_PID
fi
