# Grub & BIOS

-----

## Grub

配置单Ubuntu系统开机启动显示grub菜单：  

修改`/etc/default/grub`文件，修改内容

```title="/etc/default/grub"
# GRUB_HIDDEN_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT_QUIET=false
GRUB_TIMEOUT=10
```

该文件如下： 

```title="/etc/default/grub"
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n 'Simple configuration'

GRUB_DEFAULT=0
# GRUB_HIDDEN_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT_QUIET=false
GRUB_TIMEOUT=10
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX=""

# Uncomment to enable BadRAM filtering, modify to suit your needs
# This works with Linux (no patch required) and with any kernel that obtains
# the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
#GRUB_BADRAM="0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

# Uncomment to disable graphical terminal (grub-pc only)
#GRUB_TERMINAL=console

# The resolution used on graphical terminal
# note that you can use only modes which your graphic card supports via VBE
# you can see them in real GRUB with the command `vbeinfo'
GRUB_GFXMODE=1920x1080
GRUB_GFXPAYLOAD_LINUX=keep

# Uncomment if you don't want GRUB to pass "root=UUID=xxx" parameter to Linux
#GRUB_DISABLE_LINUX_UUID=true

# Uncomment to disable generation of recovery mode menu entries
#GRUB_DISABLE_RECOVERY="true"

# Uncomment to get a beep at grub start
GRUB_INIT_TUNE="480 440 1"
```

然后，`sudo update-grub`，最后重启即可。

## Boot & BIOS

* [Ubuntu 16.04在启动和关机时不显示启动和关机画面且显示详细的命令信息，没有进度条和Logo，或者只有紫色界面，或者没有开机画面等问题解决](https://www.cnblogs.com/EasonJim/p/7130157.html?utm_source=itdadao&utm_medium=referral)

* [Check BIOS, UEFI, motherboard info in Linux](https://www.pcsuggest.com/check-bios-uefi-motherboard-info-in-linux/)


```bash
# biosdecode parses the BIOS memory and prints information about all structures (or entry points) it knows of
biosdecode

# dmidecode  is  a tool for dumping a computer's DMI (some say SMBIOS) table contents in a human-readable format
dmidecode

cat /proc/iomem | head
```
