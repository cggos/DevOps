# Disk & Partition

-----

* [Resize Partition and Filesystem with fdisk & resize2fs](https://geekpeek.net/resize-filesystem-fdisk-resize2fs/)

```sh
mount -t ext4 /dev/sdb1 /data
mount | column -t             # 查看挂接的分区状态
fdisk                         # manipulate disk partition table
swapon -s                     # 查看所有交换分区
hdparm -i /dev/hda            # 查看磁盘参数(仅适用于IDE设备)
free -m                       # Display amount of free and used memory in the system
df -h                         # report file system disk space usage
lsblk                         # list block devices
resize2fs                     # ext2/ext3/ext4 file system resizer
e2fsck                        # check a Linux ext2/ext3/ext4 file system
```

磁盘格式化分区，并开机挂载：

* 查看磁盘
  ```sh
  sudo fdisk -l
  ```
* 磁盘分区
  ```sh
  sudo fdisk /dev/sdb
  ```
* 磁盘格式化
  ```sh
  sudo mkfs.ext4 /dev/sdb1
  ```
* 开机挂载硬盘，在 **/etc/fstab** 中添加
  ```sh
  /dev/sdb1 /dev_sdb ext4 defaults 0 0
  ```
* 建立软链接
  ```sh
  ln -s /dev_sdb ~/dev_sdb
  ```

修改卷标名：

* 查看卷标
  ```sh
  sudo blkid
  ```

* umount
  ```sh
  sudo umount /dev/sdc1
  ```

* 修改卷标名
  ```sh
  sudo e2label /dev/sdc1 "udisk_cg"     # ext2 or ext3
  sudo exfatlabel /dev/sdc1 "udisk_cg"  # exFat
  sudo ntfslabel /dev/sdc1 "udisk_cg"   # NTFS
  ```

* solve problem of "g++: internal compiler error: Killed (program cc1plus)"
  ```sh
  # create swap space
  sudo dd if=/dev/zero of=/swapfile bs=64M count=16
  sudo mkswap /swapfile
  sudo swapon /swapfile

  # shut the swap space down
  sudo swapoff /swapfile
  sudo rm /swapfile
  ```
