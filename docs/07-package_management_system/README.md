# PMS - Package Management System

* [Package Management Basics: apt, yum, dnf, pkg](https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg)

-----

## Types

* [OpenPKG](http://www.openpkg.org/): Cross-Platform Multiple-Instance Unix Software Packaging

* [Snaps](https://snapcraft.io/) are containerised software packages that are simple to create and install
* [Conan](https://conan.io/): the C / C++ Package Manager for Developers
* [npm](https://www.npmjs.com/) is the package manager for JavaScript and the world’s largest software registry
* [Packagist](https://packagist.org/) is the main Composer repository. It aggregates public PHP packages installable with Composer.
* [RPM Fusion](https://rpmfusion.org/)
* [RPM repository on fr2.rpmfind.net](http://rpmfind.net/linux/RPM/)
* [AppImage](https://appimage.org/): Linux apps that run anywhere


## Software Archive

* [SourceForge](https://sourceforge.net/): The Complete Open-Source Software Platform
* [Fossies](https://fossies.org/): The Fresh Open Source Software archive with special browsing features
* [OpenHub](https://www.openhub.net/): Discover, Track and Compare Open Source
* [sourceware.org](https://www.sourceware.org/): Free software!  Get your fresh hot free software!
* [Freecode](http://freshmeat.sourceforge.net/)
* [Tigris.org](http://www.tigris.org/): Open Source Software Engineering Tools

### Snap

设置代理

```sh
# 前置操作, 修改  systemctl edit 使用的编辑器为 VIM, 如果不介意 Nano 可以跳过这一步
$ sudo tee -a /etc/profile <<-'EOF'
export SYSTEMD_EDITOR="/bin/vim"
EOF
$ source /etc/profile

# 开始设置代理
$ sudo systemctl edit snapd
加上：
[Service]
Environment="http_proxy=http://127.0.0.1:port"
Environment="https_proxy=http://127.0.0.1:port"

#保存退出。
$ sudo systemctl daemon-reload
$ sudo systemctl restart snapd
```

安装卸载软件

```sh
sudo snap refresh

sudo snap remove okular && sudo snap install okular
```

## Open Source Code Archive

* [GitHub](https://github.com/)
* [Gitee码云](https://gitee.com/)
* [GitLab](https://gitlab.com/) is a single application for the entire DevOps lifecycle
* [Bitbucket](https://bitbucket.org/) is more than just Git code management. Bitbucket gives teams one place to plan projects, collaborate on code, test, and deploy
* [CodeProject](https://www.codeproject.com/) - For those who code
* [CodeForge](http://www.codeforge.com/): Search and download open source project / source codes
* [CodePlex](https://archive.codeplex.com/) was Microsoft's free, open source project hosting site, which ran from 2006 through 2017
* [Libraries.io](https://libraries.io/) - The Open Source Discovery Service
* [searchcode](https://searchcode.com/) is a free source code and documentation search engine


## OTA (Over The Air)

OTA（空中下载），具体指远程无线方式，OTA 技术可以理解为一种远程无线升级技术。

### FOTA

Firmware OverThe Air/固件空中升级，通过云端为具有连网功能的设备：例如手机、平板电脑、移动互联网设备等提供固件升级服务，手机中的固件升级即可称为 FOTA。
