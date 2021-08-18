---
title: 搭建Hexo博客的流水账
date: 2019-07-25 05:49:15
urlname: how-build-my-hexo-blog
toc: true
tags: [Hexo]
categories: [IT, Web]
notshow: false

---



建网过程中的一些流水账。以备将来查询。

<!-- less -->

# 建立网站

## Github配置

输入命令 `ssh-keygen -t rsa -b 4096 -C "myname@gmail.com"`。



密码 `T1`。(下列展开后复制)

> 将文件 ~/.ssh/id_rsa.pub 中的内容复制到 Github 的SSH-Key 内就可以了。(备份文件已上传百度网盘)

3. 在Github上新建SSH-Key名称为`gmail`

[具体步骤参阅此文章](https://gavinlee1.github.io/2017/02/25/十步之内轻松搞定-Hexo-GitHub搭建个人博客/)

```
ssh-keygen -t rsa -b 4096 -C "username@gmail.com"
[Enter]
[password T..1]

eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa

cd ~
cd .ssh
ls
vim id_rsa.pub
(然后复制钥匙串)
```
4. 测试公匙

```
$ ssh -T git@github.com

Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

## 安装Hexo

参考资料[^1] [^7]。
1. 安装node.js 因为以前已经安装过，所以跳过。
2. 安装 Hexo `$ npm install hexo-cli -g` 
3. 创建网站
```command
mkdir mywiki
cd mywiki
hexo init
npm install
```
4. 生成静态页面 `hexo g` or `hexo generate`
5. 启动本地网站服务 `hexo s` or `hexo server`
> 网站一般会运行在 http://localhost:4000/
> Press Ctrl+C to stop.

6. 用pow做服务本地运行

**Install**

```
$ curl get.pow.cx | sh
```

**Setup**

Symlink the folder into `~/.pow`

```
$ cd ~/.pow
$ ln -s /path/to/test
```

## 发布到Github

终于搭建好站点部署环境啦，那么要怎么样将我们本地生成预览好的页面发布到github上呢？很简单，Follow!

首先，打开blog目录下的`_config.yml`，找到deploy段，配置成这样

> deploy:
>   type: git
>   repository: git@github.com:yourname/yourname.github.io.git
>   branch: master

注意将代码里面的yourname换成你账号的username。

设置git身份信息

> git config --global user.name "你的用户名"
> git config --global user.email "你的邮箱" 

执行以下指令进行部署

`hexo d -g `

如果提示没找到git，请先执行以下指令

`cnpm install hexo-deployer-git --save` 

再次部署后，浏览器打开 [https://yourname.github.io](https://yourname.github.io/) 就可以看到刚才本地预览页面。

## 网站基本配置

### Next 主题

主题配置文件说明

{% fold 点击显/隐内容 %}

```ini
# Hexo 站点配置文件
## Docs: https://hexo.io/docs/configuration.html
## Source: https://github.com/hexojs/hexo/

# 网站配置
title: Hexo            # 网站标题
subtitle:              # 网站副标题
description:           # 网站描述
author: John Doe       # 你的昵称
language:              # 网站使用的语言(英文:en, 简体中文:zh-Hans，繁体中文:zh-tw)
timezone:              # 网站时区，用于生成页面时填充相关时间，默认使用电脑时区，一般不用改

# URL
## 如果你的站点要放入子目录, 请将url设置为'http://yoursite.com/child' 并将根目录设置为'/child/'
url: http://yoursite.com  # 站点网址
root: /                   # 网站根目录
permalink: :year/:month/:day/:title/ #文单的永久链接格式
permalink_defaults:       # 永久链接中各部分的默认值

# 目录
source_dir: source        # 资源文件夹，这个文件夹用来存放博客内容
public_dir: public        # 公共文件夹，这个文件夹用来存放生成的站点静态文件
tag_dir: tags             # 标签文件夹
archive_dir: archives     # 归档文件夹
category_dir: categories  # 分类文件夹
code_dir: downloads/code  # Include code文件夹
i18n_dir: :lang           # 国际化文件夹，存放各种语言定义
skip_render:              # 跳过指定文件的渲染

# 写作
new_post_name: :title.md  # 新文章的文件名称
default_layout: post      # 预设布局
titlecase: false          # 把标题转换为 title case
external_link: true       # 在新标签中打开链接
filename_case: 0          # 把文件名称转换为 (1) 小写或 (2) 大写
render_drafts: false      # 显示草稿
post_asset_folder: false  # 启动 Asset 文件夹
relative_link: false      # 把链接改为与根目录的相对位址
future: true              # 显示未来的文章
highlight:                # 代码块的设置
  enable: true
  line_number: true
  auto_detect: false
  tab_replace:

# 分类 & 标签
default_category: uncategorized  # 默认分类
category_map:                    # 分类别名
tag_map:                         # 标签别名

# 日期 / 时间格式
## Hexo 使用 Moment.js 来解析和显示时间
## http://momentjs.com/docs/#/displaying/format/
date_format: YYYY-MM-DD # 日期格式
time_format: HH:mm:ss   # 时间格式

# 分页
## 每页显示的文章量 (0 = 关闭分页功能)
per_page: 10
pagination_dir: page

# 扩展
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
theme: landscape       # 主题

# 部署
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type:
```

{% endfold  %}

### Wikitten主题

具体配置参考[开发者说明](https://github.com/zthxxx/hexo-theme-Wikitten/blob/master/README_zh-CN.md)，更详细的描述参阅[hexo-theme-icarus](https://github.com/ppoffice/hexo-theme-icarus/wiki)。为了与主题Next不冲突，作以下修改。

1. 自行修改 `tags`, `about`,`categories` 等`index.md`，而不能从主题复制，覆盖站点原有设置。
2. `languages\zh-CN.yml` 重命名为 `zh-Hans.yml`
3. `_config.yml` 菜单作以下更改

```ini
menu:
  首页: /
  归档: /archives/
  分类: /categories/
  标签: /tags/
  关于: /about/
```

4. `thumbnail: true` 使得每个post在快速列表里，显示图标。但就是每个帖子都要设定，很麻烦。
5. post 中的 toc 要设置为 true，如果需要显示目录的话。

### 同时部署两个项目

第一个项目使用 Github 上面默认的 Github Pages，即 `username.github.io` 。在站点配置文件中如下：

```
url: http://username.github.io
root: /
...
...
deploy:
  type: git
  repository: git@github.com:username/username.github.io.git
  branch: master

```


第二个站点开通一个 普通的repository，添加名为`gh-pages` 的Branch，并将gh-pages` 设为默认Branch。我将第二个仓库命名为 wiki ，那第二个站点就运行在 `https://username.github.io/wiki`次级目录下面。

站点配置文件更改如下：

```
url: http://username.github.io/wiki
root: /wiki/
...
...
deploy:
  type: git
  repository: git@github.com:username/wiki.git
  branch: gh-pages
```

同样用 `hexo d -g` 部署命令发布，两个站点就都运行起来了。

为了使得两个项目使用同一个笔记资源，将站点中的 source 文件夹移到项目意外，将配置文件里的 `source_dir: source` 改为 `source_dir: ../source`(这里使用了相对目录)。

[参考文章][multipages] (细节已经失效，但思路值得参考)

### 站内搜索

1. 安装插件

```shell
npm install hexo-generator-search --save
npm install hexo-generator-searchdb --save
```

2. 配置hexo站点主配置文件``_config.yml``， 添加

```ini
search:
    path: search.xml
    field: post
    format: html
    limit: 10000
```

3. 修改next主题配置文件`_config.yml`，启用 `local_search`

```ini
local_search:
	enable: true
	trigger: auto
	top_n_per_article: 1
```

4. 生成`search.xml`文件以及发布

```shell
hexo g
hexo d -g # 本地运行 hexo s
```

### 去除主题字样

关于添加头像、标签、分类、「关于」等具体的修改，跟着参考资料[^2]里面的步骤做就好了。最后说说如何去掉底部强力驱动及主题字样。

1. 找到 `\themes\next\layout_partials\`下面的`footer.swig`文件，打开：

```html
<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" href="https://hexo.io">Hexo</a>') }}
</div>
<div class="theme-info">
  {{ __('footer.theme') }} -
  <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
    NexT.{{ theme.scheme }}
  </a>
</div>
```

第一条是“由Hexo驱动” 的Hexo链接，把xml段删除，只留两个单引号''。

第二条是“主题-Next.XX”，将xml段都删掉，不留引号。

```html
<div class="powered-by">
  {{ __('footer.powered', '') }}
</div>
<div class="theme-info">
  {{ __('footer.theme') }}
</div>
```

2. 找到这个地方`\themes\next\languages\ `下面的语言文件`zh-Hans.yml`（以中文为例）：

```ini
footer:
  powered: "由 %s 强力驱动"
  theme: 主题
```

将上面的文字改成自己想要的即可。

## 添加评论功能

####  Gitment

**此项目已经终止！**改为Disqus，以及其它评论服务。

1. 安装功能模块。在项目的根目录：

```shell
npm i --save gitment
```

2. 在Github申请应用。`settings -> Developer Settings -> OAuth Apps`

```ini
Application name:随便写
Homepage URL:这个也可以随意写,就写你的博客地址就行
Application description:描述,也可以随意写
Authorization callback URL:这个必须写你的博客地址
```

申请好之后点注册,然后就可以看到两个东西`ClientID`和`Client Secret`,后面会用到。

3. 配置Gitment，打开`themes/next/_config.yml`:

```javascript
# Gitment
# Introduction: https://imsun.net/posts/gitment-introduction/
gitment:
  enable: true
  mint: true # RECOMMEND, A mint on Gitment, to support count, language and proxy_gateway
  count: true # Show comments count in post meta area
  lazy: false # Comments lazy loading with a button
  cleanly: false # Hide 'Powered by ...' on footer, and more
  language: # Force language, or auto switch by theme
  github_user: {you github user id}
  github_repo: 随便写一个你的公开的git仓库就行,到时候评论会作为那个项目的issue
  client_id: {刚才申请的ClientID}
  client_secret: {刚才申请的Client Secret}
  proxy_gateway: # Address of api proxy, See: https://github.com/aimingoo/intersect
  redirect_protocol: # Protocol of redirect_uri with force_redirect_protocol when mint enabled
```

注意到这里基本上已经OK了,再看你的博客应该可以显示评论了.不过每篇博客都需要你手动初始化评论功能(如果你的历史博客很多那就一篇一篇去点吧，不过貌似有人写了批量处理脚本,没试过哈).

而由于 github 中 `Issues` 的 `label` 长度限制为最大 `50` 个字符，当 文章标题长度过长时，该label就会生成失败，而导致初始化错误，弹出 `Validation Failed` 的提示。

通过网上的搜索，发现可以使用文章创建时的时间来代替文章标题，作为这个唯一的label标签。

找到giment的配置：`/themes/next/layout/_third-party/comments/gitment.swig` 文件， 并找到如下部分：

```javascript
var gitment = new {{CommentsClass}}({
    id: window.location.pathname,
    owner: '{{ theme.gitment.github_user }}',
    repo: '{{ theme.gitment.github_repo }}',
    ...
```

将`id`后面的路径值修改为 'itfanr\_blog\_\{{ date(page.date, "YYYYMMDDhhmmss") \}}' 就可以了。

#### Disqus

目前只开通[Disqus](https://disqus.com/)的评论。

1. 开通Disqus账号，并添加一个点 应用。具体步骤参看[Hexo搭建博客系列：（六）Hexo添加Disqus评论](https://www.jianshu.com/p/d68de067ea74)。
2. 在`主题配置文件`(_config.yml)文件中找到以下代码，添加你Disqus设置的Website Name在shortname。

```json
# Disqus
disqus:
  enable: true
  shortname: tian-ya-de-zhi-fu
  count: true
```

更详细请参阅网上。



## 新文章命名规则

发表新文章后系统崩溃。

在根目录的配置文件中找到类似的：

```
# Writing
new_post_name: 新文章.md # File name of new posts
default_layout: post
...
```

将其改为由时间和题目组成：<span id="id_new_post_name"></span>

```
# Writing
new_post_name: year-:month-:day-:title.md # File name of new posts
default_layout: post
...
```



# 进阶设置

## 显示

### 首页文章显示预览

默认设定下。首页的文章每一篇都显示全文，不方便浏览。需要到主题的配置文件里将`auto_excerpt` 的 `enable` 改为 `true`。而`length` 字节表示文章预览的长度。

```
# Automatically Excerpt. Not recommand.
auto_excerpt:
	enable: true
	length: 300
```

### 永久链接

新文章的名字采用了中文([见上](#id_new_post_name))，中文出现在地址栏上不美观。也不利于SEO，以及增加了博文URL的层数。解决办法是给每篇文章制定链接地址。

1. 修改网站的配置文件中永久地址的设定：

```ini
permalink: :urlname.html
```

2. 给每篇文章指定 `urlname`

```ini
title: 《少有人走的路》笔记
date: 2019-07-21 00:14:37
urlname: road-less-traveled-summary
tags:
  - 心理学
categories: 读书笔记
```

编译后新的地址为 `http://mywiki.test/road-less-traveled-summary.html`。看起来就清爽多了。

### 图片链接

1. 开通[资源文件夹](https://hexo.io/zh-cn/docs/asset-folders)，创建新文章的时候会自动建立一个与文章同名的文件夹。可以将图片或者其它资源文件放到里面（*打算将思维导图放到这里*）。因为自定义了[文件名的方式](#id_new_post_name)，所以根据官方描述无效。
2. 安装第三方插件`hexo-asset-image`

```bash
npm install hexo-asset-image --save
```

在文章中图片的链，可以省略路径，直接引用图片名：

```markdown
![mypicture](mypicture.jpg)
```

3. 修改插件代码

我在使用永久链接的时候在每篇文章的实际地址都加上了`.html`。文章的地址显示如下

```http
http://mywebsite.com/my-articel-url.html
```

而插件生成的图片地址如下：

```
http://mywebsite.com/my-articel-url.htm/mypicture.jpg
```

多出了 `.htm` 这几个字符，而实际图片的地址应该是：

```http
http://mywebsite.com/my-articel-url/mypicture.jpg
```

找到 `node_modules/hexo-asset-imge` 目录下的 `index.js` 文件，将以下代码中的 `1` 改成 `5`，就可以正常显示图片了。

```javascript
var endPos = link.length - 1
```

考虑到将来项目膨胀，应该将图片放到图床，比如七牛。

### 站内链接

导航到站内别的文章使用以下方式就可以。

链接方式 `[文章名](urlname.html)`



### 设定代码区的高度

Hexo自身的式样暂时还没找到。其实也不太需要。如果代码不长直接显示全部就好了。太长的话不如放到$Gits$，通过限制gist的高度实现。**Net**主题修改 `next/themes/next/source/css/_custom/custom.styl` ，Wikitten主题则在文件 `wikitten/themes/Wikitten/source/css/_partial/article.styl` 中修改。

```CSS
.gist 
.gist-file
.gist-data {
    max-height: 450px;
}
```



### 添加注脚支持

[插件项目](https://github.com/LouisBarranqueiro/hexo-footnotes)

1. 安装插件 `npm install hexo-footnotes --save`
2. **项目配置文件** 添加

```ini
# 注意第二行的前面没有 "-" 符号,官方说明有. 但是会导致无法编译.
plugins:
  hexo-footnotes
```



###  更换Markdown渲染

[Markdown-it-plus](https://github.com/CHENXCHEN/hexo-renderer-markdown-it-plus)

如果更换了这个渲染,就无需上面那个注脚插件, 因为已经支持了. 首先卸载掉旧的渲染, 然后安装新的.

```sh
npm un hexo-renderer-marked --save
npm i hexo-renderer-markdown-it-plus --save
# 查看是否已经安装
npm ls hexo-renderer-markdown-it-plus
```

然后在项目配置文件, 添加下面文字. 更深入的设置, 参看 markdown-it-plus 项目的说明文档.

```ini
markdown_it_plus:
    highlight: true
    html: true
    xhtmlOut: true
    breaks: true
    langPrefix:
    linkify: true
    typographer:
    quotes: “”‘’
    plugins:
```



## 辅助功能

### 本地运行服务

在Mac中可以用本地服务[Pow](http://pow.cx)运行网站，不用每次更改重启服务器`hexo s`。

1. 安装Pow

```bash
$ curl get.pow.cx | sh
```

2. 建立项目链接，`myapp` 是项目的名字。比如真实路径`~/Project/mywiki`

```bash
$ cd ~/.pow
$ ln -s /path/to/myapp
```

3. 执行完以上步骤后在浏览器打开链接 ``http://myapp.test/`` 就能看到网站。更改内容后要执行==生成== 命令才能看到更新`hexo generate` or `hexo g` 。
4. 不想运行，直接把项目文件夹删除就可以。

### 绑定个人域名

1. 在万网买一个顶级域名，开通后添加两个域名解释

```ini
#记录名  主机记录  记录值
CNAME    www    username.github.io
CNAME     @     username.github.io
```

2. 在项目的根目录添加一个名为 `CNAME` 的文件，然后填入万网注册的域名， 这里是 `goldentianya.pub` 。第一次我是手动添加的。添加后进入 repository 的 setting， 往下混动到 Custom domain ，可以看到系统已经自动把用户域名加进去了。
3. 将来不希望用这个域名，域名重定向后，在浏览器输入 username.github.io 后 Chrome 会一直转向 goldentianya.pub 。需要打开`开发者工具`，选中 `disable cache` ，再刷新一遍地址就好了。
4. `next` 项目要将 `CNAME` 文件复制到 `/themes/next/source` 目录下个，编译的时候会拷贝到 `public` 目录。`wikitten` 项目不需要，域名定向以后能找到 `goldentianya/wiki` 站点，十分神奇。

### 隐藏文章

#### 全隐藏

根据插件`hext-sage-posts` 作者的博文[^9]中描述，安装插件

```bash
npm install hexo-sage-posts --save
```

并将初创时的`Hello-world.md` 文章的Metadata中加入`sage: true`，文章就从网站上消失了。但在别的文章下面导航栏中，通过“下一篇”或者“上一篇”还是能被找到。被隐藏的文章其地址仍旧没有改变，只是不不出现在首页导航，和分类中而已。

#### 从首页隐藏

为了不让太琐碎的文章充斥首页，但又可以在分类中找到。可以采用这种方式。

1. 在文章的Metadata部分添加关键字 `notshow: true`。
2. 找到 `Hexo\themes\next\layout\index.swig` 文件中以下部分：

```html
{% block content %}
  <section id="posts" class="posts-expand">
    {% for post in page.posts %}
        {{ post_template.render(post, true) }} <!--修改此行-->
    {% endfor %}
  </section>

  {% include '_partials/pagination.swig' %}
{% endblock %}
```

将以上代码第四行修改为

```html
{% if post.notshow != true %}
	{{ post_template.render(post, true) }}
{% endif %}
```



#### 文章加密

1. 安装插件 `hexo-blog-encrypt`

```
npm install --save hexo-blog-encrypt
```

并在**站点配置**文件中启用该插件：

```json
encrypt:
    enable: true
```

2. 然后在文章的头部添加上对应的字段

```ini
---
title: 文章加密
date: 2019-01-04T22:20:13.000Z
category: 教程
tags:
  - 博客
  - Hexo
keywords: 博客文章密码
password: TloveY
abstract: 此文章含有敏感内容。
message:  输入密码，查看文章
---
```

- password: 是该博客加密使用的密码

- abstract: 是该博客的摘要，会显示在博客的列表页

- message: 这个是博客查看时，密码输入框上面的描述性文字



### Hexo Admin

安装后台管理插件 `hexo-damin`

```bash
npm install --save hexo-admin
hexo server -d
open http://localhost:4000/admin/
```

初次运行后，设置管理账户。

```
admin:
  username: maiernte
  password_hash: $2a$10$QeeWfDwIxbJ94h8EDfplDe9aLB0uaNrjMeVGhaYnfF0BBDosDze0S
  secret: NamoAmitabha!
```

### 访问量统计

[介绍文章](https://bjtu-hxs.github.io/2018/06/12/leancloud-config/)   （*有图*）

[原文（有代码）](https://notes.doublemine.me/2015-10-21-%E4%B8%BANexT%E4%B8%BB%E9%A2%98%E6%B7%BB%E5%8A%A0%E6%96%87%E7%AB%A0%E9%98%85%E8%AF%BB%E9%87%8F%E7%BB%9F%E8%AE%A1%E5%8A%9F%E8%83%BD.html#%E9%85%8D%E7%BD%AELeanCloud)

1. 第一步， 到Lean Cloud增添一个应用，并创建类似Counter 的类。设置成 $ 所有人可读可写 $
2. 在安全中心添加 **Web 安全域名**， 添加Blog域名，防止有人Hack我们的数据库。

3. 按上面的文章修改 Hexo 以及主题配置。



### 在线交流

使用 [道客](https://www.daovoice.io/)  Daovoice

接入方式

1. 将下面代码粘贴在页面的 </head> 之前。

```
<script>(function(i,s,o,g,r,a,m){i["DaoVoiceObject"]=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;a.charset="utf-8";m.parentNode.insertBefore(a,m)})(window,document,"script",('https:' == document.location.protocol ? 'https:' : 'http:') + "//widget.daovoice.io/widget/5e5fa370.js","daovoice")</script>
```

2. 调用下面的 JavaScript 与注册用户沟通

```
daovoice('init', {
  app_id: "5e5fa370",
  user_id: "NO_89757", // 必填: 该用户在您系统上的唯一ID
  email: "daovoice@example.com", // 选填:  该用户在您系统上的主邮箱
  name: "道客船长", // 选填: 用户名
  signed_up: 1449821660 // 选填: 用户的注册时间，用Unix时间戳表示
});
daovoice('update');
```

3. 调用下面的 JavaScript 与匿名访客沟通

```
daovoice('init', {
  app_id: "5e5fa370"
});
daovoice('update');
```

完成代码粘贴后,检测是否成功接入: Ping 一下



### 待解决问题

- [x] 文章评论
- [x] 在线编辑？
- [x] 使用七牛图床
- [ ] 脑图摆放 ([官方文档/数据文件](https://hexo.io/zh-cn/docs/data-files))
- [x] 文件下载（可能还是要靠七牛）
- [x] 用submodule管理主题 [在 hexo 中使用 git submodules 管理主题](https://juejin.im/post/5c2e22fcf265da615d72c596)
- [ ] SEO
- [ ] 访问量统计
- [ ] 加速 [Github Pages + CDN全站加速](https://www.jianshu.com/p/ccc0cc8c14a0)

- [ ] [在vps上部署hexo博客的那些事](https://segmentfault.com/a/1190000019104144)

# 有趣插件

- [x] [短地址 & 指定摘要](https://www.jianshu.com/p/805bd0b65d98) 

- [ ] [农历/很好的学习做插件的例子](https://github.com/inchei/hexo-lunar-calendar)

- [ ] [插入pdf](https://github.com/superalsrk/hexo-pdf/) 可以学习如何插入epub

- [ ] [hexo-include](https://github.com/pirtleshell/hexo-include) 加载文本内容， html, js, text

- [x] [Hexo-NexT给文章添加结束语](https://wangc1993.github.io/2019/01/10/6/)

- [x] [Hexo-NexT接入网页在线联系功能](https://wangc1993.github.io/2019/01/10/5/)

- [ ] [include markdown](https://github.com/tea3/hexo-include-markdown)



###  ---



[^1]: [Hexo博客搭建全攻略(一):基于Hexo+Github环境搭建](https://blog.annieyu.com/posts/207737771.html)
[^2]: [Hexo博客搭建全攻略(二):NexT主题配置](https://blog.annieyu.com/posts/976961586.html)
[^3]: [Hexo博客搭建全攻略(三):三方服务集成](https://blog.annieyu.com/posts/1209152972.html)
[^4]: [Hexo博客搭建全攻略(四):高级应用](https://blog.annieyu.com/posts/3333782006.html)
[^5]: [Hexo博客搭建全攻略(五):基于Github Issue搭建评论系统](https://blog.annieyu.com/posts/a341668e.html)
[^6]: [Hexo博客搭建全攻略(六):博文图片处理](https://www.jianshu.com/p/2bb87ae49ff6)
[^7]: [十步之内轻松搞定 Hexo + GitHub搭建个人博客](https://gavinlee1.github.io/2017/02/25/%E5%8D%81%E6%AD%A5%E4%B9%8B%E5%86%85%E8%BD%BB%E6%9D%BE%E6%90%9E%E5%AE%9A-Hexo-GitHub%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2/) ​​
[^8]: [如何优雅的 隐藏博客](https://vanchchen.github.io/p/7587.html)
[^9]: [为 Hexo 博客添加隐藏文章 / 限定公开功能](https://blessing.studio/hexo-plugin-to-make-posts-sage-unlisted/)
[^10]: [Hexo 中文文档](https://hexo.io/zh-cn/docs/index.html)

[multipages]: ttp://chitanda.me/2015/11/03/multiple-git-pages-in-one-github-account/

[讲解详细的博客](https://binglumeng.github.io/2017/03/21/Hexo学习笔记/) 

[这个也不错](http://yearito.cn/posts/hexo-advanced-settings.html)


