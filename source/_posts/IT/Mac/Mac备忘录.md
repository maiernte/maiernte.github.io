---
title: Mac备忘录
date: 2019-07-22 18:47:47
urlname: mac-memo
toc: true
tags: [Mac]
categories: [IT, Mac]
notshow: true

---

# 指令和任务

## 隐藏文件夹

Terminal 命令

```bash
//显示隐藏文件
defaults write com.apple.finder AppleShowAllFiles -bool true
//不显示隐藏文件
defaults write com.apple.finder AppleShowAllFiles -bool false
```

快速命令，打开访达窗口，然后 ⌘ + ⇧ + .  就可以隐藏/显示。



需要重启Finder使设置生效 :

> 重启Finder：窗口左上角的苹果标志-->强制退出-->Finder-->重新启动

## 允许任何来源软件

系统默认在 **安全与隐私** 里只显示 “App Store” 和 “App Store 和被认可的开发者”，没有 “任何来源”。开启的话需要在终端输入

`sudo spctl --master-disable` 

并输入开机密码。



## 任务控制

- 将任务放在后台运行：`command + &` 

- 将任务丢到后台暂停：`ctrl-z` 

- 查看后台所有任务状态：`jobs -l`  (会列出 1、2、3序列号)

- 将后台的任务拿到前台处理：`fg %jobnumber`  (指序列号，而不是任务id)

- 将后台的任务变成运行中：`bg %jobnumber` 

- 管理后台当中的任务：`kill -signal %jobnumber`

# 文件管理

## 标签的使用

参看 [mac 标签的使用](mac-using-tags.html)

# 通用技巧

## 输入法

### 查看按键字符

1. 偏好设置 → 键盘 → 输入法，窗口右面会显示键盘⌨️图案，按住shift⇧键或者option⌥，会显示在不同功能键下面的字符。



## 通过Automator添加快捷键

[文章来源](https://zhidao.baidu.com/question/1514898183998822540.html)

1. 一次打开 ***Finder —> 应用程序 —> automator***
2. 选取 ***服务***
3. 从左边的双栏选取 ***使用工具—>运行AppleScript***， 并双击运行。
4. 出现文本框后选定（右栏最上边）***没有输入***

```objective-c
on run {input, parameters}
    (* Your script goes here *)
    tell application "Safari"
        reopen
        activate
        end tell
end run
```

5. ⌘+S 保存，命名为 *Open Safari*。关闭automator
6. 转到 ***系统偏好设置—>键盘—>快捷键—>服务—>通用—>open safari*** ，然后设定快捷键就好了。



## 电源管理

`pmset`是**macOS**下用来操作、电源管理的工具，可设定休眠模式、时间和唤醒时间或显示电源信息，不过因为它是一个命令列的指令，因此得透过终端机察看或修改设定。当你开启「终端机」输入p`mset -g` 会看到具体设置。

- `Standbydelay 28800` ：将系统储存于內存中休眠，会消耗一些电力。
- `Autopowerofdelay 28800` ：  把系统写入SSD硬盘中，将內存暂存关闭，依照这篇文章的说法，两者延迟时间28800秒（约八小时）会让电脑多维持內存八小时左右的电力。
- `tcpkeepalive` ：设定睡眠后是否还保持网络连接， 以便可以透过TCP唤醒系统
- `hibernatemode` ：睡眠模式。数字越小，耗电越高。可以设置为 25

```sh
sudo pmset -b autopoweroffdelay 300 # 将睡眠时间缩短为300秒（五分钟）
sudo pmset -b standbydelay 300 # 然后将系统储存到SSD硬盘
sudo pmset -b tcpkeepalive 0 # 将透过TCP唤醒系统的功能关闭
sudo pmset -a hibernatemode 25 
```

>   中间的参数-b是使用电池下的参数，-c为外接电源下的参数设定， -a 为所有情况下的设定。



## 升级到Mojave后鼠标发飘

前往***偏好设置-->网络-->设定服务顺序(左下角齿轮)***，然后将***蓝牙PAN***拖到最上面。



# 网络资源

## 应用软件

1. 大量破解资源分享的网站 [MacEnjoy](https://www.macenjoy.co/)

## 在线文档

[iMac 2012 规格](https://support.apple.com/kb/SP665?locale=zh_CN&viewlocale=zh_CN)

### 升级SSD固态硬盘

[iMac 2012 21.5吋 拆卸指南](https://zh.ifixit.com/Teardown/iMac+Intel+21.5-Inch+EMC+2544+Teardown/11936)

[Mac升级外挂SSD硬盘](https://luolei.org/imac-5k-external-usb-ssd-update/)

[如何选择另一个启动磁盘](https://support.apple.com/zh-cn/HT202796) <font color=gray>:pen: <i>官方说明</i></font>

[更换SSD固态硬盘攻略](http://www.mac52ipod.cn/post/apple-mac-macbook-pro-change-ssd-hardisk-tutorial.php)

1. 固态硬盘通过USB 3连接到电脑，并格式化成 **Mac OS 扩展** 格式。

   ![](http://www.mac52ipod.cn/attachment.php?fid=5823)

2. 用 Carbon Copy Cloner（[官网下载](https://bombich.com/)）把原硬盘的数据镜像到 SSD。完成后要制作恢复分区「Recovery HD」[破解版下载地址](https://www.macenjoy.co/blog/carbon-copy-cloner-for-mac-v5-1-9)

   或者 [SuperDuper](https://www.shirt-pocket.com/SuperDuper/SuperDuperDescription.html) <font color=gray>:pen: <i>免费版可以全盘备份，而不支持增量操作。</i></font>

   ![](http://www.mac52ipod.cn/attachment.php?fid=5824)

3. 重启，听到 「当 」一声后按住 `Option` 键(windows 键盘上的 Alt)。然后选择SSD作为启动硬盘。

4. 开机后用 **Trim Enabler**（[官网下载](http://www.cindori.org/software/trimenabler/)）开启 **Trim** 读写加速。:+1: