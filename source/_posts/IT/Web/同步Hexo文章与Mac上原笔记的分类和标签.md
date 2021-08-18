---
title: 同步Hexo文章与Mac上原笔记的分类和标签
date: 2019-08-01 17:30:00
urlname: synchron-the-tag-and-categories-btw-pc-hexo
toc: true
tags: [Hexo, Mac]
categories: [IT, Web]
---



最近才搞明白，原来**Hexo**博客的`_post`文件夹里面的Markdown原文件是可以按照分级嵌套的目录结构摆放的。编译的时候才放到**public**这个单一目录下。如果能让文章在Hexo的==分类==严格跟md文件的存储目录一一对应，将来需要找原文件的时侯会方便很多。😄



使用**Mac**系统的同学也知道，mac有个很风骚的操作，就是给文件分配不同颜色的标签，非常方便文件寻找。我也希望博客上的文章标签，能跟Mac系统里的标签统一起来。:smile: 



实现物理存储目录与`Hexo分类`统一很简单，将源md文件的相对存储路径写到文件meta元素的`categories`里面就行了。比如源文件放在`我的博客-->IT-->前端`，文章的头文件就写成这样：`categories：[IT, 前端]`。



实现标签的统一稍微麻烦一点，需要先读取文件实际分配到的标签。网上已经有一个公开的项目， [tag](https://github.com/jdberry/tag) 。下载并安装，就可以通过 `tag` 命令读取文件和文件夹的标签。

```sh
# 安装
brew install tag
# 查看版本
tag --version
# 读取文件标签
tag --list fileUrl
```



我已经写好了相应的脚本文件，下载并执行脚本文件就好了。脚本文件里的`dirPath`变量是我的统一存放md源文件的文件夹，你需要改成自己的存放路径，那样就不用每次运行的时候输入一遍。

> 我在Hexo项目的根目录新添一个文件夹专门存放管理的脚本文件，每次都在终端运行这个脚本，所以默认执行路径是 `./source/_post`。



运行脚本的时候可以设定时间参数，过滤掉太久远的文件。默认情况不会更改文件内容，只查看文件的实际分类和标签是否与文内头文件相同。然后按照给出的列表手动更改。如果想让程序自动更改，按照提示输入`fix`参数就好。

<script src="https://gist.github.com/maiernte/b906f7bb99ae8ea3aa616f0df9a4679a.js"></script>