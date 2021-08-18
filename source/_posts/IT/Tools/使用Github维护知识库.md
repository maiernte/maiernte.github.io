---
title: 使用Github维护知识库
date: 2019-07-24 23:02:14
urlname: use-github-in-wiki
toc: true
tags: [工具]
categories: [IT, Tools]
notshow: true

---

### 部署以及更新

- **初建**：将文件夹设置为仓库。只是第一次需要，以后就基本不用。
``git init``

-  **更新**：更新所有的文件。
``git add .``

-  **描述**：更新描述(optional 不是必须的)
``git commit -m "my command..."``

-  **推送**：上传到云仓库
``git push -u origin master``

<!-- more -->

#### 详细指令

```bash
git remote add origin https://github.com/maiernte/NewAngular.git

git push -u origin master

# For the next commit
$ git add .   # add to index only files created/modified and not those deleted
$ git add -u  # add to index only files deleted/modified and not those created
$ git add -A  # do both operation at once, add to index all files
```
下载及更新

```bash
#下载整个项目
git clone XXXXX
#从服务器更新
git pull [xxxxxx]
#Help
git hepl VERB
git VERB -h
```

克隆指定 Branch， 因为有时候 master 和 gh-pages 上存放的是不同的文档。

```sh
git clone https://github.com/maiernte/gitbook_python_finance.git --branch master new_fold
```

设置忽略文件夹以及文件

```sh
touch .gitignore
vim .gitignore
```

并添加类似的行

```
# See https://help.github.com/ignore-files/ for more about ignoring files.
# dependencies
/node_modules

# testing
/coverage
# production
/build
# misc
.DS_Store
.env.local
npm-debug.log*
yarn-debug.log*
```



### 设置git身份信息

```bash
git config --global user.name "你的用户名"
git config --global user.email "你的邮箱" 
```



### 密码和凭证

#### 保存 Github 用户名和密码

Mac 下面每次 `push`  都要询问用户名和密码，很麻烦。而且将来不利于用脚本控制部署。有个解决的办法：进入项目根目录，执行一下命令

```sh
git config --global credential.helper store
```

然后推送一次，输入账号和密码后，第二次推送就不需要了!



#### SSH Key 凭证

```sh
# 加入 SSH Agent
ssh-agent -s
```

如果出现类似`Agent pid XXXX`这样的字样，则跳过下一步，否则输入：

```sh
eval `ssh-agent -s`
```

直到出现`Agent pid XXXX`这样的提示之后，输入：

```sh
ssh-add ~/.ssh/id_rsa
```

这样，你成功的在本地生成了一个可用的SSH key。

下面将这个key添加到github网站。 打开https://github.com/settings/ssh，点击`Add SSH Key`，复制`id_rsa.pub`中的所有内容到`Key`框中，在`Title`框中输入方便自己记忆的名字（建议输入能让自己明白是哪台电脑的名字，方便以后管理）。 当网页显示添加成功后，就已经完成了全部的操作。 下面进行一些测试，同样是打开Git Bash，输入：

```
ssh -T git@github.com
```

bash中会显示如下字样：

```
The authenticity of host 'github.com (207.97.227.239)' can't be established.
RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
Are you sure you want to continue connecting (yes/no)?
```

输入yes之后，计算机会自动将`github.com`列入已知的host，然后会出现如下提示：

```
Hi username! You've successfully authenticated, but GitHub does not
provide shell access.
```

如果成功看见，说明你已经配置好了，快去享受爽快的hexo一键部署吧； 如果出现任何错误提示，请仔细检查自己的操作，或者将错误信息发给我。

[参阅：十步轻松搞定Hexo]([https://gavinlee1.github.io/2017/02/25/%E5%8D%81%E6%AD%A5%E4%B9%8B%E5%86%85%E8%BD%BB%E6%9D%BE%E6%90%9E%E5%AE%9A-Hexo-GitHub%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2/](https://gavinlee1.github.io/2017/02/25/十步之内轻松搞定-Hexo-GitHub搭建个人博客/))

如果要多台电脑共同使用同一个SSH-Key，先在第二台电脑上用这个key的相同邮件生成一个新的key
```
ssh-keygen -t rsa -b 4096 -C "username@gmail.com"
```
用第一台电脑上的两个key文件 `id_rsa, id_rsa.pub` 覆盖第二台电脑的文件（*注意备份*）。确保NEW上的两个文件的权限是正确的，id_rsa是600，id_rsa.pub是644，比如：
```sh
-rw------- 1 fancy fancy 1675 2013-03-19 12:55 id_rsa
-rw-r--r-- 1 fancy fancy 406 2013-03-19 12:55 id_rsa.pub
# 查看权限命令是 
ls -l
# 更改权限命令是
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```


### 删除仓库

1. 点开仓库
2. 点击右上角的 `Settings`
3. 滚动到最下面 `Done Zone`， 选择 `Delete this repository`。

### 恢复所有修改

```sh
git checkout . #本地所有修改的。没有的提交的，都返回到原来的状态
git stash #把所有没有提交的修改暂存到stash里面。可用git stash pop回复。
git reset --hard HASH #返回到HASH点，不保留修改。
git reset --soft HASH #同上，保留修改。HASH 是节点号，z.B. 7d593c5

git clean -df #返回到某个节点
git clean 参数
    -n 显示 将要 删除的 文件 和  目录
    -f 删除 文件
    -df 删除 文件 和 目录
--------------------- 
git describe --always # 查看当前节点号
git log # 查看所有HEAD号和Commit描述
```

更加暴力的方式是

```sh
it checkout . && git clean -xdf
```



#### 清除历史记录

{% fold 代码 %}
```
1. Checkout
   git checkout --orphan latest_branch

2. Add all the files
   git add -A

3. Commit the changes
   git commit -am "commit message"

4. Delete the branch
   git branch -D master

5. Rename the current branch to master
   git branch -m master

6. Finally, force update your repository

   git push -f origin master
```
{% endfold %}

### 私人仓库

作为个人笔记，不应该设为public，这样别人可以浏览。==2019== 年Github更新了[新的政策](https://www.infoq.cn/article/aKm94Aw1RmDL_9Gysm8D
)：
> GitHub Free：包含无限制的私人存储库。有了 GitHub Free，开发人员可以将 GitHub 用于私有项目，每个存储库最多可以有三个协作者。许多开发人员希望使用私人仓库申请工作，做一些 side project，或者在公开发布之前先私下尝试一些东西。从今天开始，这些场景在 GitHub 上可以免费实现（未来可能有更多场景）。 公共存储库仍然是免费的，并包括无限合作者。



1. 点开仓库
2. 点击右上角的 `Settings`
3. 滚动到最下面 `Done Zone`， 选择 `Make this repository private`。

## 文摘资源

[Git submodule 子模块的管理和使用](https://www.jianshu.com/p/9000cd49822c)