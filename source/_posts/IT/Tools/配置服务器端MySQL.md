---
title: 配置服务器端MySQL
date: 2019-08-06 17:26:28
urlname: config-mysql-access-privileges-on-vps
toc: true
tags: [工具]
categories: [IT, Tools]
notshow: true

---

[文章](https://blog.csdn.net/bird3014/article/details/78481104)

###### 问题一：端口状态

1. 查看 3306 端口状态 `sudo netstat -an | grep 3306`

> tcp  0 0 127.0.0.1:3306 0.0.0.0:* 

3306端口是默认绑定在本地IP 127.0.0.1上的，所以外网无法访问该主机的3306端口。 
打开MySQL的配置文件：`sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf`

2. 找到如下内容的一行并注释掉：

>  bind-address          = 127.0.0.1

3. 重启MySQL服务

> sudo systemctl restart mysql

然后使用如下命令查看端口绑定状态

> `sudo netstat -an | grep 3306`

----

###### 问题二：用户权限

查看用户权限

```mysql
sudo mysql -uroot -p[你的密码]
use mysql
select user,host from user
```

当显示如下，表示用户root只允许内网访问

> root  localhost

给用户授权

```mysql
grant all privileges on *.* to 'root'@'[允许的ip]' identified by '[密码]' with grant option;
flush privileges;
```

其中*`[允许的ip]`*如果设置为**%**的话则表示所有$ip$都可以访问，*`[密码]`*表示外网访问的密码是什么。比如我设置成所有$ip$都可访问，密码是$root$，则命令如下：

```mysql
grant all privileges on *.* to 'root'@'%' identified by 'root' with grant option;
flush privileges;
select user,host from user;
```

重新查看，会显示 

> root %
>
> root localhost



###### 安装 phpMyAdmin

