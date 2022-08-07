# Synology DS128+

-----

## OA

### Note Station

* [Maboroshy/Note-Station-to-markdown](https://github.com/Maboroshy/Note-Station-to-markdown)

## 文件服务

### SMB

Ubuntu通过Samba访问NAS共享文件夹

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

### FTP/SFTP

* FileZilla 客户端

### WebDAV

- [https://www.cnblogs.com/Devopser/p/11280742.html](https://www.cnblogs.com/Devopser/p/11280742.html)
- [https://sleeplessbeastie.eu/2017/09/04/how-to-mount-webdav-share/](https://sleeplessbeastie.eu/2017/09/04/how-to-mount-webdav-share/)

Ubuntu上挂载WebDAV服务：

* 直接命令行
  ```bash
  sudo mount -t davfs -o noexec http://cggos.i234.me:5005 /mnt/dav/ # or https 5006
  
  # or
  sudo mount.davfs -o rw,uid=cg http://cggos.i234.me:5005 /mnt/dav/ # or https 5006
  ```

* 或者，在文件 **/etc/fstab** 中添加
  ```bash title="/etc/fstab"
  http://cggos.i234.me:5005 /mnt/dav/ davfs _netdev,noauto,user,uid=cg,gid=cg 0 0
  ```

然后，

```bash
sudo usermod -a -G davfs2 cg

groups

### su -l cg
# log out and log in

groups
```

### 共享文件夹

## 远程连接

### 终端机

* NAS启用SSH功能，客户端连接 `ssh <user-name>@<nas-ip>`

### 远程桌面

### TeamViewer

* 登录TeamView账号，加入NAS，连接
