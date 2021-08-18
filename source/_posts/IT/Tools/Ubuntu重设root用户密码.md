---

title: Ubuntu重设root用户密码
date: 2019-07-26 17:51:03
urlname: ubuntu-reset-root-pw
toc: true
tags: [工具]
categories: [IT, Tools]
notshow: true

---

# 重设密码

原理上参考这份[中文指引][Chinese]就好。由于我的服务器是IONOS公司的，这里主要记录[IONOS][IONOS]的官方指引。（严格按照步骤）

```sh
网址 www.ionos.de/hilfe
# 选择 Server & Cloud Infrastructure
```



1. 打开 KVM-Konsole
2. 在用户管理平台软重启系统 Soft-Restart
3. 在 KVM-Konsole 这边按 ``ESC`` 键
4. 当出现类似一下界面，按 ``E`` 键

![](https://github.com/maiernte/img/raw/master/Tech/ubuntu-reset-root-1.png)

5. 然后会来到这个界面。
6. ![](https://github.com/maiernte/img/raw/master/Tech/ubuntu-reset-root-2.png)

7. 用上下键移动到“linux。。。”开始的那一行，并左右键移动到这行的末尾，空格，输入 `init=/bin/bash`

![](https://github.com/maiernte/img/raw/master/Tech/ubuntu-reset-root-3.png)

8. 按 `F10` 开始重启。等完成，进入命令模式后，输入以下命令。

   ```sh
   mount -o remount,rw /
   passwd
   Enter new UNIX password:
   Retype new UNIX password:
   passwd: password updated successfull
   ```

   

9. 最后输入命令重启系统！

   ```sh
   reboot -f 
   ```

# 设置公共SSH

在配置 github 的时候已经生成了 ssh-key ，可以用以下方法。

```sh
cd ~/.ssh
cp id_rsa.pub authorized_keys
ssh-copy-id -i ~/.ssh/id_rsa.pub root@217.160.61.19 # 我的用户名和服务器地址，默认端口 22
# 指定端口号为2212：ssh-copy-id -i ~/.ssh/id_rsa.pub -p 2212 user@ip

ssh root@217.160.61.19 # 登录并输入密码，第二次就不再需要密码了。

```



---

[Chinese]:  https://ifmx.cc/linux/398.html "中文指引"
[IONOS]: https://www.ionos.de/hilfe/server-cloud-infrastructure/erste-schritte/root-passwort-zuruecksetzen/root-passwort-zuruecksetzen-ubuntu/ "IONOS官方指引"


