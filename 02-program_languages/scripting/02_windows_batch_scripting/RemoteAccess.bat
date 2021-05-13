echo 建立非空连接
net use \\IP\ipc$ "password" /user:"username"

echo 查看远程D盘下的1.txt文件的内容
type \\IP\D$\1.txt

echo 查看远程主机的共享资源（但看不到默认共享） 
net view \\IP 

echo 查看本地主机的共享资源（可以看到本地的默认共享） 
net share 

echo 得到远程主机的用户名列表 
nbtstat -A IP 

echo 得到本地主机的用户列表 
net user 

echo 查看远程主机的当前时间 
net time \\IP 

echo 显示本地主机当前服务 
net start 

echo 向远程主机复制文件(将当前目录下的文件复制到对方c盘内) 
copy 1.txt \\IP\c

echo 删除一个ipc$连接
net use \\IP\ipc$ /del

pause

