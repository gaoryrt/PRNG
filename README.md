# *非特殊情况不再更新*  
这是当时全国密码学大赛的作品  
要是有需求的话会继续跟进  
在此之前非特殊情况不会更新  
![logo](http://ww1.sinaimg.cn/large/a243ad6cjw1ezhszdvg72j21hc0u075n.jpg)
# PRNG - Pseudo Random Number Generator
## 简介
iOS 端  
基于 hash 链的伪随机数发生器  
以及一个验证码生成的demo  
## 有什么功能  
可自定义选择任意的三轴陀螺仪的信息作为种子源  
可编辑种子信息与迭代次数  
可选多种哈希算法，完成了hash链、ANSI X9.17、随机化迭代、扩展随机化迭代四种方式的伪随机数发生功能  
生成可选的十六进制或二进制数输出  
## 什么可以用于参考
swift 与 OC 混合使用的 bridge  
UITableViewController 跳转与传值  
不同类型的 UITableViewCell   
使用 delegate 在 UITableViewController 间反向传值  
## 自己能力不够  
种子选择界面看上去是一个 cell，其实是自己组装上去的。。。  
没有开 autolayout，手动组装一个 cell table 还是挺简单的    
并不会使用图片库，验证码图片其实是随机的字体、倾斜角度、y轴高度、不同字母以及不同背景图片的组合  
**理科生就是要会想办法，哈哈哈**

## 安装需求
1.  7.x 版本的 xcode 软件  

2.  9.x 版本的 iOS 设备  

3.  大概知道什么是 [sideload](http://bouk.co/blog/sideload-iphone/)  

## 怎么安装  
1.  下载使用 xcode 打开

2.  插上你的手机

3.  在 device menu 中选中你的手机，然后点击“Play”的三角形按钮  

## 具体效果
见图  
![](http://ww2.sinaimg.cn/large/a243ad6cjw1ezhtlq0i88j20gg0re41f.jpg)
![](http://ww2.sinaimg.cn/large/a243ad6cjw1ezhtlssu18j20gg0ren09.jpg)
![](http://ww4.sinaimg.cn/large/a243ad6cjw1ezhtlvdd3qj20gg0rewh1.jpg)
![](http://ww1.sinaimg.cn/large/a243ad6cjw1ezhtlxsbj2j20gg0reabb.jpg)
![](http://ww4.sinaimg.cn/large/a243ad6cjw1ezhtm45pjtj20gg0rejuw.jpg)
![](http://ww2.sinaimg.cn/large/a243ad6cjw1ezhtm6hm59j20gg0ret9j.jpg)
![](http://ww1.sinaimg.cn/large/a243ad6cjw1ezhtm8e77vj20gg0regn1.jpg)
![](http://ww1.sinaimg.cn/large/a243ad6cjw1ezhtmaw182j20gg0rewfx.jpg)
![](http://ww4.sinaimg.cn/large/a243ad6cjw1ezhtmdo2ocj20gg0reacd.jpg)
![](http://ww1.sinaimg.cn/large/a243ad6cjw1ezhtmgnfraj20gg0redhd.jpg)
