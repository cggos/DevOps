# Git

* [github代码clone加速](http://nullpointer.pw/github%E4%BB%A3%E7%A0%81clone%E5%8A%A0%E9%80%9F.html)

-----

[TOC]

## credential.helper

* 设置记住密码（默认15分钟）：`git config --global credential.helper cache`

* 如果想自己设置时间，可以这样做：`git config credential.helper 'cache --timeout=3600'`, 这样就设置一个小时之后失效

* 长期存储密码：`git config --global credential.helper store`

* 增加远程地址的时候带上密码也是可以的

## http.postBuffer

* `git config --global http.postBuffer 524288000`，修改后速度有质的提升

## How do I show the git branch with colours in Bash prompt?  

1. 注释掉`~/.bashrc`文件中如下内容
    ```
    # if [ "$color_prompt" = yes ]; then
    #     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # else
    #     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    # fi
    # unset color_prompt force_color_prompt
    ```

2. 在`~/.bashrc`文件中添加如下内容
    ```sh
    # Add git branch if its present to PS1
    parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    }
    if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
    else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
    fi
    ```

## Enable git bash completion

1. 下载git源码
   ```sh
   git clone git://git.kernel.org/pub/scm/git/git.git
   ```

2. 配置
   ```sh
   cp git/contrib/completion/git-completion.bash ~/.git-completion.bash
   ```

3. 在`~/.bashrc`文件中添加如下内容
   ```sh
   if [ -f ~/.git-completion.bash ]; then
     . ~/.git-completion.bash
   fi
   ```

## install git from source

```sh
sudo apt-get update
sudo apt-get install build-essential fakeroot dpkg-dev libcurl4-openssl-dev
sudo apt-get build-dep git
mkdir ~/git-openssl
cd ~/git-openssl
apt-get source git
cd git-2.17.0/

vim debian/control # replace all libcurl4-gnutls-dev with libcurl4-openssl-dev
vim debian/rules # remove line "TEST =test" otherwise it takes longer to build the package

sudo dpkg-buildpackage -rfakeroot -b -uc -us # add "-uc -us" to avoid error "gpg: No secret key"
sudo dpkg -i ../git_2.17.0-1ubuntu1_amd64.deb
```

## 安装commitizen

```sh
sudo apt-get install npm
sudo npm install -g n
sudo n 8.10.0
sudo npm install -g commitizen
sudo npm install -g conventional-changelog
npm init
commitizen init cz-conventional-changelog --save --save-exact
```
