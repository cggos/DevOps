# Network Utilities

* [Alexandre Norman](http://xael.org/)
* [Python tools for penetration testers](https://github.com/dloss/python-pentest-tools)
* [IPAddress.com](https://www.ipaddress.com/): The Best IP Address, Email and Networking Tools

```sh
ifconfig               # 查看所有网络接口的属性
iptables -L            # 查看防火墙设置
route -n               # 查看路由表
netstat -lntp          # 查看所有监听端口
netstat -antp          # 查看所有已经建立的连接
netstat -s             # 查看网络统计信息
nmcli                  # NetworkManager tools
rfkill                 # tool for enabling and disabling wireless devices
arp -a

# share folder
sudo mount -t cifs //192.168.4.247/shareGHC ../../shareMount
```

---

## 云存储

* 百度网盘

* [七牛云](https://www.qiniu.com/)：图片外链

* [坚果云](https://www.jianguoyun.com)：中国版Dropbox

* [Dropbox](https://www.dropbox.com)
  ```sh
  # Ubuntu 16.04使用代理安装Dropbox
  sudo dpkg -i dropbox_2020.03.04_amd64.deb

  # 然后使用代理安装Dropbox其他服务
  sudo apt install proxychains
  sudo vi /etc/proxychains.conf   # 将最后一行修改为 socks5 127.0.0.1 1080
  sudo proxychains dropbox start -i
  ```

* [OneDrive](https://onedrive.live.com/)

* [box](https://www.box.com/)

* [MEGA](https://mega.nz/)

* [pCloud](https://www.pcloud.com/)

* [hubiC](https://hubic.com)

* 个人云存储
    - NAS云服务器


## Web Server

* IIS
* Apache
* Tomcat
* [Wampserver](http://www.wampserver.com/en/)

## Browser

* [How to Browse Internet from Linux Shell Command line](https://www.eukhost.com/kb/how-to-browse-internet-from-linux-shell-command-line/)

* [Browsing the internet from the command line](https://askubuntu.com/questions/29540/browsing-the-internet-from-the-command-line)

* [Google Search from Linux Terminal](https://superuser.com/questions/47192/google-search-from-linux-terminal)

* [Welcome to goosh.org - the unofficial google shell.](http://goosh.org/)

* [主流搜索引擎闯入Linux命令行世界](http://www.cnbeta.com/articles/tech/313929.htm)

* [Greasy Fork](https://greasyfork.org/zh-CN): 用户脚本是一段代码，它们能够优化您的网页浏览体验。安装之后，有些脚本能为网站添加新的功能，有些能使网站的界面更加易用，有些则能隐藏网站上烦人的部分内容。在 Greasy Fork 上的用户脚本都是由用户编写并向全世界发表的，您可以免费安装，轻松体验。


### Chrome & FireFox Extentions

download chrome
```sh
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```

install extentions
```sh
google-chrome --enable-easy-off-store-extension-install
```

* [Chrome插件](http://chromecj.com/), [Crx4Chrome](https://www.crx4chrome.com/), [火狐插件](http://www.firefoxplug.cn/)  

* 网络收藏夹: **EverSync** from [EverHelper](https://everhelper.me/), [Xmarks](http://www.xmarks.com/), [Raindrop](https://raindrop.io/)

* [Vimium, Vimperator](https://www.iplaysoft.com/vimium-and-vimperator.html)


## Remote Access

* [remote.it](https://www.remot3.it/web/index.html): Remote Device Access and Bulk Management

* Remote Desktop
    - TeamViewer
    - [VNC](https://www.realvnc.com/en/)
    - [NoMachine](https://www.nomachine.com/): Free Remote Desktop For Everybody
    - [xrdp](http://www.xrdp.org/): An open source remote desktop protocol(rdp) server.The goal of this project is to provide a fully functional Linux terminal server, capable of accepting connections from **rdesktop, freerdp, and Microsoft's own terminal server / remote desktop clients**.

* [SSH](https://www.ssh.com/) & Telnet
    - [OpenSSH](http://www.openssh.com/)
    - [bitvise](https://www.bitvise.com)
    - [PuTTY](https://www.putty.org/), a free SSH and Telnet client

* 无线传屏
    - [MirrorOp](http://www.mirrorop.com/)

## Files Transfer/Share

* FTP/SFTP
    - FTP三剑客：CuteFTP、LeapFTP、FlashFXP
    - [FileZilla](https://filezilla-project.org/): the free FTP solution

* scp
* rsync

### Network Share

- [常用共享介绍：CIFS、AFP、NFS、WebDAV](https://www.getnas.com/2015/01/176.html)  
- Samba: 进行网络共享的工具，比如分享打印机，互相之间传输资料文件  
    * [samba.org](https://www.samba.org/)
    * [Samba-Ubuntu](http://wiki.ubuntu.org.cn/Samba)
    * PC Ubuntu 连接 华为HuaweiShare 手机：`smb://<phone-ip>`


## Network Protocol

* [RFC Editor](https://www.rfc-editor.org/)
* [Network Tools](https://network-tools.com/): Traceroute, Ping, Domain Name Server (DNS) Lookup, WHOIS, Email Verification Tools
* [Essential NetTools](https://www.tamos.com/products/nettools/)
* [freeSSHd and freeFTPd](http://www.freesshd.com/), open source SSH and SFTP servers for Windows
* [C-Kermit](http://www.columbia.edu/kermit/ck90.html), Portable OPEN SOURCE Scriptable Network and Serial Communication Software for Unix and VMS


### Network Analysis

* [协议分析网](http://www.cnpaf.net)
* [igraph](http://igraph.org/) – The network analysis package
* [Wireshark](https://www.wireshark.org/) is the world’s foremost and widely-used network protocol analyzer.

### Website Rank

* [Alexa](https://www.alexa.com/)
* [Alexa中国](http://www.alexa.cn/)


### Whois / Domain

* [WHOis.net](https://www.whois.net/)
* [who.is](https://who.is/): WHOIS Search, Domain Name, Website, and IP Tools
* [gandi.net](https://www.gandi.net)

### Scanner

* SuperScan: 强大的端口扫描工具
* [Nmap](https://nmap.org/): Nmap ("Network Mapper") is a free and open source (license) utility for network discovery and security auditing
* [Angry IP Scanner](http://angryip.org/): Fast and friendly network scanner
* ARP Scan
* [Advanced IP Scanner](http://www.advanced-ip-scanner.com/)


### [Mosh](https://mosh.org/)

Remote terminal application that allows roaming, supports intermittent connectivity, and provides intelligent local echo and line editing of user keystrokes.

Mosh is a replacement for interactive SSH terminals. It's more robust and responsive, especially over Wi-Fi, cellular, and long-distance links.

Mosh is free software, available for GNU/Linux, BSD, macOS, Solaris, Android, Chrome, and iOS.

### TCP/UDP

* TCPView: 一个查看端口和线程的小工具
* sokit: TCP/UDP数据包收发测试(调试)工具

### ADSL
* [ADSL（PPPOE）接入指南](http://wiki.ubuntu.org.cn/ADSL%EF%BC%88PPPOE%EF%BC%89%E6%8E%A5%E5%85%A5%E6%8C%87%E5%8D%97)


## SpeedTest

* [ping检测](http://ping.chinaz.com/)
* [The Global Broadband Speed Test](http://www.speedtest.net/)
* [speedtest-cli](http://man.linuxde.net/speedtest-cli)
* [17CE](https://www.17ce.com/)

## Config Wireless Network On Linux

* [Configure static IP address on Ubuntu 16.04 LTS Server](https://michael.mckinnon.id.au/2016/05/05/configuring-ubuntu-16-04-static-ip-address/)
  ```sh
  # /etc/network/interfaces

  # interfaces(5) file used by ifup(8) and ifdown(8)
  # Include files from /etc/network/interfaces.d:
  source-directory /etc/network/interfaces.d

  auto eth0
  # iface eth0 inet dhcp
  iface eth0 inet static
  address 192.168.1.106
  netmask 255.255.255.0
  gateway 192.168.1.1
  dns-nameservers 8.8.8.8
  ```

* [WPA supplicant (ArchLinux)](https://wiki.archlinux.org/index.php/WPA_supplicant)
