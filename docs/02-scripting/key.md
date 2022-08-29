# Linux Key

-----

## Overview

公钥和密钥，是现在密码学的一个发明。以我们生活中的例子来说，公钥相当于你的银行帐号，私钥相当于你的银行存折和银行卡。

## GPG/PGP

* https://wiki.ubuntu.org.cn/GPG/PGP

PGP，简单的说，是一款以利用公钥和密钥技术的加密和身份验证软件；而GPG呢，就是开源的PGP。


### 公钥服务器（GPG Keyserver）

现在网络上有很多公钥服务器，而且都是互相同步的。比如：

* http://keyserver.ubuntu.com:11371 
* http://pgp.mit.edu/ 
* http://wwwkeys.pgp.net:11371 
* http://subkeys.pgp.net 

## SSH Key

* Generating a new SSH key
  ```sh
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
  ```
  