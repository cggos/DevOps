# Synology DS128+

-----

## 文件服务

### SMB

* Ubuntu通过Samba访问NAS共享文件夹
  - 修改`/etc/samba/smb.conf`，更改smb client版本
    ```ini
    [global]

    # SMB protocol
    client min protocol = SMB2
    client max protocol = SMB3
    ```
  - 重启
    ```sh
    # restart smb service
    sudo systemctl restart smbd.service

    # or reboot
    sudo reboot
    ```
  - 连接NAS服务器
    ```sh
    # 文件浏览器
    smb://<nas-ip>

    # CLI
    smbclient -L <nas-ip> -U <user-name> # 查看要访问的ip地址下的共享目录
    ```

### FTP

* FileZilla客户端


## 终端机

* NAS启用SSH功能，客户端连接 `ssh <user-name>@<nas-ip>`


## TeamViewer

* 登录TeamView账号，加入NAS，连接
