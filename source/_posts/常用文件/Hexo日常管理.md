---
title: Hexo日常管理
date: 2019-07-30 17:27:28
urlname: hexo-blog-alltag-verwalten
toc: true
tags: [Hexo]
categories: [常用文件]
notshow: true

---

# 复制MD文件

<script src="https://gist.github.com/maiernte/7d23ede58ddd69608bd7ee98b743e155.js"></script>
#### 查找最新文件

```sh
ls -t /Users/mai/Projects/hexo/source/_posts/*.md | head -1 | xargs ls -l | awk '{print  $6 "-" $7 "-" $8 }'

# 最旧的文件就应该是
ls -t /Users/mai/Projects/hexo/source/_posts/*.md | tail -1 | xargs ls -l | awk '{print  $6 "-" $7 "-" $8 }'
```



# 其它

Hexo 代码折叠

```
{% fold 点击显/隐内容 %}
需要隐藏的内容。。。
{% endfold %}
```



# 参考文件

[有用的shell命令](helpfull-shell-command.html)

# 会导致编译奔溃的错误

大括号和井号连在一起

```sh
{#、 #}、{#} 这三种情况都会导致系统奔溃
{} 和 # 之间如果有别的字符就不会。如 { # }
或者放在代码段内也不会。行内代码不能避免这种情形。
```

