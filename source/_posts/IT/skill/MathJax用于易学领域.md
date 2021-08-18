---
title: MathJax用于易学领域
date: 2019-08-30 10:15:28
urlname: mathjax-yixue-usage
toc: true
tags: [工具]
categories: [IT, skill]
mathjax: true
---

关于利用 `MathJax` 和 `Katex` 数学公式解释器，实现易学上排六爻盘和八字盘个功能。今天实现了易学上的核心功能。有望将来能添加更多的函数，以便利各位同门以及广大易友。


<!--more-->
### 效果与演示

<iframe width="560" height="315" src="https://www.youtube.com/embed/1bSesbpk23w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
无法观看油管的朋友请移步B站：[使用MathJax渲染六爻和八字盘](https://www.bilibili.com/video/av66317810/)




###  <a name="install">安装和使用</a>

首先，你需要一个支持 Markdown (简称MD) 语言格式的文本编辑器。如果不知道什么是MD的话，请参阅以下介绍：

- [Markdown介绍及使用教程](https://www.jianshu.com/p/7771794c88a1)

- [Markdown - 简单的世界](https://wizardforcel.gitbooks.io/markdown-simple-world/index.html)

- [认识与入门 Markdown](https://sspai.com/post/25137)



Markdown 语言**简约而优美**，可以自由转换成pdf、word、Html 等等各种其它格式的文本。可以推送到博客、微信公众号等等。虽然算卦是一个传统的行业，我们仍然不宜**固步自封**。MD语言支持MathJax和Katex书写Latex数学公式，可以写出非常漂亮的数学、物理、化学方面的公式。正式的科技刊物都要求用Latex格式。



这个易学解决方案是对 MathJax 进行扩展，加入指定的易学公式，让 MathJax 解释器去完成公式渲染。它并不是一个独立的程序。需要构建在已有的MD文本编辑器之上。我使用一个文件夹存放所有的关于易学方面的MD文件，并将这个文件夹同步到 [坚果云](https://www.jianguoyun.com/#/)，这样就可以实现多台电脑和移动端之间的同步，而不太需要一个独立的易学软件。甚至可以将MD文件导出为HTML文件，放到我的HEXO博客上(您正在阅读的这篇博文即是例子)。



理论上所有支持Markdown语言和MathJax的文本编辑器，都可以改装。改装过程需要两段代码和一个库文件。

#### 文本编辑器

##### Typora 

Typora 是我个人最钟爱的MD编辑器，因此这里着重介绍。如果你喜欢用别的MD编辑器，比如iAWrte等，理论上可以用同样的方式改装。(无法百分百保证) 有需要的朋友可以私下联系我。

最新的安装教程请参考[华鹤易学平台文档](https://maiernte.gitee.io/huahedocument/chapter6/libinstall.html)

#####  VSCode

同样请移步[华鹤易学平台文档](https://maiernte.gitee.io/huahedocument/chapter6/libinstall.html)。那里有详细描述。



#### Hexo博客

🔔 注意：首先要检查自己的 Hexo 博客使用的渲染器是否默认开启了Katex或者MathJax数学插件。如果有的话需要卸载或者禁用数学插件，如果不能禁用，就必须更换Markdown渲染器。

> 因为系统使用的数学插件会在网页生成之前就改动数学表达，这样无法使用我提供给的函数库。我提供给博客的方案是在浏览网页的时候，即时渲染易学公式。

比如我之前用了 "hexo-renderer-markdown-it-plus" 渲染器就是强制使用 Katex 数学渲染的。

```shell
npm un hexo-renderer-markdown-it-plus --save // 卸载
npm i  hexo-renderer-markdown-it      --save // 更换
```

然后将下列代码添加到文件模版就可以了。使用 swig 模版的是在 `<your thems>/layout/_custom/header.swig` 或者 `<your thems>/layout/index.swig` 。而使用 ejs 模版的是文件 `<your thems>/layout/layout.ejs`

```html
<!--前三行最好添加到 <header></header> 头区块中-->

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.11.0/dist/katex.min.css" >
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.11.0/dist/katex.min.js" ></script>
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.11.0/dist/contrib/auto-render.min.js"></script>


<script src="https://raw.githack.com/maiernte/img/master/libs/katexYixue.js"></script>
<script src="https://raw.githack.com/maiernte/img/master/libs/bundle.js"></script>

```

> 注意搜索 _config.yml 文件，"math", "katex", "mathjax" 等字样，发现有的话把他们禁用。



#### Gitbook

最新的安装教程请参考[华鹤易学平台文档](https://maiernte.gitee.io/huahedocument/chapter6/libinstall.html)



### API 参数

使用易学函数库非常简单，在经过改装的Markdown编辑器中，输入易学公式，并用两个 `$` 符号将公式前后围起来即可。MD语言一般默认两个 `$` 符号之间的文本是数学公式，它会调用MathJax对公式进行渲染。否则，它会认为这是普通文本，而不会做任何动作。

#### 易学通用

<a name="nayin">**命令：纳音**</a> `\nayin{干支名称}`

【干支名称】 ：就是甲子、己卯等六十甲子。

例子1：`\nayin{戊午}` --> $\nayin{戊午}$

<a name="nayin">**命令：干支日历**</a> `\timegz{时间参数}{年月日}`

【时间参数】 ：例如 2020-02-21。

【年月日】 ：省略时默认为`111`，即显示年月日。`0`表示不显示，`1`表示显示。

例子1：`\timegz{2020-02-21}` --> $\timegz{2020-02-21}$

例子2：`\timegz{2020-02-21}{011}` --> $\timegz{2020-02-21}{011}$


#### 六爻

<a name="yao">**命令：爻符**</a> `\yao{爻名}`

【爻名】：laoyin， laoyang，shaoyin，shaoyang， x， o， =， -， 交，重，阴，阳，0，1，2，3

例子2：`\yao{x}`  --> $\yao{x}$

例子3：`\yao{shaoyin}` --> $\yao{shaoyin}$

例子4：`\yao{重}` --> $\yao{重}$



<a name="paigua"> **命令：六爻排盘**</a> `\paigua{时令}{卦辞}{标识}`

其中 【时令】、【卦辞】这两个参数是必须的，**【标识】**参数可以省略。

【时令】允许的格式为：“1980-1-3 08:15”、“2019年3月4日”、“申月戊寅日”

【卦辞】允许的格式为：“解之师”、“离为火”、“--==x-”、“0121100”、“阴阳阴交阴阳”

【标识】由三部分组成：ID号、简排、字符大小。格式为：`guadi/s/5`

- 「ID号」：随便一串字符，空白则默认为“gua1”。:x:不允许只有数字，因为会与参数「字符大小」混淆。如果一个文本出现多个六爻卦，则每个卦都需要指定一个ID号。否则下面的命令[卦爻细节](#guayao)不知道具体指向哪一个卦本。
- 「简排」：只允许`s` 和 `l`两个英文字符的其中一个。`s` 表示只显示短名，如“妻财”显示为“财”，“青龙”显示为“龙”。`l` 则显示完整名称。留白则按照用户全局设定来显示。（参阅[用户设定](#code2)）
- 「字符大小」：允许 0 - 9 档。数字越大文字越大。默认大小为`5`或者用户的[全局设定](#code2)。

例子5： `$\paigua{1978年7月1日}{101201}{gua1}$` 效果
$$\paigua{1978年7月1日}{101201}{gua1}$$

:pencil2: 如果文章很长，需要在指定位置重新显示一遍卦本，则可以使用重排命令。即让【时令】和【卦辞】两个参数留白，只给出【ID号】。如 `\paigua{}{}{gua1}` 。留白的参数，仍然需要用大括号括起来，否则解释器会出错。



<a name="guayao"> **命令：卦爻细节**</a> `\guayao{标识}{位置}`

使用前提：当前文本中已经排出至少一支六爻卦。

【标识】：与排盘命令的「标识」参数等同。由ID号、简排、字符大小三个部分组成。其中「ID号」标识已经存在的六爻盘。

【位置】：格式为 “ben1”、“fu3”、“bian5” 等，分别表示「本卦初爻」、「伏卦3爻」、「变卦5爻」



例子6：`\guayao{gua1}{ben4}` --> $\guayao{gua1}{ben4}$

> 例子6 中给出的「ID号」为例子5中指定的ID号 “gua1”，并要求显示本卦4爻的具体信息。



#### 八字

<a name="paibazi"> **命令：八字排盘**</a> `\paibazi{时间}{性别}{标识}[细节]`

【时间】和【性别】参数必填，【标识】和【细节】参数可选。(如果要第二次显示已有的八字盘，则【时间】和【性别】参数可留白，只给定【标识】参数中的「ID号」)

【时间】：允许格式 “1980-1-3 08:15”、“2019年3月4日 6时3分” 

【性别】：允许格式 “m”、“f”、“男”、“女”、“乾”、“坤”、

【标识】：与排盘命令的「标识」参数等同。由ID号、简排、字符大小三个部分组成。

【细节】：允许“藏干”、“长生”、“纳音”这三个中的一个或者多个，也可以留白。格式为 `藏干/纳音/长生`

例子7：`\paibazi{1990年5月1日 6:45}{男}{小明/s/5}`

$\paibazi{1990年5月1日 6:45}{男}{小明/5}$

例子8：重排例子7的八字盘 `\paibazi{}{}{小明/s/5}[纳音/藏干/长生]` ，并要求显示藏干和纳音等信息。

$\paibazi{}{}{小明/s/5}[纳音/藏干/长生]$



<a name="bazi"> **命令：八字细节**</a> `\bazi{标识}{类别}[细节]`

使用前提：当前文本中已经排出至少一个八字盘。

【标识】：与排盘命令的「标识」参数等同。由ID号、简排、字符大小三个部分组成。其中「ID号」标识已经存在的八字命盘。

【类别】：支持 “神煞”、“大运”、“流年”、“小运” 四个选项。

【细节】：具体含义视【类别】而定。

- 类别为「神煞」时：「细节」为 1～ 9 的数字，表示每行列数。
- 类别为「大运」时：` 1-9 纳音/藏干/长生/神煞` 前面的数字表示第几步大运，限定 1 到 10
- 类别为「流年」和「小运」时： `2015 - 2019 纳音/藏干/长生/神煞` 前面的数字表示年份，注意不要超过命盘的生命周期，否则会出错。「纳音/藏干/长生/神煞」可以留白，也可只显示一两项。



例子9:  `\bazi{小明}{神煞}[6]` 显示小明命盘的神煞，每行6列。

$\bazi{小明}{神煞}[6]$



例子10: `\bazi{小明}{大运}[2-3 ]` 显示小明的第二到第三步大运

$\bazi{小明}{大运}[2-3]$



例子11:  `\bazi{小明}{流年}[2017-2019 纳音/藏干/长生/神煞]` 显示小明的2017到2019年的流年信息。

$\bazi{小明}{流年}[2017-2019 纳音/藏干/长生/神煞]$



### 未来与展望

我知道这篇文章介绍的工具，并非所有人都能使用。所以在不久的将来，还是要制作一个独立易学软件，以便易友在PC端和移动端都能按照传统的方式使用。但由于时间和精力原因，我无法保证完成时间。



不断完善易学函数，提供更丰富的应用细节。在用户更为广泛的MD编辑器中实现此方式。比如有道云笔记、为知笔记、印象笔记等。并争取介绍移动端(Android & iOS)实现此方式。也希望在Gitbook中实现。



希望能将师父的六爻和八字讲义，『增删卜易』等著作制作成Gitbook，将精彩的卦例和名人八字建成易学数据库。这样就可以通过我的易学函数直接获取， 比如 `\paibazi{蒋介石}`。



### 附录: 

#### 命令列表

[纳音](#nayin)

[爻符](#yao)

[排卦](#paigua)

[卦爻细节](#guayao)

[排八字](#paibazi)

[八字细节](#bazi)

#### 发布

脚本文件的[原始路径](https://github.com/maiernte/img/raw/master/libs/bundle.js)是`https://github.com/maiernte/img/raw/master/libs/bundle.js`。因为涉及到跨域问题，要通过 [Gitkack](https://raw.githack.com/) 重链接，把上述路径输入到 Githack 的地址框，会得到「应用地址」和「开发地址」。

[应用地址](https://rawcdn.githack.com/maiernte/img/bb3c42dc26b0866a142bb905d1753ac483e0a474/libs/bundle.js)：

`https://rawcdn.githack.com/maiernte/img/11a1bb572a6875dbf434a7fc457ea2fdd329f7db/libs/bundle.js`

[开发地址](https://raw.githack.com/maiernte/img/master/libs/bundle.js)：

`https://raw.githack.com/maiernte/img/master/libs/bundle.js`

#### 查看当前易学函数库版本

在 chrome 浏览其中打开此博文，Mac 系统中按 `⌘+⌥+I` ，Windows 系统 `Ctr+⇧+I`，或者 Chrome 菜单栏调出 “开发者工具”，选择 Console 页面，即可显示当前易学库版本和时间。