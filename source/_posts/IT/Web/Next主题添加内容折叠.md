---
title: Next以及wikitten主题添加内容折叠
date: 2019-07-23 20:29:33
urlname: next-collapse-block
toc: true
tags: [Hexo]
categories: [IT,  Web]

---

# 添加代码

当有大段的代码直接展示在页面时，看起来臃肿且不便于观看，此时将代码折叠式最好的选择。下面是在Hexo的Next主题上添加折叠功能。

<!-- more -->

## 在main.js中添加折叠js

Next主题的主要js位于 `themes/next/source/js/src/post-details.js`,在下面添加一下代码段：

```javascript
$(document).ready(function(){
    $(document).on('click', '.fold_hider', function(){
        $('>.fold', this.parentNode).slideToggle();
        $('>:first', this).toggleClass('open');
    });
    //默认情况下折叠
    $("div.fold").css("display","none");
});
```

Wikitten 主题添加到 `themes/wikitten/source/js/main.js` 后面。

## 自定义内建标签

在主题scripts下添加一个tags.js，位于`themes/next/scripts/tags.js`

```javascript
/*
  @haohuawu
  修复 Nunjucks 的 tag 里写 ```代码块```，最终都会渲染成 undefined 的问题
  https://github.com/hexojs/hexo/issues/2400
*/
const rEscapeContent = /<escape(?:[^>]*)>([\s\S]*?)<\/escape>/g;
const placeholder = '\uFFFD';
const rPlaceholder = /(?:<|&lt;)\!--\uFFFD(\d+)--(?:>|&gt;)/g;
const cache = [];
function escapeContent(str) {
  return '<!--' + placeholder + (cache.push(str) - 1) + '-->';
}
hexo.extend.filter.register('before_post_render', function(data) {
  data.content = data.content.replace(rEscapeContent, function(match, content) {
    return escapeContent(content);
  });
  return data;
});
hexo.extend.filter.register('after_post_render', function(data) {
  data.content = data.content.replace(rPlaceholder, function() {
    return cache[arguments[1]];
  });
  return data;
});
```

再继续添加一个fold.js,位于`themes/next/scripts/fold.js`



```javascript
/* global hexo */
// Usage: {% fold ???? %} Something {% endfold %}
function fold (args, content) {
    var text = args[0];
    if(!text) text = "点击显/隐";
    return '<div><div class="fold_hider"><div class="close hider_title">' + text + '</div></div><div class="fold">\n' + hexo.render.renderSync({text: content, engine: 'markdown'}) + '\n</div></div>';
}
hexo.extend.tag.register('fold', fold, {ends: true});
```

wikitten主题将这两个文件复制到 `themes/wikitten/scripts` 目录下。

## 添加自定义样式

位于`themes/next/source/css/_custom/custom.styl`

```css
.hider_title{
    font-family: "Microsoft Yahei";
    cursor: pointer;
    color: red;
}
.close:after{
    content: "▼";
}
.open:after{
    content: "▲";
}
```

wikitten 主题将此代码添加到 `themes/wikitten/source/css/_partial/article.styl` 文件下面。在`next` 主题必须将==color: red==去掉，否则会影响大纲栏的颜色。

## 使用

在我们需要折叠的地方前后添加便签，示例用法：

```
{% fold 点击显/隐内容 %}
需要隐藏的内容。。。
{% endfold %}
```



## 参考

[Hexo next博客添加折叠块功能添加折叠代码块](https://blog.rmiao.top/hexo-fold-block/) 
[Next主题实现内容折叠](http://zlingfly.com/2018/09/05/fold-test/) 
[jQuery 实现内容折叠功能](https://www.oyohyee.com/post/Note/fold/)

[Hexo 标签插件 官方](https://hexo.io/zh-cn/docs/tag-plugins.html)

# 实例

## 嵌套代码

Some Content

{% fold 点击显/隐内容 %}
{% blockquote Mai, Düsseldorf link http://google.de %}

<xsl:call-template name="SetGlobaleVariable">
	<xsl:with-param name="name-variable">po_bfa_swbh_laufbahn</xsl:with-param>
	<xsl:with-param name="wert-variable" select="$bf_laufbahnzulage"/>
\</xsl:call-template>

{% endblockquote %}
{% endfold %}

## Hexo 代码方式

{% blockquote David, Levithan %}
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque hendrerit lacus ut purus iaculis feugiat. Sed nec tempor elit, quis aliquam neque. Curabitur sed diam eget dolor fermentum semper at eu lorem.
{% endblockquote %}

{% codeblock KOS xsl http://google.de downloadcode %}
1 code snippet
{% endcodeblock %}

## Gist

### Hexo 方式

Gist ("48edcb5cfd92937ae61360b74852d4e1" 就是id。 而 "xml" 是我创建时的文件名)。地址是 git.github.com

{% gist 48edcb5cfd92937ae61360b74852d4e1 xml %}

<br>

### Javascript 方式

<script src="https://gist.github.com/maiernte/48edcb5cfd92937ae61360b74852d4e1.js"></script>

