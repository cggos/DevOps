FROM ubuntu:20.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages for ROS installation
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release

# Add ROS repository to the sources list
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# Add the ROS key
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# Update package index and install ROS Noetic
RUN apt-get update && apt-get install -y ros-noetic-desktop-full

# Set up environment
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
SHELL ["/bin/bash", "-c", "source ~/.bashrc"]

# Install additional ROS dependencies
RUN apt-get install -y \
    python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

# Initialize rosdep and update
RUN rosdep init && \
    rosdep update

# Install additional tools and libraries
RUN apt-get install -y build-essential vim git wget

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
