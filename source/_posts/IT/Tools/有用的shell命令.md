---
title: 有用的Shell命令
date: 2019-07-30 17:30:28
urlname: helpfull-shell-command
toc: true
tags: [工具]
categories: [IT, Tools]
notshow: true
---

在线网站可以找到基本的东西：[Linux命令大全](https://man.linuxde.net/)  [shell 正则表达式](https://man.linuxde.net/docs/shell_regex.html)

# 文件&内容检索

## 正则表达式注意的地方

- 花括号之前要加转义字符 `[a-z]\{3\}`
- 空格就是转义加空格`\ `，而不是`\s` 。如 `[a-z0-9_\ ]\{3,\}`
- 这几个符号 `_ - . #`都不需要加转义符。
- 不要轻易加==行结束符==$，可能回车才是最后符号，所以可能找不到。

<!-- more -->

## grep

```sh
# -r 递归搜索子目录
# -l 只显示文件
# -n 显示文件和匹配的行
# 搜索 “markdown” 字符串并输入到文件里
# Formating the Results...
grep $begrif $directory $args |awk '{ print "[" $1 "](" $1 ")\n" }' > suchergebnisse.md
# 将结果转为Windows目录
sed -i -- 's/\/D\//D:\/\//g' suchergebnisse.md
echo "Fertig! Ergebnisse siehe Datei 'suchergebnisse.md'"
read
```

[更多参数请读此文](https://blog.csdn.net/u013485792/article/details/52243479) 示例脚本

`grep` 正则表达式的例子

```sh
#!bin/bash
# {#part0000_split_050.html#nav_point-99 .calibre13}
result=$(grep  '{#part0000_split_[0-9]\{3\}.html[a-z0-9_\ -.#]\{3,\}calibre13}' 文件名)

if [ "$result" = "" ];
then
	echo "Nichts gefunden!"
fi

echo $result
read
```

grep或操作

```sh
grep -E '123|abc' filename  // 找出文件（filename）中包含123或者包含abc的行
egrep '123|abc' filename    // 用egrep同样可以实现
awk '/123|abc/' filename   // awk 的实现方式
```

grep与操作

```sh
grep pattern1 files | grep pattern2 //显示既匹配 pattern1 又匹配 pattern2 的行。
```

其它常用选项

```sh
grep -i pattern files   //不区分大小写地搜索。默认情况区分大小写，
grep -l pattern files   //只列出匹配的文件名，
grep -L pattern files   //列出不匹配的文件名，
grep -w pattern files  //只匹配整个单词，而不是字符串的一部分（如匹配‘magic’，而不是‘magical’），
grep -C number pattern files //匹配的上下文分别显示[number]行，
```

{% fold 点击显/隐代码 %}

<script src="https://gist.github.com/maiernte/121484228f141b714cbf4be39d59c69d.js"></script>
{% endfold %}

## sed 命令

[参考文献](https://man.linuxde.net/sed)

### 文本替代

以下文本替换通过`pandoc`导入后的文件，残留很多内部跳转链接：如

```sh
{#part0000_split_003.html#nav_point_1 .not-in-toc}
```



```bash
#!bin/bash
echo running
#sed  's/^#part0000_split_$/p' -f ../Linux_shell_Anleitung.md ;
sed -i -- 's/^\[\]{#part0000_split_[0-9]\{3\}.html}$//g' ../Linux_shell_Anleitung.md 

#{#part0000_split_017.html#nav_point_21 .calibre8}  {#part0000_split_003.html#nav_point_1 .not-in-toc}
sed -i -- 's/{#part0000_split_[0-9]\{3\}.html#[a-z0-9_-]\+ .[a-z0-9_-]\+}//g' ../Linux_shell_Anleitung.md 

echo fertig!
read
```

### 整行替代

[参考文献](https://www.cnblogs.com/wangqiguo/p/6718512.html)

替代以 `categories:` 开头的整行（允许行开头有空格或制表符）。`c` 代表整行，以字符串 *categories: [IE]* 替代整行。

```sh
# Linux 下的写法
sed -i -- '/^[[:blank:]]*categories:/c categories: [IE]' result.txt 
# Mac 下的写法
sed -i '' 's/^[[:blank:]]*tags:.*/tags: [心理]/' $1 
```

错误：如果将参数 `c` 写在前面，会将整个文本每一行都替换掉。

```sh
# Linux 下的写法
sed -i -- 'c/^[[:blank:]]*categories:/categories: [IE]/' result.txt 
```



## find

```sh
# 查找所有的 md 文件
find  /root/bibliothek/markdowns/blog_posts/  -type f -name "*.md" 
# 查找一天之前的文件， 一小时前时 -1h，一周 -1w
find . -type f -mtime -1d
```

如果要处理复杂的事情，就要用到函数

```sh
# 定义函数
showFileInfo(){
    echo $1
}

# 声明函数
export -f showFileInfo
# 使用函数
find $dirPath -name "*.md" | xargs -n 1 -P 10 -I {}  bash -c 'showFileInfo "$@"' _ {} \;
```



## 查找最新文件

- 将文件按从新到旧排列，取第一个。

  `ls -t *.cpp | head -1`

- 将文件按从旧到新排列，取最后一个。

  `ls -rt *.cpp | tail -1`

- 列出文件时间戳

  `ls -l simpleNode.js  |awk '{print  $6 "-" $7 "-" $8 }'`

- 整合以上两个命令，找到最新的文件，读取时间戳 

  `ls -t *.* | head -1 | xargs ls -l | awk '{print  $6 "-" $7 "-" $8 }'`



# 字符串处理

[字符串处理参考文献](https://www.jianshu.com/p/5709118af1c6)    [将分隔符的字符串转为数组的几种方法](https://blog.csdn.net/Jerry_1126/article/details/83930956)

配合使用，可以直接用 shell 实现文件内标签和分类的替换。

## 数组转字符串

使用分隔符将数组转字符串：

```sh
ids=(1 2 3 4); 
lst=$( IFS='/'; echo "${ids[*]}" ); 
echo $lst
# 结果是：1/2/3/4
```

## 字符串转数组

[懒得写，看范例](https://blog.csdn.net/Jerry_1126/article/details/83930956)

## 字符串替换

```sh
# 原串 [娱乐,经济,重要] => 目标串 [娱乐, 经济, 重要]
${tags/,/, }  # 只替换了一个，结果变成 [娱乐, 经济,重要]
${tags//,/, } # 替换了所有符合的，结果变成 [娱乐, 经济, 重要]
# 原串 [重要] => 目标串 重要
${tags//[\[\] ]/}
```

### 消除回车符、换行符、制表符

```sh
# arg是个字符串变量， 可能带有回车符\r
# 把它整个作为参数使用会带来很多麻烦。用以下命令将其替换掉
newvar=${arg//[$'\t\r\n']/}
```



## 详细用法

[参考文献](https://blog.csdn.net/ljianhui/article/details/43128465)

1. `${var##*/}`
该命令的作用是去掉变量var从左边算起的最后一个'/'字符及其左边的内容，返回从左边算起的最后一个'/'（不含该字符）的右边的内容。使用例子及结果如下：

```sh
var=dir1/dir2/file.txt 
--> file.txt
```

从运行结果可以看到，使用该命令，可以提取出我们需要的文件名*file.txt*。

若使用时在shell程序文件中，可以使用变量来保存这个结果，再加以利用，如file=`${var##*/}`

2. `${var##*.}`
该命令的作用是去掉变量var从左边算起的最后一个'.'字符及其左边的内容，返回从左边算起的最后一个'.'（不含该字符）的右边的内容。使用例子及结果如下：

```sh
var=dir1/dir2/file.txt 
--> txt
```

从运行结果可以看到，使用该命令，可以提取出我们需要的文件后缀。

如果文件的后缀不仅有一个，例如，file.tar.gz，命令`${var##*.}`仅能提取最后一个后缀，而我想提取tar.gz时该怎么办？那么就要用下面所说的`${var#*.}`命令了。

3. `${var#*.}`
该命令的作用是去掉变量var从左边算起的第一个'.'字符及其左边的内容，返回从左边算起第一个'.'（不含该字符）的右边部分的内容。使用例子及结果如下：

```sh
var=dir1/dir2/file.tar.gz 
--> tar.gz
```

从运行结果可以看到，使用该命令，可以提取出文件的多个后缀。

4. `${var%/*}`
    该命令的使用是去掉变量var从右边算起的第一个'/'字符及其右边的内容，返回从右边算起的第一个'/'（不含该字符）的左边的内容。使用例子及结果如下：

```sh
var=dir1/dir2/file.txt 
--> dir1/dir2
```



从运行的结果可以看到，使用该命令，可以提取出我们需要的文件所在的目录

5. `${var%%.*}`
该命令的使用是去掉变量var从右边算起的最后一个'.'字符及其右边的内容，返回从右边算起的最后一个'.'（不含该字符）的左边的内容。使用例子及结果如下：

```sh
var=dir1/dir2/file.txt 
--> dir1/dir2/file
```

当我们需要建立一个与文件名相同名字（没有后缀）的目录与对应的文件相对应时，就可以使用该命令来进行操作。例如，解压文件的情况就与此类似，我们压缩文件file.zip时，会在与file.zip同级目录下建立一个名为file的目录。

6. 总结

  其实${}并不是专门为提取文件名或目录名的，它的使用是变量的提取和替换等等操作，它可以提取非常多的内容，并不一定是上面五个例子中的'/'或'.'。也就是说，上面的使用方法只是它使用的一个特例。



看到上面的这些命令，可能会让人感到非常难以理解和记忆，其实不然，它们都是有规律的。

- \#：表示从左边算起第一个

- %：表示从右边算起第一个

- \##：表示从左边算起最后一个

- %%：表示从右边算起最后一个

换句话来说，＃总是表示左边算起，％总是表示右边算起。

＊：表示要删除的内容，对于#和##的情况，它位于指定的字符（例子中的'/'和'.'）的左边，表于删除指定字符及其左边的内容；对于%和%%的情况，它位于指定的字符（例子中的'/'和'.'）的右边，表示删除指定字符及其右边的内容。这里的'*'的位置不能互换，即不能把*号放在#或##的右边，反之亦然。

例如：`${var%%x*}`表示找出从右边算起最后一个字符x，并删除字符x及其右边的字符。

看到这里，就可以知道，其实该命令的用途非常广泛，上面只是指针文件名和目录名的命名特性来进行提取的一些特例而已。

## basename和dirname

`${}`并不是专门为提取文件名和目录名设计的命令，那么`basename`和`dirname`命令就是专门为做这一件事而已准备的了。

1. `basename`
    该命令的作用是从路径中提取出文件名，使用方法为basename NAME [SUFFIX]。

  1.1 从路径中提出出文件名（带后缀），例子如下：

  1.2 从上面命令的用法中可以看到，后缀（SUFFIX）是一个可选项。所以，若只想提取出文件名file，而不带有后缀，还可以在变量的后面加上后缀名，例子如下：


2. `dirname`
该命令的作用是从路径中提取出目录名，使用方法为 dirname NAME。使用例子如下：

这样就提取出了file.txt文件所在的目录。

注：该命令不仅能提取出普通文件所的目录，它能提取出任何文件所在的目录，例如目录所在的目录，如下：

它提取出了目录dir2所在的目录dir1.

---------------------



# 查看硬盘剩余空间

```sh
# 整个硬盘空间
df -hl
# 查看某个文件夹大小
du -h   your_directory # 列出每个子文件夹大小
du -hcs your_directory # 汇总
```



## 查看 package 版本

```sh
apt-cache show packagename
```



# Windwos 下的脚本

windows 下显示环境变量

`echo %http_proxy%`

windows 下设置代理服务器
$$

$$

```sh
set http_proxy=http://username:pwd$$$@proxy-rzf:8080
set https_proxy=http://username:pwd$$$@proxy-rzf:8080
```

