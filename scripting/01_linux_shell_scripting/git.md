# Git

* [github代码clone加速](http://nullpointer.pw/github%E4%BB%A3%E7%A0%81clone%E5%8A%A0%E9%80%9F.html)

-----

### How do I show the git branch with colours in Bash prompt?  

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

### Enable git bash completion:   

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
