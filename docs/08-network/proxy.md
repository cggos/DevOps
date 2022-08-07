# Proxy

* [Proxy settings (archlinux)](https://wiki.archlinux.org/index.php/proxy_settings)
  ```sh
  export http_proxy=socks5://127.0.0.1:1080
  export https_proxy=$http_proxy
  ```

---

## IPv6

* [IPv6 Tunnel Broker](https://www.tunnelbroker.net/)
* [六维空间](http://bt.neu6.edu.cn/)

## VPS

* [老左常用国内/国外VPS推荐](http://www.laozuo.org/myvps)

* 搬瓦工
    * [BandwangonHOST](https://bwh88.net/)
    * [http://banwagong.cn/]()
    * [https://www.banwago.com/]()
    * [KiwiVM Main Panel](https://kiwivm.64clouds.com/main.php)

* [shadowsocks](https://order.shadowsocks.ch)

## Trojan

* [trojan-gfw/trojan](https://github.com/trojan-gfw/trojan): An unidentifiable mechanism that helps you bypass GFW
* [Trojan-Qt5/Trojan-Qt5](https://github.com/Trojan-Qt5/Trojan-Qt5): A cross-platform trojan GUI client based on Shadowsocks-qt

## Shadowsocks

* [Shadowsocks](https://shadowsocks.org): A secure socks5 proxy, designed to protect your Internet traffic. ([github](https://github.com/shadowsocks))
    - GUI: **shadowsocks-qt5**
    - CLI: `sudo pip install shadowsocks`

* [自己动手搭建翻墙SS服务器](https://www.yigeni.com/build-a-wall-ss-server/)

### Ubuntu 16.04 配置 shadowsocks

* 编写shadowsocks.json文件，将其放在/opt目录下，文件格式如下
  ```json title="shadowsocks.json"
  {  
      "server":"xxx.xxx.xxx.xxx",  
      "server_port":xxx,  
      "local_address": "127.0.0.1",  
      "local_port":1080,  
      "password":"xxx",  
      "timeout":300,  
      "method":"aes-256-cfb",  
      "fast_open": true,  
      "workers": 1  
  }
  ```

* 新建（若不存在）/etc/rc.local 文件，内容如下，通过`sudo chmod +x /etc/rc.local`命令，赋予其可执行权限
  ```sh title="/etc/rc.local"
  #!/bin/bash
  /usr/local/bin/sslocal -c /opt/shadowsocks.json -d start
  exit 0
  ```

* 新建/lib/systemd/system/rc-local.service文件（若不存在），我的系统中已存在，内容如下
  ```ini title="/lib/systemd/system/rc-local.service"
  # This unit gets pulled automatically into multi-user.target by
  # systemd-rc-local-generator if /etc/rc.local is executable.
  [Unit]
  Description=/etc/rc.local Compatibility
  ConditionFileIsExecutable=/etc/rc.local
  After=network.target
  [Service]
  Type=forking
  ExecStart=/etc/rc.local start
  TimeoutSec=0
  RemainAfterExit=yes
  GuessMainPID=no
  ```

* 重启系统，执行命令 `systemctl status rc-local.service` 查看rc-local.service状态

### tsocks

* [tsocks](http://tsocks.sourceforge.net/)

* 配置文件 **/etc/tsocks.conf**
  ```sh title="/etc/tsocks.conf"
  local = 192.168.1.0/255.255.255.0
  server = 127.0.0.1
  server_type = 5
  server_port = 1080
  ```

* examples
  ```sh
  tsocks firefox
  tsocks git clone xxx
  tsocks wget xxx
  ```

### proxychains

* `sudo apt-get install proxychains`
* Edit **/etc/proxychains.conf**: `socks5 127.0.0.1 1080`

## Browser Proxy

* [SwitchyOmega](https://proxy-switchyomega.com/): Chrome 和 Firefox 浏览器上的代理扩展程序，可以轻松快捷的管理和切换多个代理设置

### Chrome

* CLI: `google-chrome-stable --proxy-server="socks5://127.0.0.1:1080"`
* Extentions: SwitchyOmega

## Git Proxy

```sh
git config --global http.proxy 'socks5://127.0.0.1:1080'

git config --global http.proxy 'http://127.0.0.1:58591'

git config --global --unset http.proxy
```
