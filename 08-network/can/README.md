# CAN

* [CAN Bus (elinux)](https://elinux.org/CAN_Bus)
* [SocketCAN (wikipedia)](https://en.wikipedia.org/wiki/SocketCAN) is a set of open source CAN drivers and a networking stack contributed by Volkswagen Research to the Linux kernel.
* [SocketCAN (linklayer)](https://wiki.linklayer.com/index.php/SocketCAN)
* [linux-can/can-utils](https://github.com/linux-can/can-utils): Linux-CAN / SocketCAN user space applications
* [ros_canopen](http://wiki.ros.org/ros_canopen) provides support for CANopen devices within ROS
* [CANable](https://canable.io/): An Open-Source USB to CAN Adapter


-----

# CAN Usage

* [CAN communication tutorial, using simulated CAN bus](https://sgframework.readthedocs.io/en/latest/cantutorial.html)

## can-utils

```sh
# write
cansend vcan0 123#123456

# read
candump vcan0
```

# CAN Protocol

* [SAE J1939](https://www.csselectronics.com/screen/page/simple-intro-j1939-explained/language/en) is a key protocol in CAN bus data logging, yet it's difficult to find a really simple intro to J1939.

# others

```sh
xxd
hexdump
```

To use CanUSB with SocketCAN, you have to establish a “link” between the drivers and the hardware
```sh
sudo slcand -o -c -s8 /dev/ttyACM0 can0
```
