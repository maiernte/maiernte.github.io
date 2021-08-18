---
title: Gitbook攻略
date: 2019-08-14 23:02:14
urlname: gitbook_with_typora_gh-pages
toc: true
tags: [工具]
categories: [IT, Tools]

---

本文为你介绍如何使用利用 **Typora + gitbook-cli + Github Pages**  书写Gitbook. 在本地用 Typora 书写 md 文件, 用 gitbook-cli  编译, 最后发布到 Github Pages 上.



<!-- more -->

# 安装

前提是已经安装了Node, 直接用npm包管理工具安装:

```sh
sudo npm install -g gitbook-cli
gitbook -V # 注意是大写V
```

> CLI version: 2.3.2
> GitBook version: 3.2.3

# 新建书籍

1. 为新书建立一个根目录 `mkdir pytho_finance`

2. 在该目录下执行（命令行下）：`gitbook init`，之后会在该目录下产生2个文件，分别是README.md（书籍的介绍）和SUMMARY.md（书籍的目录结构）。

![gitbook目录的写法](https://github.com/maiernte/img/raw/master/Tech/gitbook目录的写法.png)

3. 按照上图格式填写目录和文件, 然后再次执行 `gitbook init` , GitBook 会查找 SUMMARY.md 文件中描述的目录和文件，如果没有则会将其创建. 

4. 然后就可以预览书籍了 `gitbook serve`. 执行命令后会对 Markdown 格式的文档进行转换，默认转换为 html 格式，提示Serving book on http://localhost:4000，打开网址即可查看.
5. 构建书籍

```sh
gitbook build
```

默认将生成的静态网站输出到 _book 目录。实际上，这一步也包含在 gitbook serve 里面，因为它们是 HTML，所以 GitBook 通过 Node.js 给你提供服务了。

build 命令可以指定路径, 或者指定端口, 或者生产 pdf , epub, mobi 等格式. [具体参考文章](https://www.cnblogs.com/eveblog/p/10003217.html). 

# 发布到Github Pages

```sh
git init
git remote add origin https://github.com/maiernte/gitbook_python_finance.git
git add .
git commit -m "new book"
git push -u origin master # 将源代码推送到master
```

在GitHub的仓库中新添一个 **gh-pages** 的Branch. 

```sh
mkdir new_fold
cd new_fold
rm -rf . # 删除这个目录下所有文件, 注意那  .git 文件夹不能删除

# 在源代码目录中,也就是md文件的目录
gitbook build 

# 将会产生一个 _book 目录
# 添加忽略, 以免下次推送的时候 _book  目录被推送.
echo "*~" > .gitignore
echo "_book" >> .gitignore
echo "/node_modules" >> .gitignore

cp -r _book/* path_to/new_fold
```

:pen: 忽略文件夹，windows下的测试是 `/node_modules`， 不加双引号。

进入新目录, 推送编译后的html 和 js 文件到 gh-pages 的分支中去.

```sh
cd path_to/new_fold
git add .
git commit -m "to gh-pages"
git push -u origin gh-pages
```

如此实现了将源代码保存到master, 将静态网站推送到gh-pages, 一个仓库搞定! 在浏览器输入仓库地址, 就可以看到自己的Gitbook. 比如我新书地址

> https://maiernte.github.io/gitbook_python_finance/



## 更新和维护

因为master 和 gh-pages 上存放的是不同的文档，所以拉取的时候也有指定 branch

```sh
# 拉取源代码
git clone https://github.com/maiernte/gitbook_python_finance.git --branch master new_fold

# 拉取静态网站
git clone https://github.com/maiernte/gitbook_python_finance.git --branch gh-pages new_fold
```



# 个性化配置

在项目的根目录上添加一个 `book.json` 文件, 用来更全面的配置项目. 比如头文件, 插件等等.

```json
{
    "title": "使用Python处理金融数据",
    "author": "鎏金天涯 <mai.yongfeng@gmail.com>",
    "description": "使用Python处理金融数据的各种技术",
    "generator": "site",
    "plugins": ["mathjax"],
    "links": {
        "sidebar": {
            "鎏金天涯个人博客": "http://goldentianya.pub"
        }
    }
}
```

## 数学插件

在上述文件添加了 `"plugins": ["mathjax"]`,  并执行命令

```sh
gitbook install ./ # 会添加一堆 node_modules 包
```

更详细的配置请参阅[官方文档](https://chrisniael.gitbooks.io/gitbook-documentation/content/).

## 目录插件

[项目地址和文档](https://www.npmjs.com/package/gitbook-plugin-page-toc)

将 ***book.json*** 文件修改为  `"plugins": ["mathjax", "page-toc" ], ​` 每一页的目录就会出现在右上角。



# 编译错误列表

版本

```
CLI version: 2.3.2
GitBook version: 3.2.3
```

## sharing 插件出错

添加了 `page-toc` 插件后，`gitbook serve` 的时候总是出现错误。就算把文章改回原来的样子也无补于事。

> info: 7 plugins are installed
> info: loading plugin "livereload"... OK
> info: loading plugin "highlight"... OK
> info: loading plugin "search"... OK
> info: loading plugin "lunr"... OK
> info: loading plugin "sharing"... OK
> info: loading plugin "fontsettings"... OK
> info: loading plugin "theme-default"... OK
> info: found 1 pages
> info: found 0 asset files
>
> Error: ENOENT: no such file or directory, stat 'D:\f040371\git_book\plattform_finance\_book\gitbook\gitbook-plugin-sharing\buttons.js'

### 解决方法

修改 `C:\Users\f040371\.gitbook\versions\3.2.3\lib\output\website\copyPluginAssets.js` 文件中的 112 行

![copyPluginAssets.js](https://images2018.cnblogs.com/blog/623717/201808/623717-20180815170921683-2030924288.png)

将 `confirm: true` 改为 `confirm: false`



参考文章:

---

[使用GitBook和Typora写知识库](https://beihaionline.com/11523.html)

[gitbook+git+typora 的使用过程](https://www.cnblogs.com/eveblog/p/10003217.html)

[GitBook + Typora + Git 编写电子文档](https://www.jianshu.com/p/02caaaaa97ef)

[Gitbook 发布到 Github Pages](http://www.chengweiyang.cn/gitbook/github-pages/README.html)

