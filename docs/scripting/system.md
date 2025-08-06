# System & Hardware

---

## Overview

* [systemd 与 sysVinit 彩版对照表](https://linux.cn/article-3794-1.html)

* [30 Linux System Monitoring Tools Every SysAdmin Should Know](https://www.cyberciti.biz/tips/top-linux-monitoring-tools.html)

```bash
w                             # 查看活动用户
id <用户名>                    # 查看指定用户信息
last                          # 查看用户登录日志
cut -d: -f1 /etc/passwd       # 查看系统所有用户
cut -d: -f1 /etc/group        # 查看系统所有组
crontab -l                    # 查看当前用户的计划任务

uptime                 # 查看系统运行时间、用户数、负载
who –rH                # 显示当前的运行级别
uname -a               # 查看内核/操作系统/CPU信息
env                    # 查看环境变量
hostname               # 查看计算机名

cat /etc/issue         # 查看操作系统版本
cat /proc/bus/input/devices
cat /proc/interrupts   # 查看各设备的中断请求(IRQ)
cat /proc/meminfo      # 查看内存信息
cat /proc/cpuinfo      # 查看CPU信息
cat /proc/loadavg      # 查看系统负载

lspci |grep -i 'VGA'   # 查看显卡信息
lspci -tv              # 列出所有PCI设备
lsusb -tv              # 列出所有USB设备
lshw 		       # list hardware
lsmod                  # 列出加载的内核模块

dmesg | grep -i 'VGA'
dmesg | grep -i 'cpu'
dmesg | grep IDE       # 查看启动时IDE设备检测状况

dmidecode              # 查看硬件信息，包括bios、cpu、内存等信息
dmidecode -t processor
dmidecode | grep -i 'serial number' #查看主板序列号
```

## Services

```bash
chkconfig --list              # 列出所有系统服务
chkconfig --list | grep on    # 列出所有启动的系统服务
```

## Process

* `ps aux`: show processes for all users, display the process's user/owner and show processes not attached to a terminal

* `pstree`

## Driver

```bash
ubuntu-drivers devices        # 驱动
```

## Display

```sh
#查看显示器标识符：我的是DVI-I-0，在'connected'之前。
xrandr
#查看分辨率的属性：我要看1920x1080的分辨率，在'Modeline'之后。
cvt 1920 1080
#创建新分辨率模式：拷贝'Modeline'之后的信息即可。
sudo xrandr --newmode "1920x1080" \
  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
#为显示器添加分辨率模式：
sudo xrandr --addmode DVI-I-0 "1920x1080"
#将分辨率模式应用到显示器：
sudo xrandr --output DVI-I-0 --mode "1920x1080"
```

## Lid

* Ubuntu 16.04 Ignore Lid
    - /etc/UPower/UPower.conf: `IgnoreLid=true`
    - `sudo service upower restart`

### Keyboard Led

Turn Keyboard Led On/Off  
```bash
#!/bin/bash -
#===============================================================================
#
#          FILE: ledctrl
#
#         USAGE: ./ledctrl
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: linkscue (scue), linkscue@gmail.com
#  ORGANIZATION:
#       CREATED: 2014年02月13日 13时16分55秒 CST
#      REVISION:  ---
#===============================================================================

status=/tmp/keyboard_led_status
if [[ ${1} == "on" ]] || [[ ! -e ${status} ]]; then
    xset led named 'Scroll Lock' && echo "on" > ${status}
else
    xset -led named 'Scroll Lock' && rm -f ${status}
fi
```

## Themes

1) 下载Unity主题，将其解压到`~/.themes`目录下  
2) 执行`unity-tweak-tool`命令打开管理器，选择相应的主题

* [Dracula colorscheme for Gnome Terminal](https://github.com/dracula/gnome-terminal)

## Fonts

* [powerline/fonts](https://github.com/powerline/fonts)

* 查看系统中文字体
  ```sh
  fc-list :lang=zh
  ```

* ubuntu安装文泉驿字体
  ```sh
  sudo apt-get install ttf-wqy-microhei  # 文泉驿-微米黑
  sudo apt-get install ttf-wqy-zenhei    # 文泉驿-正黑
  sudo apt-get install xfonts-wqy        # 文泉驿-点阵宋体
  ```

* WPS for Linux（ubuntu）字体配置(字体缺失解决办法)
    1. Dowload **wps_symbol_fonts.zip**(国内下载地址：https://pan.baidu.com/s/1eS6xIzo)
    2. `sudo cp * /usr/share/fonts`
    3. 生成字体的索引信息: `sudo mkfontscale & sudo mkfontdir`
    4. 更新字体缓存: `sudo fc-cache`
    5. 重启wps
